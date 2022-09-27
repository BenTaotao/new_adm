<?php
declare (strict_types=1);
/**
 * Created by
 * User BaiXiantao
 * Date 2020/12/7
 * Time 23:47
 */

namespace app\admin\controller;

use think\facade\App;
use think\facade\Db;
use think\facade\Log;
use think\facade\Session;
use think\route\Rule;
use think\wenhainan\Auth;
use think\facade\View;

class Common
{
	
	public function __construct()
	{
		// $this->initperm();#更新菜单
		$site_name = Config::site_name();
		View::assign('site_name', $site_name);
		self::auth();//权限验证
		self::initialize(); #提取菜单
	}
	
	#验证权限
	public function auth()
	{
		$Admin_outime = session('admin.outime');
		$admin_info = session('admin.info');
		
		
		session("admin.name", $admin_info['admin_name']);
		session("admin.id", $admin_info['id']);
		session('admin.truename', $admin_info['truename']);
		
		#检查权限
		$app_name = app('http')->getName();
		$controller = strtolower(request()->controller());
		$action = strtolower(request()->action());
		$auth = Auth::instance();
		#验证是否为超级管理员，超级管理员不限制
		if ($admin_info['power_team'] == 1) {
			Log::info("操作记录:" . $controller . '/' . $action . " 操作人信息:[id:" . $admin_info['id'] . ',admin_name:' . $admin_info['admin_name'] . ']');
			return true;
		}
		#首页则不需要验证
		if ($controller == "index") {
			return true;
		}
		#其他不需要验证权限的方法
		$nocheckauth = ['auth/fun', 'admin/uppass','survey/printall','survey/detail','survey/answer_detail'];
		$current = strtolower($controller . '/' . $action);
		if (in_array($current, $nocheckauth)) {
			return true;
		}
		// 检测权限
		// if (!$auth->check($app_name . '/' . $controller . '/' . $action, $admin_info['id'])) {
		if (!$this->authcheck($app_name . '/' . $controller . '/' . $action, $admin_info['id'])) {
			// 第一个参数是规则名称,第二个参数是用户UID
			//有显示操作按钮的权限
			print_r("<script src='/static/admin/layui272/layui.js'></script>
								<script type='text/javascript'>
								top.layer.msg('没有权限', {time: 3000 //2秒关闭（如果不配置，默认是3秒）
								}, function(){parent.location.reload();});
								</script>");
			die();
		}
		return true;
	}

    #菜单验证权限
    private function authcheck($name,$id){
        $auth_rule_id = Db::name('auth_rule')->where(['name'=>$name])->value('id');
        $auth_group_id = Db::name('auth_group_access')->where(['uid'=>$id])->value('group_id');
        $rules_list = Db::name('auth_group')->where(['id'=>$auth_group_id])->field('rules')->find();
        $rules_arr = explode(',', $rules_list['rules']);
        if (in_array($auth_rule_id, $rules_arr)){
            return true;
        }
        return false;
    }

	#这里是公共的模板数据--菜单等
	public function initialize()
	{
		#menu
		$admin_info = session('admin.info');
		$admin_id = $admin_info['id'];
		$power_team = $admin_info['power_team'];
		$auth_group_id = Db::name('auth_group_access')->where(['uid' => $admin_id])->find();

        if(!$auth_group_id) {
            echo "权限错误，请联系管理员";
            die();
        }

		$auth_group = Db::name('auth_group')->where(['status' => 1])->where(['id' => $auth_group_id['group_id']])->find();
		$rule_list = explode(',', $auth_group['rules']);
		if ($power_team === 1) { ##这里如果是超级管理员则抛出所有菜单
			$menu_list = Db::name('auth_rule')->where(['status' => 1])->field('id,name,title,parent,icon,sort,type')->order('sort asc')->select()->toArray();
		} else {
			$menu_list = Db::name('auth_rule')->where(['status' => 1])->where('id', 'in', $rule_list)->field('id,name,title,parent,icon,sort,type')->order('sort asc')->select()->toArray();
		}
		#数组重组
		$tree = getTree($menu_list, 0);
		view::assign('tree', $tree);
		$first_tree = reset($tree);
		
		$tree = procHtml($tree, $first_tree['id']);
		
		cache('tree', $tree, array('type' => 'file', 'expire' => 86400)); //
		
		#名称
		$adminname = $admin_info['truename'] ?? '';
		view::assign('adminname', $adminname);
		view::assign('admin_info', $admin_info);
		
		#尾部数据输出
		$year = date('Y', time());
		View::assign('year', $year);
	}
	
	/**
	 * 404返回~异常处理
	 *
	 * @param $name
	 * @param $arguments
	 * @return \think\response\Json
	 */
	public function __call($name, $arguments)
	{
		// 如果是API模块，需要输出API的数据格式（一般是json）
		// 如果是模板引擎的方式，需要输出自定义错误页面
		// $result = [
		//     'status' => 0,
		//     'message' => '找不到该方法',
		//     'result' => null
		// ];
		// return json($result, 400);
		// App::http_exception_template();
		app()->getThinkPath() . 'tpl/think_exception.tpl';
		die();
	}
	
	#操作日志
	public function ULog(string $content = '')
	{
		$data = [
			'admin_id' => session("admin.id"),
			'type' => 2,
			'content' => $content,
			'create_time' => time(),
			'ip' => get_client_ip()
		];
		Db::name('admin_log')->insert($data);
	}
	
	//获取模块下所有的控制器和方法
	public function initperm()
	{
		$module = 'admin';  //模块名称
		
		$all_controller = $this->getController($module);
		if (!is_array($all_controller)) return true;
		for ($i = 0; $i < count($all_controller); $i++) {
			$all_action = $this->getAction($all_controller[$i]);
			if (!is_array($all_action)) continue;
			for ($j = 0; $j < count($all_action); $j++) {
				$data['module'] = $module;
				$data['controller'] = $all_controller[$i];
				$data['action'] = $all_action[$j];
				$rule_name = $module . '/' . $all_controller[$i] . '/' . $all_action[$j];
				$data['name'] = strtolower($rule_name);
				$isset = Db::name('auth_rule')->where(['name' => $rule_name])->find();
				if (!$isset) {
					Db::name('auth_rule')->insert($data);
				}
			}
		}
	}
	
	
	//获取所有控制器名称
	public function getController($module)
	{
		if (empty($module)) {
			return null;
		}
		
		$module_path = app_path() . "/controller/";  //控制器路径
		if (!is_dir($module_path)) {
			return null;
		}
		$module_path .= '/*.php';
		$ary_files = glob($module_path);
		
		foreach ($ary_files as $file) {
			if (is_dir($file)) {
				continue;
			} else {
				$files[] = basename($file, '.php');
			}
		}
		#将Common公共控制器排除
		foreach ($files as $k => $v) {
			if ('Common' == $v) unset($files[$k]);
			// if ('Test' == $v) unset($files[$k]);
			// if ('Login' == $v) unset($files[$k]);
			// if ('Config' == $v) unset($files[$k]);
		}
		$files = array_values($files);
		return $files;
	}
	
	
	//获取所有方法名称
	public function getAction($controller)
	{
		if (empty($controller)) {
			return null;
		}
		$customer_functions = [];
		$file = app_path() . '/controller/' . $controller . '.php';
		if (file_exists($file)) {
			$content = file_get_contents($file);
			preg_match_all("/.*?public.*?function(.*?)\(.*?\)/i", $content, $matches);
			$functions = $matches[1];
			//排除部分方法
			$inherents_functions = array('_initialize', 'initialize', '__construct', 'auth', 'getFun', 'getActionName', 'isAjax', 'display', 'show', 'fetch', 'buildHtml', 'assign', '__set', 'get', '__get', '__isset', '__call', 'error', 'success', 'ajaxReturn', 'redirect', '__destruct', '_empty');
			foreach ($functions as $func) {
				$func = trim($func);
				if (!in_array($func, $inherents_functions)) {
					$customer_functions[] = $func;
				}
			}
			return $customer_functions;
		} else {
			//            \ticky\Log::record('is not file ' . $file, Log::INFO);
			return false;
		}
	}
	
	
}