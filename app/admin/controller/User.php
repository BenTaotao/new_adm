<?php
/**
 * User BaiXiantao
 * Date 2021/12/16
 * Time 17:46
 */

namespace app\admin\controller;

use think\facade\Db;
use think\facade\View;

class User extends Common
{
	
	public function index()
	{
		if (request()->isAjax()){
			$user_list = Db::name('user')->order('id desc')->select();
		
			return ajaxTable(0,'',$user_list);
		}
		
		return view::fetch();
	}
	
	public function add()
    {
        if (request()->isAjax()) {
            $data = $_POST;
            $name = $data['name'];
            unset($data['s']);
			if ($data['password'] != $data['password2']) {
				return ajaxTable(1, '两次密码不一致');
			}

            $info = Db::name('user')->where(['name' => $name])->find();
            if (isset($info)) {
                return ajaxTable(0, '已经存在');
            }

			unset($data['password2']);

            #密码
            $pass =$data['password'];
            $data['password'] = password_hash($pass, PASSWORD_DEFAULT);
			$data['register_time'] = time();

			// halt($data);
            Db::startTrans();
            try{
                Db::name('user')->insert($data);
                Db::commit();
                return ajaxTable(0);
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                return ajaxTable(1);
            }

        }
        return view::fetch();
    }

    #人员修改
    public function edit()
    {
        if (request()->isAjax()) {
            $data = input();
            $id = $data['id'];
            unset($data['s']);
    		#验证两次密码
			if (isset($data['password']) && !empty($data['password'])) {
				if ($data['password'] != $data['password2']) {
					return ajaxTable(1, '两次密码不一致');
				}
				unset($data['password2']);
				#密码盐值
				$pass = $data['password'];
				$data['password'] = password_hash($pass, PASSWORD_DEFAULT);
			} else {
				unset($data['password']);
				unset($data['password2']);
			}
	
            Db::startTrans();
            try{
                Db::name('user')->where(['id' => $id])->update($data);
                Db::commit();
                return ajaxTable(0);
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                return ajaxTable(1);
            }
        }

        $id = input('id');
        $data = Db::name('user')->where(['id' => $id])->find();
        view::assign('data',$data);
        return view::fetch();
    }

    #人员删除
    public function del()
    {
        if (request()->isAjax()) {
            $id = $_POST['id'];
            $res = Db::name('user')->where(['id' => $id])->delete();
            if ($res) {
                return ajaxTable(0);
            } else {
                return ajaxTable(1);
            }
        }
    }
}