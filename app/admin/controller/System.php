<?php
/**
 * Created by
 * User BaiXiantao
 * Date 2022/9/7
 * Time 14:07
 */

namespace app\admin\controller;

use think\facade\Db;
use think\facade\View;

class System extends Common
{

    public function index()
    {
        $list = Db::name('config')->select();
        $data = cms_rebuild($list, 'key',1);
        View::assign('data',$data);
        return View::fetch();
    }

    public function edit()
    {
        $data = input();

        $keys = array_keys($data);
        for ($i = 0; $i< count($keys); $i++){
            Db::name('config')->where(['key'=>$keys[$i]])->update(['value'=>$data[$keys[$i]]]);
        };
        $this->ULog("修改了系统设置 ");
        return ajaxTable(0);
    }


}