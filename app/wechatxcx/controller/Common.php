<?php

namespace app\api\controller;

use think\facade\Db;

class Common
{
    public $appid;
    public $secret;
    public static $islogin = false;

    public function __construct()
    {
        $check = self::check_token();
        if (!$check){
            // return redirect('/api/login/login');
            return ajaxTable(1,'请登录');
        }
        // $setting = Db::name('config')->where(['type'=>'weixin_xcx'])->select();
        // if ($setting) {
        //     foreach ($setting as $key => $val) {
        //         if ($val['key'] == 'appid') {
        //             $this->appid = $val['value'];
        //         }
        //         if ($val['key'] == 'secret') {
        //             $this->secret = $val['value'];
        //         }
        //     }
        // }

    }
    
    #判断登录
    public function is_login()
    {
        if (self::$islogin){
            return true;
        }
        return false;
    }

    public static function check_token()
    {
        $token = input('token');
        $user_id = input('user_id');
        if (!$token || !$user_id){
            return false;
        }
        $user_token = Db::name('user')->where(['id'=>$user_id])->value('token');
        if ($token != $user_token){
            return false;
        }
        return true;
    }
    
    #获取微信小程序access_toekn
    public function access_token()
    {
        $access_token = '';
        $data = Db::name('xcx_access_token')->where(['type'=>1])->find();
        if (($data['expiration_time'] < time()) || !isset($data['expiration_time'])){
            $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$this->appid}&secret={$this->secret}";
            $wx_data = json_decode(curl_ssl($url),true);
            if (isset($wx_data['errcode'])){
                return $wx_data;
            }
            if (!$wx_data){
                return '';
            }
            $update = [
                'access_token' => $wx_data['access_token'],
                'expiration_time' => time() + 7000,
            ];
            Db::name('xcx_access_token')->where(['type'=>1])->update($update);
            $access_token = $wx_data['access_token'];
        }else{
            $access_token = $data['access_token'];
        }
        return $access_token;
    }

    #获取用户信息
    public function getUserinfo($id)
    {
        $userinfo = Db::name('user')->where(['id'=>$id])->find();
        return $userinfo;
    }

    #登录
    public function login()
    {
        $code = $_GET['code'];
        $code = '061jJt2w3ECibZ2qnK3w3MMhXc1jJt2h';

        $url = "https://api.weixin.qq.com/sns/jscode2session?appid={$this->appid}&secret={$this->secret}&js_code={$code}&grant_type=authorization_code";
        $data = json_decode(curl_ssl($url),true);
        if ($data['errcode'] == 0){
            $info = Db::name('user_weixin')->where(['openid'=>$data['openid']])->find();
            if (!$info) {
                $data = [
                    'openid'      => $data['openid'],
                    'session_key' => $data['session_key'],
                ];
                Db::name('user_weixin')->insert($data);
            }
            self::$islogin = true;
            return true;
        }
        return false;
    }
}