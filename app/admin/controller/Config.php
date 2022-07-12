<?php
/**
 * Project: tp_admin
 * Author: Bentaotao
 * Data: 一些配置
 * Time: 10:39
 */

namespace app\admin\controller;


use think\facade\Db;

class Config
{
	#网站名称
	public static function site_name()
	{
		$site_name = Db::name('config')->where(['key' => 'site_name'])->column('value')[0];
		return $site_name;
	}
	
}