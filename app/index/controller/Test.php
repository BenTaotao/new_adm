<?php
// declare (strict_types=1);

namespace app\index\controller;

use think\exception\Handle;

class Test{


    public function index()
    {

        #这里是测试写入文件的
        // $this->textWrite();
        // echo 'end';
        
        #这里测试读取文件
        $content = self::readText();

        foreach ($content as $item) {
            echo $item..'<br />';
            #这里打印读取的文件，每次读取一行；但是测试的过程中出现了意外，导致无法读取

        }
        

        // $myValues = self::getValues2(); // 一旦我们调用函数将会在这里创建数组
        // $myValues = self::getValues(); // 在循环之前都不会有动作

        // // halt($myValues);
        // foreach ($myValues as $value) {
        //    echo $value . " \r\n";
        //    if (($value % 200000) == 0) {
        //     //    return $value . "\r\n" ;
        //     //    echo $value."\r\n";
            //    dump($value);
        //    }
        // } // 开始生成数据
        // // return $value."\r\n" ;
    }

    #下面是使用yield例子   ----优点：；使用内存小 缺点：加载速度慢
    public static function getValues()
    {
        // 获取内存使用数据
        // echo round(memory_get_usage() / 1024 / 1024, 2) . ' MB' . PHP_EOL;
        for ($i = 1; $i < 800000; $i++) {
            yield $i;
            // 做性能分析，因此可测量内存使用率
            //    if (($i % 200000) == 0) {
            //       // 内存使用以 MB 为单位
            //       echo round(memory_get_usage() / 1024 / 1024, 2) . ' MB'. PHP_EOL;
            //    }
        }
    }


    #未使用yield   ----优点：加载速度快； 缺点：使用内存大
    public static function getValues2()
    {
        $valuesArray = [];
        // 获取初始内存使用量
        // echo round(memory_get_usage() / 1024 / 1024, 2) . ' MB' . PHP_EOL;
        for ($i2 = 1; $i2 < 800000; $i2++) {
            $valuesArray[] = $i2;
            // 为了让我们能进行分析，所以我们测量一下内存使用量
            // if (($i2 % 200000) == 0) {
            //     // 来 MB 为单位获取内存使用量
            //     echo round(memory_get_usage() / 1024 / 1024, 2) . ' MB' . PHP_EOL;
            // }
        }
        return $valuesArray;
    }


    public function textWrite(){
        
        
        for ($i = 1; $i < 800000; $i++) {
            // yield $i;
            // 做性能分析，因此可测量内存使用率
            //    if (($i % 200000) == 0) {
            //       // 内存使用以 MB 为单位
            //       echo round(memory_get_usage() / 1024 / 1024, 2) . ' MB'. PHP_EOL;
            //    }

            file_put_contents('C:\Users\Administrator\Desktop\test.txt',"这是第 ". $i ." 行内容\r\n",FILE_APPEND);
        }

    }

    public static function readText()
    {
        $handle = fopen('C:\Users\Administrator\Desktop\123.txt',"r");

        while(!feof($handle)){

            // yield fgets($handle);
            yield fgets($handle)."<br>";//fgets()函数从文件指针中读取一行
        }
        fclose($handle);
    }
}



