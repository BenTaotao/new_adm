<?php
/**
 * Created by
 * User BaiXiantao
 * Date 2022/9/8
 * Time 11:18
 */

namespace app\api\controller;

use think\facade\Db;

class Question extends Common
{
    public function is_answer()
    {
        if(!$_POST){
            return ajaxTable(1,'非法请求');
        }
        $id = input('id');
        $user_id = input('user_id');
        $res = Db::name('survey_answer')->where(['survey_id'=>$id,'user_id'=>$user_id])->find();
        if ($res){
            return ajaxTable(2,'已参与');
        }else{
            return ajaxTable(0,'未参与');
        }
    }

    public function question()
    {
        if(!$_POST){
            return ajaxTable(1,'非法请求');
        }
        $id = input('id');
        $user_id = input('user_id');
        if (!$id || !$user_id){
            return ajaxTable(1,'非法请求');
        }
        $today = strtotime('today');
        #中午十一点之前不能点，下午17点30之前不能点
        $noon =  $today + 1800 + 3600 * 11;
        $afternoon =  $today + 1800 + 3600 * 17;
        $data = Db::name('survey')->where(['id'=>$id])->find();

        #中午时间限制
        if ((time() < $noon) && ($data['meals_type'] == 2)){
            return ajaxTable(1,'午餐时间未到');
        }
        #晚上时间限制
        if ((time() < $afternoon) && ($data['meals_type'] == 3)){
            return ajaxTable(1,'晚餐时间未到');
        }


        unset($data['create_time']);
        unset($data['status']);
        $list = Db::name('recipes')->where('id','in',$data['recipes_ids'])->column('id,food_name');
        $survey_list = Db::name('survey_answer')->where(['survey_id'=>$id,'user_id'=>$user_id])->find();
        for ($i=0;$i<6;$i++){
            $list[$i]['recipes_id'] = $list[$i]['id'];
            $list[$i]['content'] = '您认为本餐厅的'.$list[$i]['food_name'].'品质如何？';

            $answer_list = [
                ['id'=>1,'title'=>'A.非常好','selected'=>0],
                ['id'=>2,'title'=>'B.较好','selected'=>0],
                ['id'=>3,'title'=>'C.一般','selected'=>0],
                ['id'=>4,'title'=>'D.比较差','selected'=>0],
                ['id'=>5,'title'=>'E.很不好','selected'=>0],
            ];

            if (isset($survey_list) && !empty($survey_list)){
                $wenti_id = 'question_'.$i+1;
                $daan = $survey_list[$wenti_id];
                for ($ia=0;$ia<5;$ia++){
                    if ($answer_list[$ia]['id'] == $daan){
                        $answer_list[$ia]['selected'] = 1;
                    }
                }
            }

            $list[$i]['answer'] = $answer_list;

            unset($list[$i]['id']);
            unset($list[$i]['food_name']);
        }
        $data['question_list'] = $list;
        $pub_list = Db::name('public_question')->where('id','in',$data['public_question_ids'])->column('id,content');
        for ($j=0;$j<3;$j++){
            $pub_list[$j]['public_question_id'] = $pub_list[$j]['id'];

            $pub_answer_list = [
                ['id'=>1,'title'=>'A.非常好','selected'=>0],
                ['id'=>2,'title'=>'B.较好','selected'=>0],
                ['id'=>3,'title'=>'C.一般','selected'=>0],
                ['id'=>4,'title'=>'D.比较差','selected'=>0],
                ['id'=>5,'title'=>'E.很不好','selected'=>0],
            ];

            if (isset($survey_list) && !empty($survey_list)){
                $wenti_id = 'public_question_'.$j+1;
                $daan = $survey_list[$wenti_id];
                for ($ia=0;$ia<5;$ia++){
                    if ($pub_answer_list[$ia]['id'] == $daan){
                        $pub_answer_list[$ia]['selected'] = 1;
                    }
                }
            }

            $pub_list[$j]['answer'] = $pub_answer_list;
            unset($pub_list[$j]['id']);
        }
        $data['public_question_list'] = $pub_list;
        $data['wenda'] = '您对本食堂有什么其他意见或建议？';
        $data['user_num'] = Db::name('survey_answer')->where(['survey_id'=>$id])->count();
        unset($data['recipes_ids']);
        unset($data['public_question_ids']);

        return ajaxTable(0,'',$data);
    }

    public function answer()
    {
        if(!request()->isPost()){
            return ajaxTable(1,'非法请求');
        }
        $data = input();

        $is_exts = Db::name('survey_answer')->where(['survey_id'=>$data['question_id'],'user_id'=>$data['user_id']])->find();
        if (isset($is_exts) && !empty($is_exts)){
            return ajaxTable(1,'请勿重复提交');
        }
        unset($data['token']);
        unset($data['token']);
        $data['survey_id'] = $data['question_id'];
        unset($data['question_id']);
        $danxuan_form = json_decode($data['danxuan_form'],true);
        $i = 1;
        foreach ($danxuan_form as $key=>$value){
            $data['question_'.$i] = $value;
            $data['recipes_id_'.$i] = $key;
            $i++;
        }
        $data['recipes_ids'] = $data['danxuan_form'];
        unset($data['danxuan_form']);

        $gonggong_form = json_decode($data['gonggong_form'],true);
        $j = 1;
        foreach ($gonggong_form as $k=>$v){
            $data['public_question_'.$j] = $v;
            $data['public_question_id_'.$j] = $k;
            $j++;
        }
        $data['public_question_ids'] = $data['gonggong_form'];
        unset($data['gonggong_form']);


        $data['public_question_4'] = $data['wenda_form'];
        unset($data['wenda_form']);

        $data['create_time'] = time();
        $res = Db::name('survey_answer')->insert($data);
        if ($res){
            return ajaxTable(0);
        }else{
            return ajaxTable(1);
        }
    }

