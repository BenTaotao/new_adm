<?php
declare (strict_types = 1);

namespace app\admin\controller;
use think\facade\App;
use think\Container;
use think\facade\Cache;
use think\facade\Request;
use think\facade\View;

class Test
{

    public function index()
    {
        return view();
    }

    public function index1(){
		echo '测试菜单1级';
        return view();
    }

    public function index2(){
		echo '测试菜单2级';
        return view();
    }

    public function index3(){
		echo '测试菜单3级';
        return view();
    }
	
	public function index4(){
		echo '测试菜单4级';
		return view();
	}
	
	public function test001(){
		echo '测试菜单001';
		return view();
	}
}
