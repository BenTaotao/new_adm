<?php

/**
 * Created by
 * User BaiXiantao
 * Date 2022/9/8
 * Time 16:06
 */
class Config
{
    public static function answer_id($id)
    {
        return match($id){
            '1'=>'非常好',
            '2'=>'较好',
            '3'=>'一般',
            '4'=>'比较差',
            '5'=>'很不好'
        };
    }
}