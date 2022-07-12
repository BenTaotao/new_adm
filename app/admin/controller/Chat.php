<?php
/**
 * User BaiXiantao
 * Date 2022/7/4
 * Time 14:00
 */

namespace app\admin\controller;

use think\facade\View;

class Chat extends Common
{
	
	public function index()
	{
		$from_id = 1;
		$to_id = 1;
		
		View::assign('from_id',$from_id);
		View::assign('to_id',$to_id);
		
		return View::fetch();
	}
}