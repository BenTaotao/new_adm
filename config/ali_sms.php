<?php

return [
    'version' => '2017-05-25',
    'host' => 'dysmsapi.aliyuncs.com',
    'scheme' => 'http',
    'region_id' => 'cn-hangzhou',
    'access_key' => '',
    'access_secret' => '',
    'product' => 'xxx平台',
    'actions' => [
        'register' => [
            'sign_name' => '注册验证',
            'template_code' => 'SMS_67105498',
            'template_param' => [
                'code' => '',
                'product' => '',
            ]
        ],
        'login' => [
            'sign_name' => '登录验证',
            'template_code' => 'SMS_67105500',
            'template_param' => [
                'code' => '',
                'product' => '',
            ]
        ],
        'change_password' => [
            'sign_name' => '变更验证',
            'template_code' => 'SMS_67105496',
            'template_param' => [
                'code' => '',
                'product' => '',
            ]
        ],
    ],
];
