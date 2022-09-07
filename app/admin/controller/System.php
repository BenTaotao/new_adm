<?php
/**
 * Created by
 * User BaiXiantao
 * Date 2022/9/7
 * Time 14:07
 */

namespace app\admin\controller;

use think\facade\View;

class System extends Common
{

    public function index()
    {

        return View::fetch();
    }
}