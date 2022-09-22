<?php
/**
 * Created by
 * User BaiXiantao
 * Date 2020/12/5
 * Time 23:51
 */

namespace app\admin\controller;


use app\Request;
use think\Exception;
use think\facade\Db;
use \think\facade\View;

class Admin extends Common
{

    // public function index(){
    //     $adminlist = Db::name('admin')->paginate(10);
    //     // 获取分页显示
    //     $page = $adminlist->render();
    //     view::assign('adminlist',$adminlist);
    //     view::assign('page',$page);
    //     return view();
    // }

    #管理员列表
    public function index()
    {
        if (request()->isAjax()){
            // $group_list = Db::name('admin')->where('is_delete', 0)->select();
            $group_list = Db::name('admin')->select();
            $power_team = Db::name('auth_group')->field('id,title')->select();
            $power_team = cms_rebuild($power_team, 'id');
            foreach ($group_list as $k=>$v) {
                $v['power_team'] = $power_team[$v['power_team']]['title'];
				$v['login_time'] = !empty($v['login_time']) ? date('Y-m-d H:i:s', $v['login_time']) : '';
				$v['create_time'] = $v['create_time'] > 0 ? date('Y-m-d H:i:s', $v['create_time']) : '';
                $group_list[$k] = $v;
            }
            //view::assign('group_list', $group_list);
            return ajaxTable(0,'',$group_list);
        }

        return view::fetch();
    }

    #管理员添加
    public function add()
    {
        if (request()->isAjax()) {
            $data = $_POST;
            $admin_name = $data['admin_name'];
            $is_exit = Db::name('admin')->where(['admin_name' => $admin_name])->find();
            if (!empty($is_exit)) {
                return ajaxTable(0, '已经存在');
            }
            #验证两次密码
            if ($data['admin_pwd'] != $data['admin_pwd2']){
                return ajaxTable(1, '两次密码不一致');
            }
            unset($data['admin_pwd2']);

            #密码
            $pass =$data['admin_pwd'];
            $data['admin_pwd'] = password_hash($pass, PASSWORD_DEFAULT);
			$data['create_time'] = time();
			
            $res_id = Db::name('admin')->insertGetId($data);
            if ($res_id) {
                $power_team = $data['power_team'];
                Db::name('auth_group_access')->insert(['uid'=>$res_id,'group_id'=>$power_team]);
                $this->ULog("添加了管理员");
                return ajaxTable(0);
            } else {
                return ajaxTable(1);
            }
        }
        $power_team = Db::name('auth_group')->field('id,title')->select();
        view::assign('power_team',$power_team);
        return view::fetch();
    }

    #管理员保存
    public function edit()
    {
        if (request()->isAjax()) {
            $data = input();
            $id = $data['id'];
            unset($data['s']);
			#验证两次密码
			if (isset($data['admin_pwd']) && !empty($data['admin_pwd'])) {
				if ($data['admin_pwd'] != $data['admin_pwd2']) {
					return ajaxTable(1, '两次密码不一致');
				}
				unset($data['admin_pwd2']);
				#密码盐值
				$pass = $data['admin_pwd'];
				$data['admin_pwd'] = password_hash($pass, PASSWORD_DEFAULT);
			} else {
				unset($data['admin_pwd']);
				unset($data['admin_pwd2']);
			}
	
			Db::startTrans();
			try{
				Db::name('admin')->where(['id' => $id])->update($data);
				Db::name('auth_group_access')->where(['uid'=>$id])->update(['group_id' => $data['power_team']]);
				Db::commit();
                $this->ULog("修改了管理员");
				return ajaxTable(0);
			} catch (\Exception $e) {
				// 回滚事务
				Db::rollback();
				return ajaxTable(1);
			}
        }

        $id = input('id');
        $data = Db::name('admin')->where(['id' => $id])->find();
        view::assign('data',$data);
        $power_team = Db::name('auth_group')->field('id,title')->select();
        view::assign('power_team',$power_team);
        return view::fetch();
    }

    #管理员删除
    public function del()
    {
        if (request()->isAjax()) {
            $id = $_POST['id'];
            $res = Db::name('admin')->where(['id' => $id])->update(['is_delete' => 0]);
            if ($res) {
                $this->ULog("删除了管理员");
                return ajaxTable(0);
            } else {
                #write_log("删除失败:","Admin","Error");
                return ajaxTable(1);
            }
        }
    }

    public function uppass(){
        if (request()->isAjax()) {
            $id = input('id');
            $admin_pwd = input('admin_pwd');
            if ($admin_pwd){
                #密码盐值
                // $admin_pwd = md5($admin_pwd);
				$admin_pwd = password_hash($admin_pwd, PASSWORD_DEFAULT);
                // $res = Db::name('admin')->where(['id' => $id])->update(['admin_pwd' => $admin_pwd,'pwd_hash'=>$pwd_hash]);
                $res = Db::name('admin')->where(['id' => $id])->update(['admin_pwd' => $admin_pwd]);
                if ($res) {
                    $this->ULog("修改了密码");
                    return ajaxTable(0);
                } else {
                    #write_log("删除失败:","Admin","Error");
                    return ajaxTable(1);
                }
            }
            return ajaxTable(1);
        }
        // $id = input('id');
        $id = 1;
        $data = Db::name('admin')->where(['id' => $id])->find();
        view::assign('data',$data);
        return view::fetch();
    }

    #操作日志
    public function adminlog()
    {
        if (\request()->isAjax()) {
            $page = input('page');
            $limit = input('limit');

            $log_list = Db::name('admin_log')->page($page,$limit)->order('id desc')->select();
            foreach ($log_list as $key => $value) {
                $value['admin_name']    = Db::name('admin')->where(['id' => $value['admin_id']])->value('admin_name');
                $value['type']        = 1 ? '登录日志' : '操作日志';
                $value['create_time'] = date('Y-m-d H:i', $value['create_time']);
                $log_list[$key]       = $value;
            }
            return ajaxTable(0,'',$log_list);
        }

        return View::fetch();
    }
}