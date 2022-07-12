<?php
/**
 * Created by
 * User BaiXiantao
 * Date 2020/12/6
 * Time 9:06
 */
use think\facade\Route;

// Route::get('', function () {
// 	return 'hello,ThinkPHP6!';
// });
//跨域
Route::get('app', 'app/*')
	->ext('html')
	->allowCrossDomain([
		'Access-Control-Allow-Origin'        => '*',
		'Access-Control-Allow-Credentials'   => 'true',
		'Access-Control-Max-Age'             => 3600,
	]);

Route::get('/', 'index/index');
// Route::rule('/', 'index');
//Route::get('hello/:name', 'index/hello');
Route::get('index', 'index/index');
//Route::get('admin', 'admin/index');
Route::get('login', 'login/index');

//设置路由--第三方登录的路由设置
//Route::get('oauth/callback','index/oauth/callback');
