<?php
declare (strict_types = 1);

namespace app\admin\middleware;


use think\facade\Db;
use think\facade\Session;
use think\Response;

class Login
{
    /**
     * 处理请求
     *
     * @param \think\Request $request
     * @param \Closure       $next
     * @return Response
     */
    public function handle($request, \Closure $next)
    {
	
		$Admin_outime = session('Admin_outime');//登录过期时间  默认登录1小时过期
		$Admin_lasttime = session('Admin_lasttime'); //最近操作的时间
		$admin_info = session('admin_info');
	
		$response = $next($request);
		$controller = $request->controller();
		$action = $request->action();
		$app = app('http')->getName();
		// halt($controller,$action,$app);
		if (strtolower($controller) != "login") {
			#这里验证session的存在性，过期时间，一个小时不操作等等的验证
			if (!$admin_info || !$Admin_outime || ($Admin_outime < time()) || ((time() - $Admin_lasttime) > 3600)){
				Session::delete('Admin_outime');
				Session::delete('admin_info');
				return redirect('/admin/login/index');
			}
			// if ($Admin_outime < time()){
			// 	return redirect('login/index');
			// }
			// if ((time() - $Admin_lasttime) > 3600){
			// 	return redirect('login/index');
			// }
			#这里验证是否是同一个人登录，异地登录,同一个账号不能有两个人同时登录
			$login_str = Db::name('admin')->where(['id' => session('admin_info')['id']])->value('login_str');
			if (session('login_str') != $login_str) {
				Session::delete('Admin_outime');
				Session::delete('admin_info');
				return redirect('/admin/login/index');
			}
			#这里更新session的过期时间和最后操作时间
			session('Admin_outime',time()+3600);
			session('Admin_lasttime',time());
		}
		return $response;
    }

}
