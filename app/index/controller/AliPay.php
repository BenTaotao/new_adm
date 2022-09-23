<?php

namespace app\index\controller;

use Alipay\EasySDK\Kernel\Factory;
use Alipay\EasySDK\Kernel\Util\ResponseChecker;
use Alipay\EasySDK\Kernel\Config;

use think\Exception;

Factory::setOptions(getOptions());
class AliPay
{



    public function alipay_web($subject,$outTradeNo,$totalAmount)
    {
        //1. 设置参数（全局只需设置一次）Factory::setOptions(getOptions());
        try {
            //2. 发起API调用（以支付能力下的统一收单交易创建接口为例）
            $result = Factory::payment()->page()
//                ->optional("qr_pay_mode", "4")->optional("qrcode_width", "242")
                ->pay($subject, $outTradeNo, $totalAmount,'https://ly.yue999.cn/index/order/pay_result');
            return $result->body;

            //3. 处理响应或异常

//            //处理响应或异常
//            if ($responseChecker->success($result)) {
//                //调用成功
//                return $result->body;
//            } else {
//                //调用失败
////                $errorMsg = $result->getMessage . $result->subMsg;
//                throw new Exception();
//            }
        } catch (\Exception $e) {
            echo "调用失败，". $e->getMessage(). PHP_EOL;;
        }

    }

}

function getOptions(){
    $options = new Config();
    $options->protocol = 'https';
    $options->gatewayHost = 'openapi.alipay.com';
    $options->signType = 'RSA2';

    $options->appId =  '' ; //'<-- 请填写您的AppId，例如：2019******440152 -->';

    // 为避免私钥随源码泄露，推荐从文件中读取私钥字符串而不是写入源码中
    $options->merchantPrivateKey = ''; //'<-- 请填写您的应用私钥，例如：MIIEvQIBADANB ... ... -->';

    $options->alipayCertPath = root_path() . 'app/alipay_cert_path/alipayCertPublicKey_RSA2.crt';//'<-- 请填写您的支付宝公钥证书文件路径，例如：/foo/alipayCertPublicKey_RSA2.crt -->';
    $options->alipayRootCertPath = root_path() . 'app/alipay_cert_path/alipayRootCert.crt'; // '<-- 请填写您的支付宝根证书文件路径，例如：/foo/alipayRootCert.crt" -->';
    $options->merchantCertPath = root_path() . 'app/alipay_cert_path/appCertPublicKey_2021003148627471.crt';//'<-- 请填写您的应用公钥证书文件路径，例如：/foo/appCertPublicKey_2019051064521003.crt -->';

    //注：如果采用非证书模式，则无需赋值上面的三个证书路径，改为赋值如下的支付宝公钥字符串即可
//        $options->alipayPublicKey =  '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';// '<-- 请填写您的支付宝公钥，例如：MIIBIjANBg... -->';
    //可设置异步通知接收服务地址（可选）
    $options->notifyUrl =  '';//"<-- 请填写您的支付类接口异步通知接收服务地址，例如：https://www.test.com/callback -->";

    //可设置AES密钥，调用AES加解密相关接口时需要（可选）
//        $options->encryptKey = "<-- 请填写您的AES密钥，例如：aa4BtZ4tspm2wnXLb1ThQA== -->";
    return $options;
}