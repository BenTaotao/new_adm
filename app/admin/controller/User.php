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
			$user_list = Db::name('user')->select();
			// $power_team = Db::name('auth_group')->field('id,title')->select();
			// $power_team = cms_rebuild($power_team, 'id');
			// foreach ($group_list as $k=>$v) {
			// 	$v['power_team'] = $power_team[$v['power_team']]['title'];
			// 	$group_list[$k] = $v;
			// }
			//view::assign('group_list', $group_list);
			return ajaxTable(0,'',$user_list);
		}
		
		return view::fetch();
	}
	
	#人员添加
	public function add()
	{
		
		
		return view::fetch();
	}
	
	#人员修改
	public function edit()
	{
	
	}
	
	#人员删除
	public function del()
	{
	
	}
}