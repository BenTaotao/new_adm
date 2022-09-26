<?php
declare (strict_types=1);
/**
 * Created by
 * User BaiXiantao
 * Date 2020/12/5
 * Time 23:51
 */

namespace app\admin\controller;


use think\facade\Db;
use think\facade\Session;
use think\facade\View;

class Login
{
	public function __construct()
	{
		#这不需要，临时关闭布局
		View::engine()->layout(false);
		$site_name = Config::site_name();
		View::assign('site_name', $site_name);
	}
	
	public function index()
	{
        Session::delete('admin');
		return view();
	}
	
	public function login()
	{
		if (!$_POST) {
			return json(['code' => 1, 'msg' => "非法请求"]);
		}
		
		$name = input("name");
		$pass = input("pass");
		// $pass = md5($pass);
		
		$admin_info = Db::name('admin')->where(['admin_name' => $name])->find();
		
		
		$is_true = password_verify($pass, $admin_info['admin_pwd']);
		
		if (!empty($admin_info)) {
			if ($is_true) {
				if (!$admin_info['is_delete']) {
					return json(['code' => 1, 'msg' => "该账户已冻结"]);
				}
				//登录成功,判断当前用户组是否可以正常登录
				$auth_group_id = $admin_info['power_team'];
				//根据权限组ID,查询此权限组赋予的权限
				$pwoerList = Db::name('auth_group')->field('rules')
                    ->where(['id' => $auth_group_id, 'status' => 1])->find();
				$pwoerList = isset($pwoerList['rules']) ? $pwoerList['rules'] : [];
				if (empty($pwoerList)) {
					return json(['code' => 1, 'msg' => "没有权限访问"]);
				}
				$outime = time() + 3600;
				$login_str = md5(date('Y-m-d H:i:s', time()) . rand(1000, 9999));
				session('admin.outime', $outime);//登录过期时间  默认登录1小时过期
				session('admin.lasttime', time()); //最近操作的时间
				$data_update = array(
					'login_ip' => get_client_ip(),
					'login_time' => time(),
					'login_str' => $login_str
				);
				
				Db::name('admin')->where(['id' => $admin_info['id']])->update($data_update);
				// Db::name('admin')->where(['id' => $admin_info['id']])->inc();
				#记录登录日志
				Db::name('admin_log')->insert(['admin_id' => $admin_info['id'], 'type' => 1, 'content' => '[' . $admin_info['admin_name'] . '] 登录', 'create_time' => time(), 'ip' => get_client_ip()]);
				session('admin.info', $admin_info);
				session('admin.login_str', $login_str);
				return json(['code' => 0, 'msg' => "登录成功"]);
			} else {
				return json(['code' => 1, 'msg' => "密码错误"]);
			}
		} else {
			return json(['code' => 1, 'msg' => "管理员不存在"]);
		}
		
	}
	
	public function login_out()
	{
        Session::delete('admin');

        #session后面不能跟exit、die、redirect等傻逼的函数，跟了就删不掉session，所以直接在index写了删session
		return redirect('/admin/login/index');
	}
	
	
}