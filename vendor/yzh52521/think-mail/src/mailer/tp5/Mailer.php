<?php
/**
 * think-mail [A powerful and beautiful php mailer for All of ThinkPHP and Other PHP Framework based SwiftMailer]
 *
 * @author    yzh52521
 * @link      https://github.com/yzh52521/think-mail
 * @copyright 2020 yzh52521 all rights reserved.
 * @license   http://www.apache.org/licenses/LICENSE-2.0
 */
namespace mailer\tp5;

use think\View;
use think\Config as ThinkConfig;

/**
 * Class Mailer
 * @package mailer\tp5
 */
class Mailer extends \mailer\lib\Mailer
{
    /**
     * 载入一个模板作为邮件内容
     *
     * @param string $template
     * @param array  $param
     * @param array  $config
     *
     * @return Mailer
     */
    public function view($template, $param = [], $config = [])
    {
        $view = View::instance(ThinkConfig::get('template'), ThinkConfig::get('view_replace_str'));
        // 处理变量中包含有对元数据嵌入的变量
        foreach ($param as $k => $v) {
            $this->embedImage($k, $v, $param);
        }
        $content = $view->fetch($template, $param, [], $config);

        return $this->html($content);
    }
}
