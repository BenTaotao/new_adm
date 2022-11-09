<?php
// declare (strict_types=1);
namespace dm;

use think\facade\Config;

/**
 * Created by
 * User BaiXiantao
 * Date 2022/10/31
 * Time 17:31
 */
// header("Content-type:text/html;charset=utf8");
class Dm
{
    private $link;
    public function __construct()
    {

        $this->link = dm_connect(Config::get('database.connections.dm.hostname').":".Config::get('database.connections.dm.hostport'), Config::get('database.connections.dm.username'), Config::get('database.connections.dm.password')) or die("数据库连接失败 : " . dm_error()."\n");
        //使用 dm_error 会显示 dm 的 php 接口返回的错误，执行成功，则继续往下执行。
    }

    #多条查询，返回二维数组
    public function select(string $table, string $field = "*", string $where = "")
    {
        if ($where){
            $query = "select {$field} from {$table} where {$where}";
        }else{
            $query = "select {$field} from {$table}";
        }
        $result = dm_exec($this->link, $query) or die("query fail : " . dm_error()."\n");
        try {
            $new_arr = [];
            while ($line = dm_fetch_array($result))
            {
                array_push($new_arr, $line);
            }
            /*释放资源*/
            dm_free_result($result);
            // print "php: select success"."\n";
            /*断开连接*/
            dm_close($this->link);
            return $new_arr;
        }catch(\Exception $e)
        {
            $e->getMessage() . "<br/>";
        }
    }

    #单条查询，返回一维数组
    public function find(string $table, string $field = "*", string $where = "")
    {
        if ($where){
            $query = "select {$field} from {$table} where {$where}";
        }else{
            $query = "select {$field} from {$table}";
        }
        $result = dm_exec($this->link, $query) or die("query fail : " . dm_error()."\n");
        try {
            $line = dm_fetch_array($result);
            /*释放资源*/
            dm_free_result($result);
            return $line;
        }catch(\Exception $e)
        {
            $e->getMessage() . "<br/>";
        }
    }

    public function insert(string $table, string $name, string $value)
    {
        // $query = "insert into {$table}(NAME) values('语文'), ('数学'), ('英语'), ('体育')";
        $query = "insert into {$table}{$name} values{$value}";
        $result = dm_exec($this->link, $query) or die("insert fail : " . dm_error() . "\n");
        /*释放资源*/
        dm_free_result($result);
        return true;
    }

    public function update(string $table, string $set, string $where = "")
    {
        // $query = 'update {$table} set name = \'英语-新课标\' where name=\'英语\'';
        if ($where) {
            $query = "update {$table} set {$set} where {$where}";
        }else{
            $query = "update {$table} set {$set} ";
        }
        $result = dm_exec($this->link, $query) or die("update fail : " . dm_error() . "\n");
        // halt($result);
        /*释放资源*/
        dm_free_result($result);
        return true;
    }

    public function delete(string $table, string $where = "")
    {
        if ($where) {
            $query = "delete from {$table} where {$where}";
        }else{
            $query = "delete from {$table} "; //这样就清空表
        }
        $result = dm_exec($this->link, $query) or die("delete fail : " . dm_error() . "\n");
        /*释放资源*/
        dm_free_result($result);
        return true;
    }

    /**
     * 析构方法
     * @access public
     */
    public function __destruct()
    {
        /*断开连接*/
        dm_close($this->link);
    }
}