<?php

require dirname(__FILE__, 2) . '/vendor/autoload.php';

$secretId = "SECRETID"; //替换为用户的 secretId，请登录访问管理控制台进行查看和管理，https://console.cloud.tencent.com/cam/capi
$secretKey = "SECRETKEY"; //替换为用户的 secretKey，请登录访问管理控制台进行查看和管理，https://console.cloud.tencent.com/cam/capi
$region = "ap-beijing"; //替换为用户的 region，已创建桶归属的region可以在控制台查看，https://console.cloud.tencent.com/cos5/bucket
$cosClient = new Qcloud\Cos\Client(
    array(
        'region' => $region,
        'schema' => 'https', //协议头部，默认为http
        'credentials'=> array(
            'secretId'  => $secretId ,
            'secretKey' => $secretKey
        )
    )
);
$cos_path = 'cos/folder';
$nextMarker = '';
$isTruncated = true;

while ( $isTruncated ) {
    try {
        $result = $cosClient->listObjects(
            ['Bucket' => 'examplebucket-125000000', //存储桶名称，由BucketName-Appid 组成，可以在COS控制台查看 https://console.cloud.tencent.com/cos5/bucket
            'Delimiter' => '',
            'EncodingType' => 'url',
            'Marker' => $nextMarker,
            'Prefix' => $cos_path,
            'MaxKeys' => 1000]
        );
    } catch ( \Exception $e ) {
        echo( $e );
    }
    $isTruncated = $result['IsTruncated'];
    $nextMarker = $result['NextMarker'];
    foreach ( $result['Contents'] as $content ) {
        $cos_file_path = $content['Key'];
        $local_file_path = $content['Key'];
        // 按照需求自定义拼接下载路径
        try {
            $result = $cosClient->download(
                $bucket = 'examplebucket-125000000', //存储桶名称，由BucketName-Appid 组成，可以在COS控制台查看 https://console.cloud.tencent.com/cos5/bucket
                $key = $cos_file_path,
                $saveAs = $local_file_path
            );
            echo ( $cos_file_path . "\n" );
        } catch ( \Exception $e ) {
            echo( $e );
        }
    }
}
