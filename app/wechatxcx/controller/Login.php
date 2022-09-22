<?php

namespace app\api\controller;

use think\facade\Db;

class Login
{
    public function login()
    {
        $code = $_POST['code'];
        $userinfo = $_POST['userinfo'];

        if (!$code) return false;
        $appid = '';
        $secret = '';
        $setting = Db::name('config')->where(['type'=>'weixin_xcx'])->select();
        if ($setting) {
            foreach ($setting as $key => $val) {
                if ($val['key'] == 'appid') {
                    $appid = $val['value'];
                }
                if ($val['key'] == 'secret') {
                    $secret = $val['value'];
                }
            }
        }
        $url = "https://api.weixin.qq.com/sns/jscode2session?appid={$appid}&secret={$secret}&js_code={$code}&grant_type=authorization_code";
        $data = json_decode(curl_ssl($url),true);
        if (isset($data['errcode'])){
            return json(['msg'=>'系统繁忙，请稍后再试']);
        }
        $token = md5($data['openid'].$data['session_key']);
        $user_id = Db::name('user')->where(['openid'=>$data['openid']])->value('id');
        if ($user_id) {
            Common::$islogin = true;
            Db::name('user')->where(['openid'=>$data['openid']])->update(['token'=>$token,'last_ip'=> get_client_ip(),'last_time'=>time()]);
            return json(['msg'=>'登陆成功1','user_id'=>$user_id,'token'=>$token]);
        } else {
            $data = [
                'openid'      => $data['openid'],
                'session_key' => $data['session_key'],
            ];
            Db::name('user_weixin')->insert($data);
            $user_id = Db::name('user')->where(['openid' => $data['openid']])->value('id');
            if (!$user_id) {
                $user_data = [
                    'openid' => $data['openid'],
                    'token'  => $token,
                    'nickname'=>json_decode($userinfo,1)['nickName'],
                    'avatar' => json_decode($userinfo,1)['avatarUrl'],
                    'register_ip'=> get_client_ip(),
                    'last_ip'=> get_client_ip(),
                    'register_time'=> time(),
                    'last_time'=>time()
                ];
                $user_id = Db::name('user')->insertGetId($user_data);
            }
           return json(['msg'=>'登陆成功2','user_id'=>$user_id,'token'=>$token]);
        }

    }
}