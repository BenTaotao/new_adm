<?php
#此处是文件上传类
namespace file;

use think\facade\Filesystem;
use think\exception\ValidateException;

class Upload
{
    #单图片上传
    public function upload_image()
    {
        $file_arr = request()->file();
        if (!$file_arr){
            return ['code'=>1,'msg'=>'文件不存在'];
        }
        $file = array_shift($file_arr);
        try {
            validate(
                [
                    'file' => [
                        // 限制文件大小(单位b)，这里限制为10M
                        'fileSize' => 10 * 1024 * 1024,
                        // 限制文件后缀，多个后缀以英文逗号分割
                        'fileExt'  => 'jpg,jpeg,png,bmp,gif'
                    ]
                ],
                [
                    'file.fileSize' => '文件太大',
                    'file.fileExt' => '不支持的文件后缀',
                ]
            )->check(['file' => $file]);

            $savename = Filesystem::disk('public')->putFile( 'topic/image', $file);
            return ['code'=>0,'msg'=>'成功','data'=>$savename];
        } catch (ValidateException $e) {
            $err = $e->getMessage();
            return ['code'=>1,'msg'=>$err];
        }
    }

    #多图片上传
    public function upload_images()
    {
        $file_arr = request()->file();
        if (!$file_arr){
            return ['code'=>1,'msg'=>'文件不存在'];
        }
        $files = array_shift($file_arr);
        try {

            $savename = [];
            foreach($files as $file) {
                validate(
                    [
                        'file' => [
                            // 限制文件大小(单位b)，这里限制为10M
                            'fileSize' => 10 * 1024 * 1024,
                            // 限制文件后缀，多个后缀以英文逗号分割
                            'fileExt'  => 'jpg,jpeg,png,bmp,gif'
                        ]
                    ],
                    [
                        'file.fileSize' => '文件太大',
                        'file.fileExt' => '不支持的文件后缀',
                    ]
                )->check(['file' => $file]);
                $savename[] = Filesystem::disk('public')->putFile( 'topic/image', $file);
            }
            return ['code'=>0,'msg'=>'成功','data'=>$savename];
        } catch (ValidateException $e) {
            $err = $e->getMessage();
            return ['code'=>1,'msg'=>$err];
        }
    }

    #单文件上传
    public function upload_file()
    {
        $file_arr = request()->file();
        if (!$file_arr){
            return ['code'=>1,'msg'=>'文件不存在'];
        }
        $file = array_shift($file_arr);
        try {
            $savename =  Filesystem::disk('public')->putFile( 'topic/file', $file);
            return ['code'=>0,'msg'=>'成功','data'=>$savename];
        } catch (ValidateException $e) {
            $err = $e->getMessage();
            return ['code'=>1,'msg'=>$err];
        }
    }

    #多文件上传
    public function upload_files()
    {
        $file_arr = request()->file();
        if (!$file_arr){
            return ['code'=>1,'msg'=>'文件不存在'];
        }
        $files = array_shift($file_arr);
        try {
            $savename = [];
            foreach($files as $file) {
                $savename[] = Filesystem::disk('public')->putFile( 'topic/file', $file);
            }
            return ['code'=>0,'msg'=>'成功','data'=>$savename];
        } catch (ValidateException $e) {
            $err = $e->getMessage();
            return ['code'=>1,'msg'=>$err];
        }
    }

    #不保留原始文件名
    public function upload(){
        // 获取表单上传文件 例如上传了001.jpg
        $file_arr = request()->file();
        if (!$file_arr){
            return ['code'=>1,'msg'=>'文件不存在'];
        }
        $file = array_shift($file_arr);
        // 上传到本地服务器
        try {

            #由于一般情况下上传的文件都是要直接访问和下载的，所以需要放在public目录下的
            $savename = Filesystem::disk('public')->putFile('topic', $file); #这里是存储在public目录下的
            return ['code' => 0, 'msg' => '成功', 'data' => $savename];
        } catch (ValidateException $e) {
            $err = $e->getMessage();
            return ['code' => 1, 'msg' => $err];
        }
    }

    #保留原始文件名
    public function upload_Original(){
        // 获取表单上传文件
        $file_arr = request()->file();
        if (!$file_arr){
            return ['code'=>1,'msg'=>'文件不存在'];
        }
        $file = array_shift($file_arr);
        $filename = $file->getOriginalName().'.'.$file->getOriginalExtension();
        try {
            #由于一般情况下上传的文件都是要直接访问和下载的，所以需要放在public目录下的
            $savename = Filesystem::disk('public')->putFileAs('topic/other', $file, $filename);
            return ['code' => 0, 'msg' => '成功', 'data' => $savename];
        } catch (ValidateException $e) {
            $err = $e->getMessage();
            return ['code' => 1, 'msg' => $err];
        }
    }
}