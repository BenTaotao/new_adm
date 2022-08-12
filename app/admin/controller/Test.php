<?php
declare (strict_types = 1);

namespace app\admin\controller;

use file\Upload;
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

    public function test_upload_file()
    {
        $upload = new Upload();
        $upload->upload_image();
    }
}
