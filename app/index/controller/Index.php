<?php
//declare (strict_types=1);

namespace app\index\controller;

use think\api\Client;
use think\cache\driver\Redis;
use think\facade\View;
use Sha2;

class Index
{

	public function index()
	{


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
		// #这里测试sha512加密
		// $sha2 = new Sha2();
		// $s512 = $sha2->sha512('123');
		// $s256 = $sha2->sha256('123');
		// halt($s5121,$s512,$s256);

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
		$redis = new Redis();
		$redis->set('name', '这是测试redis的文件132');
		$gets = $redis->get('name');
		return json($gets);

		#这里测试php的yield操作
		
		// return json("此处为index应用");
	}
}
