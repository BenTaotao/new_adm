<?php

return [
    // 默认磁盘
    'default' => env('filesystem.driver', 'local'),
    // 磁盘列表
    'disks'   => [
        'local'  => [
            'type' => 'local',
            'root' => app()->getRuntimePath() . 'storage',
            // 'root' => app()->getRootPath() . 'public',
        ],
        'public' => [
            // 磁盘类型
            'type'       => 'local',
            // 磁盘路径
            'root'       => app()->getRootPath() . 'public/storage',
            // 磁盘路径对应的外部URL路径
            'url'        => '/storage',
            // 可见性
            'visibility' => 'public',
        ],
        // 更多的磁盘配置信息
        'ueditor' => [
            'type'         => 'aliyun',
            'accessId'     => 'aliyun OSS accessId',
            'accessSecret' => 'aliyun OSS accessSecret',
            'endpoint'     => 'aliyun OSS endpoint',
            'bucket'       => 'aliyun OSS bucket',
            'url'          => 'aliyun OSS url', //不要斜杠结尾，此处为URL地址域名。
        ],
    ],
];
