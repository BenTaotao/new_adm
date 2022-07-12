<?php
declare (strict_types = 1);

namespace app\http;

use think\facade\Db;
use think\worker\Server;
use Workerman\Lib\Timer;

// define('HEARTBEAT_TIME', 30);// 心跳间隔
class Worker extends Server
{
	protected $socket = 'websocket://0.0.0.0:2345';
	
	protected static $heartbeat_time = 50;
	
	public function onWorkerStart($worker)
	{
		Timer::add(10, function()use($worker){
			$time_now = time();
			#这里统计下线人员的id
			$offline_user = [];
			
			foreach($worker->connections as $connection) {
				// 有可能该connection还没收到过消息，则lastMessageTime设置为当前时间
				if (empty($connection->lastMessageTime)) {
					$connection->lastMessageTime = $time_now;
					continue;
				}
				// 上次通讯时间间隔大于心跳间隔，则认为客户端已经下线，关闭连接
				// if ($time_now - $connection->lastMessageTime > HEARTBEAT_TIME) {
				if ($time_now - $connection->lastMessageTime > self::$heartbeat_time) {
					#这里统计下线人员的id
					$offline_user[] = $connection->uid;
					#关闭连接
					$connection->close();
				}
				
				#这里是一个用户下线后通知其他用户
				if (count($offline_user) > 0){
					$msg = ['type'=>'message','uid'=>$connection->uid,"message"=>"用户【".implode(',',$offline_user)."】下线了"];
					$connection->send(json_encode($msg));
				}
			}
		});
	}
	
	public function onMessage($connection,$data)
	{
		#最后接收消息时间
		$connection->lastMessageTime = time();
		
		
		$msg_data = json_decode($data,true);
		if (!$msg_data){
			return;
		}
		#绑定用户ID
		if ($msg_data['type'] == 'bind' && !isset($connection->uid)){
			$connection->uid = $msg_data['uid'];
			$this->worker->uidConnections[$connection->uid] = $connection;
		}
		
		
		// Db::name('online_customer_service')->insert();
		
		#单人发消息
		if ($msg_data['type'] == 'text' && $msg_data['mode'] == 'single'){
			if (isset($this->worker->uidConnections[$msg_data['to_id']])){
				$conn = $this->worker->uidConnections[$msg_data['to_id']];
				$conn->send($data);
			}
		}
		#群聊
		if ($msg_data['type'] == 'text' && $msg_data['mode'] == 'group'){
			#实际项目通过群号查询群里有哪些用户
			$group_user = [10009,10010,10011,10012,10013,10014,10015,10016,10017];
			foreach ($group_user as $key => $val){
				if (isset($this->worker->uidConnections[$val])){
					$conn = $this->worker->uidConnections[$val];
					$conn->send($data);
				}
			}
			
		}
		
		// #向所有用户发送消息
		// foreach ($this->worker->connections as $key => $con){
		// 	$con->send($data);
		// }
		
		// $connection->send(json_encode($data));
		// $connection->send($data);
	}
	
	
}