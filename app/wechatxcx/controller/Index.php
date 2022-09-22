<?php
declare (strict_types = 1);

namespace app\api\controller;

use think\facade\Db;

class Index
{
    /**
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * @jit
     */
    public function index()
    {
        $today = strtotime('today');
        $noon =  $today + 41400; #早上11点半
        $afternoon =  $today + 63000; #下午5点半
        $meals_type = '1,2,3';

        #晚上时间限制

        #中午时间限制


        $data = Db::name('survey')->where(['survey_date'=>$today])
            ->where('meals_type','in',$meals_type)
            ->order('meals_type asc')
            ->field('id,meals_type as type')
            ->select();
        foreach($data as $k => $v){
                        $v['status'] = 0;
            switch ($v['type']) {
                 case 1:
                        $v['status'] = 1;
                        $v['src'] = "../../images/breakfast.png";
                        break;
                 case 2:
                        if (time() > $noon){
                            $v['status'] = 1;
                        }
                        $v['src'] = "../../images/lunch.png";
                        break;
                 case 3:
                     if (time() > $afternoon){
                            $v['status'] = 1;
                        }
                         $v['src'] = "../../images/dinner.png";
                        break;

            }

            $data[$k] = $v;
        }
        return ajaxTable(0,'',$data);
    }
}
