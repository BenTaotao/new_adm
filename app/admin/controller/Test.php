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
        // $gds?->name?->address()->city;
        GetCity();
        // $ip = get_client_ip();
        // $city = ip_zone($ip);
        // halt($city);
        return view();
    }

    public function test_upload_file()
    {
        $upload = new Upload();
        #所以这里上传文件的时候，只需要调用这个方法就可以，调用完成，返回文件路径名称
        $savename = $upload->upload_image();
        // $savename = $upload->upload_images();
        // $savename = $upload->upload_file();
        // $savename = $upload->upload_files();

        #这里处理文件路径名称
        return ajaxTable(0,'',$savename);
        // return json(["code" => 0, "msg" => '上传成功', "data" => $savename]);
    }
}