    public function question_detail()
    {
        if(!$_POST){
            return ajaxTable(1,'非法请求');
        }
        $id = input('id');
        $user_id = input('user_id');
        if (!$id || !$user_id){
            return ajaxTable(1,'非法请求');
        }
        $today = strtotime('today');

        $data = Db::name('survey')->where(['id'=>$id])->find();

        unset($data['create_time']);
        unset($data['status']);
        $list = Db::name('recipes')->where('id','in',$data['recipes_ids'])->column('id,food_name');
        $survey_list = Db::name('survey_answer')->where(['survey_id'=>$id,'user_id'=>$user_id])->find();

        $data_count = \app\admin\model\Question::percent($id);
        for ($i=0;$i<6;$i++){
            $list[$i]['recipes_id'] = $list[$i]['id'];
            $list[$i]['content'] = '您认为本餐厅的'.$list[$i]['food_name'].'品质如何？';
            $is = $i+1;
            $answer_list = [
                ['id'=>1,'title'=>'A.非常好','selected'=>0,'pnum'=>$data_count['question_'.$is][1],'ppbi'=>$data_count["q{$is}c"][1]],
                ['id'=>2,'title'=>'B.较好','selected'=>0,'pnum'=>$data_count['question_'.$is][2],'ppbi'=>$data_count["q{$is}c"][2]],
                ['id'=>3,'title'=>'C.一般','selected'=>0,'pnum'=>$data_count['question_'.$is][3],'ppbi'=>$data_count["q{$is}c"][3]],
                ['id'=>4,'title'=>'D.比较差','selected'=>0,'pnum'=>$data_count['question_'.$is][4],'ppbi'=>$data_count["q{$is}c"][4]],
                ['id'=>5,'title'=>'E.很不好','selected'=>0,'pnum'=>$data_count['question_'.$is][5],'ppbi'=>$data_count["q{$is}c"][5]],
            ];

            if (isset($survey_list) && !empty($survey_list)){
                $wenti_id = 'question_'.$i+1;
                $daan = $survey_list[$wenti_id];
                for ($ia=0;$ia<5;$ia++){
                    if ($answer_list[$ia]['id'] == $daan){
                        $answer_list[$ia]['selected'] = 1;
                    }
                }
            }

            $list[$i]['answer'] = $answer_list;

            unset($list[$i]['id']);
            unset($list[$i]['food_name']);
        }
        $data['question_list'] = $list;
        $pub_list = Db::name('public_question')->where('id','in',$data['public_question_ids'])->column('id,content');
        for ($j=0;$j<3;$j++){
            $pub_list[$j]['public_question_id'] = $pub_list[$j]['id'];
            $js = $j+1;
            $pub_answer_list = [
                ['id'=>1,'title'=>'A.非常好','selected'=>0,'pnum'=>$data_count['public_question_'.$js][1],'ppbi'=>$data_count["pq{$js}c"][1]],
                ['id'=>2,'title'=>'B.较好','selected'=>0,'pnum'=>$data_count['public_question_'.$js][2],'ppbi'=>$data_count["pq{$js}c"][2]],
                ['id'=>3,'title'=>'C.一般','selected'=>0,'pnum'=>$data_count['public_question_'.$js][3],'ppbi'=>$data_count["pq{$js}c"][3]],
                ['id'=>4,'title'=>'D.比较差','selected'=>0,'pnum'=>$data_count['public_question_'.$js][4],'ppbi'=>$data_count["pq{$js}c"][4]],
                ['id'=>5,'title'=>'E.很不好','selected'=>0,'pnum'=>$data_count['public_question_'.$js][5],'ppbi'=>$data_count["pq{$js}c"][5]],
            ];

            if (isset($survey_list) && !empty($survey_list)){
                $wenti_id = 'public_question_'.$j+1;
                $daan = $survey_list[$wenti_id];
                for ($ia=0;$ia<5;$ia++){
                    if ($pub_answer_list[$ia]['id'] == $daan){
                        $pub_answer_list[$ia]['selected'] = 1;
                    }
                }
            }

            $pub_list[$j]['answer'] = $pub_answer_list;
            unset($pub_list[$j]['id']);
        }
        $data['public_question_list'] = $pub_list;
        $data['wenda'] = '您对本食堂有什么其他意见或建议？';
        $data['wenda_answer'] = isset($survey_list['public_question_4'])?$survey_list['public_question_4']:'';
        $data['user_num'] = Db::name('survey_answer')->where(['survey_id'=>$id])->count();
        unset($data['recipes_ids']);
        unset($data['public_question_ids']);

        return ajaxTable(0,'',$data);
    }
}