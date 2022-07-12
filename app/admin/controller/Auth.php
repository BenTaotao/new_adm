<?php


namespace app\admin\controller;


use app\admin\model\Admin;
use think\db\exception\DbException;
use think\facade\Db;
use think\facade\View as view;

//use think\Loader;
use think\Request;

class Auth extends Common
{
	protected $auths = '';
	
	#权限组列表
	public function index()
	{
		if (request()->isAjax()) {
			$group_list = Db::name('auth_group')->select();
			return ajaxTable(0, '', $group_list);
		}
		
		return view::fetch();
	}
	
	#权限组添加
	public function add()
	{
		if (request()->isAjax()) {
			$data = $_POST;
			$title = $data['title'];
			$is_exit = Db::name('auth_group')->where(['title' => $title])->find();
			if (!empty($is_exit)) {
				return ajaxTable(0, '已经存在');
			}
			$res = Db::name('auth_group')->insert($data);
			if ($res) {
				$this->ULog("添加了权限组：" . $title . "");
				return ajaxTable(0);
			} else {
				return ajaxTable(1);
			}
		}
		return view::fetch();
	}
	
	#权限组保存
	public function edit()
	{
		if (request()->isAjax()) {
			$data = input();
			$id = $data['id'];
			unset($data['s']);
			$res = Db::name('auth_group')->where(['id' => $id])->update($data);
			if ($res) {
				$this->ULog("修改了权限组：" . $data['title'] . "");
				return ajaxTable(0);
			} else {
				return ajaxTable(1);
			}
		}
		
		$id = input('id');
		$data = Db::name('auth_group')->where(['id' => $id])->find();
		view::assign('data', $data);
		return view::fetch();
	}
	
	#权限组删除
	public function del()
	{
		if (request()->isAjax()) {
			$id = input('id');
			$group_access = Db::name('auth_group_access')->select();
			
			foreach ($group_access as $list) {
				if (isset($list['group_id']) && $list['group_id'] == $id) {
					$admin = Db::name('admin')->where(['id' => $id])->find();
					return ajaxTable(0, '后台人员 “' . $admin['truename'] . '” 还在使用该组，请先变更该人员的权限组，再删除');
				}
			}
			
			$log = Db::name('auth_group')->where(['id' => $id])->value('title');
			$res = Db::name('auth_group')->where(['id' => $id])->delete();
			if ($res) {
				$this->ULog("删除了权限组：" . $log . "");
				return ajaxTable(0);
			} else {
				return ajaxTable(1);
			}
		}
	}
	
	#权限组规则
	public function rule()
	{
		$id = input('id', '');
		if (request()->isAjax()) {
			$menu_list = Db::name('auth_rule')->select();
			#数组重组
			$menu_list = getTree_children($menu_list, 0);
			$rule = Db::name('auth_group')->where('id', $id)->value('rules');
			$rule = explode(',', $rule);
			foreach ($menu_list as $k => $val) {
				if (in_array($val['id'], $rule)) {
					$val['checked'] = true;
					$val['spread'] = true;
				}
				if (is_array($val['children'])) {
					foreach ($val['children'] as &$vv) {
						if (in_array($vv['id'], $rule)) {
							$vv['checked'] = false;
						}
					}
				}
				$menu_list[$k] = $val;
			}
			return ajaxTable(0, '', $menu_list);
		}
		
		view::assign('id', $id);
		return view::fetch();
	}
	
	#权限组规则-保存
	public function rule_save()
	{
		if (request()->isAjax()) {
			$id = input('id');
			$id_arr = input('id_arr/a');
			#解析多维数组
			$this->getFun($id_arr);
			
			$res = Db::name('auth_group')->where('id', $id)->update(['rules' => $this->auths]);
			if (empty($res)) {
				return ajaxTable(1);
			} else {
				$this->ULog("修改了权限组规则");
				return ajaxTable(0);
			}
		}
	}
	
	public function getFun($a)
	{
		foreach ($a as $val) {
			if (is_array($val)) { //如果键值是数组，则进行函数递归调用
				if ($this->auths == '') {
					$this->auths = $val['id'];
				} else {
					$this->auths = $this->auths . ',' . $val['id'];
					// echo $val['id'].',';
				}
				if (isset($val['children']) && is_array($val['children'])) {
					self::getFun($val['children']);
				}
			}
		}
	}
	
}