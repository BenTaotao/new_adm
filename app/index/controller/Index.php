<?php
//declare (strict_types=1);

namespace app\index\controller;

use think\api\Client;
use think\cache\driver\Redis;
use think\facade\Request;
use think\facade\View;
use Sha2;

class Index
{

	public function index()
	{
        echo "这里是首页";
        echo "这里是首页";


//        ini_set('smtp', 'smtp.qq.com');
//        // 消息
//        $message = "Line 1\r\nLine 2\r\nLine 3";
//
//// 如果任何一行超过 70 个字符，应该使用 wordwrap()
//        $message = wordwrap($message, 70, "\r\n");
//
//// 发送
//        mail('1573027560@qq.com', 'My Subject', $message);
//        ini_set('smtp', 'smtp.qq.com');
//        ini_set('smtp_port', 25);
//        $to      = '15753027560@qq.com';
//        $subject = 'the subject';
//        $message = 'hello';
//        $headers = 'From: baixiantao@qq.com' . "\r\n" .
//                   'Reply-To: baixiantao@qq.com' . "\r\n" .
//                   'X-Mailer: PHP/' . phpversion();
//
//        mail($to, $subject, $message, $headers);
//        print_r(getmypid());
//        print_r(getrusage());
//        print_r(getrusage(true));
//        halt(phpinfo());

        // app() -> getRootPath(); //获取应用根目录
        // app() -> getNamespace(); //获取应用类库命名空间
        // app() -> version(); //获取框架版本
        // app() -> getBasePath(); //获取应用基础目录
        // app() -> getAppPath(); //获取当前应用目录
        // app() -> getThinkPath(); //获取核心框架目录
        // app() -> getConfigPath(); //获取应用配置目录
        //
        // halt(app()->getRootPath(),
        //     app()->getNamespace(),
        //     app()->version(),
        //     app()->getBasePath(),
        //     app()->getAppPath(),
        //     app()->getThinkPath(),
        //     app()->getConfigPath());
		// hash_hmac('','','','');
		#这里是hash加密的
		// $password = 123;
		// $salt = round(0,99999);
		//
		// $s5121 = hash('sha512', $password,true);
		// $s5121 = hash('sha512', $password,false);
		//
		// $hash = "{SSHA256}" . base64_encode(hash('sha256', $password . $salt) . $salt);
		//
		//
		 #这里测试sha512加密
		 $sha2 = new Sha2();
		 $s512 = $sha2->sha512('123');
		 $s256 = $sha2->sha256('123');
		 halt($s512,$s256);

		#这里是测试tp官方接口的
		// $client = new Client("0777d1f7032e232dd5fdef5976212f08");
		// $result = $client->telecomLocation()
		// 	->withPhone('18829025239')
		// 	->request();
		// $result = $client->literaryPoetry()
		// 	->withWord('枫桥夜泊')
		// 	->request();
		// $result = $client->unnBatchUcheck()
		// 	->withMobiles('手机号码')
		// 	->request();
		// $result = $client->idcardIndex()
		// 	->withCardno('622822199303291117')
		// 	->request();
		// dump($result);
		// dump($result);
		// return json($result);

		#这里是测试redist的
		// $redis = new Redis();
		// $redis->set('name', '这是测试redis的文件132');
		// $gets = $redis->get('name');
		// return json($gets);

		#这里测试php的yield操作
		
		// return json("此处为index应用");


        return View::fetch();
	}

    public function tron_pdf()
    {
        $id = input('id');
        $file_names = input('file_name');
        // dump($id);
        // $pdf_url = "https://pdfs.junkexinxi.com/nginx_12.pdf";
        // $pdf_url = "http://localhost/static/index/file/nginx_12.pdf";

        $file_name    = '/static/index/file/'.$file_names.'.pdf';
        #新文件名称
        $newfile_name = '/static/index/file/'.$file_names.'_'.$id.'.pdf';

        $pdf_url = request()->domain() . $newfile_name;
        // $pdf_url = request()->domain() . $file_name;
        #判断文件是否存在
        if (file_exists(app()->getRootPath().'public'.$newfile_name)){
            return ajaxTable(0,'',$pdf_url);
        }

        #如果不存在则复制文件
        $cp_path1 = app()->getRootPath().'/public'.$file_name;
        $cp_path2 = app()->getRootPath().'/public'.$newfile_name;

        if(copy($cp_path1, $cp_path2)){
            chmod($cp_path2, 0777);
            return ajaxTable(0,'',$pdf_url);
        }else{
            return ajaxTable(1,'打开失败','');
        }

        // return ajaxTable(0,'',$pdf_url);
    }

    public function tron_pdf_save(){

        $files_name = input('files_name');
        $file_name = input('file_name');
        $id = input('uid');
        // $newfile_name = '/static/index/file/'.$file_name.$id.'.pdf';
        // $newfile_name = '/static/index/file/'.$file_name.$id;

        // $file_name = substr($file_name, 0,-4);

        $newfile_name = $file_name.'_'.$id.'.pdf';
        // $newfile_name = $file_name.'_'.$id;
        $path = app()->getRootPath().'public/static/index/file/'.$newfile_name;

        $file = request()->file('files');
        // 上传到本地服务器
        $savename = \think\facade\Filesystem::putFile('/static/index/file/', $file, $newfile_name);

        $tmp_url = app()->getRootPath() . 'runtime/storage/'.$savename;
        $pub_url = app()->getRootPath() . 'public/static/index/file/'.$newfile_name;

        rename($tmp_url, $pub_url);
        chmod($pub_url, 0777);
        // file_put_contents($path, $file,FILE_APPEND | LOCK_EX);
        // if(copy(app()->getRootPath().'/'.$savename, app()->getRootPath().'/public/static/index/file/'.$newfile_name)){
        //     return ajaxTable(0,'保存成功');
        // }else{
        //     return ajaxTable(1,'保存失败');
        // }
        return json(['msg'=>'保存成功']);

    }
}
