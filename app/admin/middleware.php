<?php
// 这是系统自动生成的middleware定义文件
return [
    //Session初始化
    \think\middleware\loadLangPack::class,
	//登录中间件
	\app\admin\middleware\Login::class
];
