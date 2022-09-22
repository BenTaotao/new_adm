<?php
/**
 * User BaiXiantao
 * Date 2021/12/10
 * Time 8:54
 */

namespace app\admin\controller;

use think\facade\Db;
use think\facade\View;

class Database extends Common
{
	public function index()
	{
		if (request()->isAjax()){
			$tables = Db::query("show tables");
			$dataBase = Db::query("show databases")[1]['Database'];
			$table_list = [];
			// $page = input('page',0);
			// $limit = input('limit',15);
			for ($i=0;$i<count($tables);$i++){
				$tableName = $tables[$i]['Tables_in_'.$dataBase];
				// 获取表信息
				$tableStatus = Db::query("SHOW TABLE STATUS FROM `{$dataBase}` WHERE name = '{$tableName}'");
				$table_list[$i] = $tableStatus[0];
			}
			$count = count($table_list);
			return ajaxTable(0,'',$table_list,$count);
		}
		return view::fetch();
	}
	
	public function add()
	{
		if (request()->isAjax()){
			$prefix = config('database.connections.mysql.prefix');
			$table_name = $prefix.$_POST['table_name'];
			$engine = $_POST['engine'];
			$sql = "CREATE TABLE IF NOT EXISTS `{$table_name}`(
    					`id` INT UNSIGNED AUTO_INCREMENT,
    					`create_time` INT(11) DEFAULT NULL COMMENT '创建时间',
   						PRIMARY KEY (`id`)
					)ENGINE={$engine} DEFAULT CHARSET=utf8";
			$res = Db::query($sql);
			if (empty($res)) {
                $this->ULog("添加了数据库表 {$table_name}");
				return ajaxTable(0, 'success',$res);
			} else {
				return ajaxTable(1, 'fail',$res);
			}
		}
		return view::fetch();
	}
	
	public function edit()
	{
		if (request()->isAjax()){
			$data = $_POST;
		}
		
		// $name = input('name');
		// //"这里写删除数据库表的语句";
		// $res = Db::query("SHOW TABLE {$name}");
		// halt($res);
		// View::assign('data',$res);
		return view::fetch();
	}
	
	public function del()
	{
		if (request()->isAjax()){
			$name = $_POST['name'];
			//"这里写删除数据库表的语句";
			$res = Db::query("DROP TABLE {$name}");
			if (empty($res)) {
                $this->ULog("删除了数据库表 {$name}");
				return ajaxTable(0, 'success');
			} else {
				return ajaxTable(1, 'fail');
			}
		}
		return view::fetch();
	}
	
}