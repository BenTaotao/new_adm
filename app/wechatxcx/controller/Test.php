<?php
/**
 * Created by
 * User BaiXiantao
 * Date 2022/9/9
 * Time 17:02
 */

namespace app\api\controller;

use think\facade\Db;

class Test
{
    public function index()
    {
        $id = 13;
        $datas_q = Db::name('survey_answer')
            ->where(['survey_id'=>$id])
            ->field('question_1,question_2,question_3,question_4,question_5,question_6,public_question_1,public_question_2,public_question_3')
            ->select();
        $datas_count = Db::name('survey_answer')
            ->where(['survey_id'=>$id])
            ->field('count(question_1) as q1c,count(question_2) as q2c,count(question_3) as q3c,count(question_4) as q4c,count(question_5) as q5c,count(question_6) as q6c,count(public_question_1) as pq1c,count(public_question_2) as pq2c,count(public_question_3) as pq3c')
            ->select()->toArray()[0];
        $question_count = [
            'question_1'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
            'question_2'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
            'question_3'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
            'question_4'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
            'question_5'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
            'question_6'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
            'public_question_1'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
            'public_question_2'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
            'public_question_3'=>[1=>0, 2=>0, 3=>0, 4=>0, 5=>0],
        ];
        foreach ($datas_q as $key=>$val){
            if ($val['question_1'] == 1){
                $question_count['question_1'][1] = $question_count['question_1'][1] + 1;
                $question_count['q1c'][1] =
                    $question_count['question_1'][1] != 0 ? number_format( ($question_count['question_1'][1] / $datas_count['q1c']) * 100, 2, '.', '') : 0;
            }if ($val['question_1'] == 2){
                $question_count['question_1'][2] = $question_count['question_1'][2] + 1;
                $question_count['q1c'][2] =
                    $question_count['question_1'][2] != 0 ? number_format( ($question_count['question_1'][2] / $datas_count['q1c']) * 100, 2, '.', '') : 0;
            }if ($val['question_1'] == 3){
                $question_count['question_1'][3] = $question_count['question_1'][3] + 1;
                $question_count['q1c'][3] =
                    $question_count['question_1'][3] != 0 ? number_format( ($question_count['question_1'][3] / $datas_count['q1c']) * 100, 2, '.', '') : 0;
            }if ($val['question_1'] == 4){
                $question_count['question_1'][4] = $question_count['question_1'][4] + 1;
                $question_count['q1c'][4] =
                    $question_count['question_1'][4] != 0 ? number_format( ($question_count['question_1'][4] / $datas_count['q1c']) * 100, 2, '.', '') : 0;
            }if ($val['question_1'] == 5){
                $question_count['question_1'][5] = $question_count['question_1'][5] + 1;
                $question_count['q1c'][5] =
                    $question_count['question_1'][5] != 0 ? number_format( ($question_count['question_1'][5] / $datas_count['q1c']) * 100, 2, '.', '') : 0;
            }

            if ($val['question_2'] == 1){
                $question_count['question_2'][1] = $question_count['question_2'][1] + 1;
                $question_count['q2c'][1] =
                    $question_count['question_2'][1] != 0 ? number_format( ($question_count['question_2'][1] / $datas_count['q2c']) * 100, 2, '.', '') : 0;
            }if ($val['question_2'] == 2){
                $question_count['question_2'][2] = $question_count['question_2'][2] + 1;
                $question_count['q2c'][2] =
                    $question_count['question_2'][3] != 0 ? number_format( ($question_count['question_2'][3] / $datas_count['q2c']) * 100, 2, '.', '') : 0;
            }if ($val['question_2'] == 3){
                $question_count['question_2'][3] = $question_count['question_2'][3] + 1;
                $question_count['q2c'][3] =
                    $question_count['question_2'][3] != 0 ? number_format( ($question_count['question_2'][3] / $datas_count['q2c']) * 100, 2, '.', '') : 0;
            }if ($val['question_2'] == 4){
                $question_count['question_2'][4] = $question_count['question_2'][4] + 1;
                $question_count['q2c'][4] =
                    $question_count['question_2'][4] != 0 ? number_format( ($question_count['question_2'][4] / $datas_count['q2c']) * 100, 2, '.', '') : 0;
            }if ($val['question_2'] == 5){
                $question_count['question_2'][5] = $question_count['question_2'][5] + 1;
                $question_count['q2c'][5] =
                    $question_count['question_2'][5] != 0 ? number_format( ($question_count['question_2'][5] / $datas_count['q2c']) * 100, 2, '.', '') : 0;
            }

            if ($val['question_3'] == 1){
                $question_count['question_3'][1] = $question_count['question_3'][1] + 1;
                $question_count['q3c'][1] =
                    $question_count['question_3'][1] != 0 ? number_format( ($question_count['question_3'][1] / $datas_count['q3c']) * 100, 2, '.', '') : 0;
            }if ($val['question_3'] == 2){
                $question_count['question_3'][2] = $question_count['question_3'][2] + 1;
                $question_count['q3c'][2] =
                    $question_count['question_3'][2] != 0 ? number_format( ($question_count['question_3'][2] / $datas_count['q3c']) * 100, 2, '.', '') : 0;
            }if ($val['question_3'] == 3){
                $question_count['question_3'][3] = $question_count['question_3'][3] + 1;
                $question_count['q3c'][3] =
                    $question_count['question_3'][3] != 0 ? number_format( ($question_count['question_3'][3] / $datas_count['q3c']) * 100, 2, '.', '') : 0;
            }if ($val['question_3'] == 4){
                $question_count['question_3'][4] = $question_count['question_3'][4] + 1;
                $question_count['q3c'][4] =
                    $question_count['question_3'][4] != 0 ? number_format( ($question_count['question_3'][4] / $datas_count['q3c']) * 100, 2, '.', '') : 0;
            }if ($val['question_3'] == 5){
                $question_count['question_3'][5] = $question_count['question_3'][5] + 1;
                $question_count['q3c'][5] =
                    $question_count['question_3'][5] != 0 ? number_format( ($question_count['question_3'][5] / $datas_count['q3c']) * 100, 2, '.', '') : 0;
            }

            if ($val['question_4'] == 1){
                $question_count['question_4'][1] = $question_count['question_4'][1] + 1;
                $question_count['q4c'][1] =
                    $question_count['question_4'][1] != 0 ? number_format( ($question_count['question_4'][1] / $datas_count['q4c']) * 100, 2, '.', '') : 0;
            }if ($val['question_4'] == 2){
                $question_count['question_4'][2] = $question_count['question_4'][2] + 1;
                $question_count['q4c'][2] =
                    $question_count['question_4'][2] != 0 ? number_format( ($question_count['question_4'][2] / $datas_count['q4c']) * 100, 2, '.', '') : 0;
            }if ($val['question_4'] == 3){
                $question_count['question_4'][3] = $question_count['question_4'][3] + 1;
                $question_count['q4c'][3] =
                    $question_count['question_4'][3] != 0 ? number_format( ($question_count['question_4'][3] / $datas_count['q4c']) * 100, 2, '.', '') : 0;
            }if ($val['question_4'] == 4){
                $question_count['question_4'][4] = $question_count['question_4'][4] + 1;
                $question_count['q4c'][4] =
                    $question_count['question_4'][4] != 0 ? number_format( ($question_count['question_4'][4] / $datas_count['q4c']) * 100, 2, '.', '') : 0;
            }if ($val['question_4'] == 5){
                $question_count['question_4'][5] = $question_count['question_4'][5] + 1;
                $question_count['q4c'][5] =
                    $question_count['question_4'][5] != 0 ? number_format( ($question_count['question_4'][5] / $datas_count['q4c']) * 100, 2, '.', '') : 0;
            }

            if ($val['question_5'] == 1){
                $question_count['question_5'][1] = $question_count['question_5'][1] + 1;
                $question_count['q5c'][1] =
                    $question_count['question_5'][1] != 0 ? number_format( ($question_count['question_5'][1] / $datas_count['q5c']) * 100, 2, '.', '') : 0;
            }if ($val['question_5'] == 2){
                $question_count['question_5'][2] = $question_count['question_5'][2] + 1;
                $question_count['q5c'][2] =
                    $question_count['question_5'][2] != 0 ? number_format( ($question_count['question_5'][2] / $datas_count['q5c']) * 100, 2, '.', '') : 0;
            }if ($val['question_5'] == 3){
                $question_count['question_5'][3] = $question_count['question_5'][3] + 1;
                $question_count['q5c'][3] =
                    $question_count['question_5'][3] != 0 ? number_format( ($question_count['question_5'][3] / $datas_count['q5c']) * 100, 2, '.', '') : 0;
            }if ($val['question_5'] == 4){
                $question_count['question_5'][4] = $question_count['question_5'][4] + 1;
                $question_count['q5c'][4] =
                    $question_count['question_5'][4] != 0 ? number_format( ($question_count['question_5'][4] / $datas_count['q5c']) * 100, 2, '.', '') : 0;
            }if ($val['question_5'] == 5){
                $question_count['question_5'][5] = $question_count['question_5'][5] + 1;
                $question_count['q5c'][5] =
                    $question_count['question_5'][5] != 0 ? number_format( ($question_count['question_5'][5] / $datas_count['q5c']) * 100, 2, '.', '') : 0;
            }

            if ($val['question_6'] == 1){
                $question_count['question_6'][1] = $question_count['question_6'][1] + 1;
                $question_count['q6c'][1] =
                    $question_count['question_6'][1] != 0 ? number_format( ($question_count['question_6'][1] / $datas_count['q6c']) * 100, 2, '.', '') : 0;
            }if ($val['question_6'] == 2){
                $question_count['question_6'][2] = $question_count['question_6'][2] + 1;
                $question_count['q6c'][2] =
                    $question_count['question_6'][2] != 0 ? number_format( ($question_count['question_6'][2] / $datas_count['q6c']) * 100, 2, '.', '') : 0;
            }if ($val['question_6'] == 3){
                $question_count['question_6'][3] = $question_count['question_6'][3] + 1;
                $question_count['q6c'][3] =
                    $question_count['question_6'][3] != 0 ? number_format( ($question_count['question_6'][3] / $datas_count['q6c']) * 100, 2, '.', '') : 0;
            }if ($val['question_6'] == 4){
                $question_count['question_6'][4] = $question_count['question_6'][4] + 1;
                $question_count['q6c'][4] =
                    $question_count['question_6'][4] != 0 ? number_format( ($question_count['question_6'][4] / $datas_count['q6c']) * 100, 2, '.', '') : 0;
            }if ($val['question_6'] == 5){
                $question_count['question_6'][5] = $question_count['question_6'][5] + 1;
                $question_count['q6c'][5] =
                    $question_count['question_6'][5] != 0 ? number_format( ($question_count['question_6'][5] / $datas_count['q6c']) * 100, 2, '.', '') : 0;
            }

            if ($val['public_question_1'] == 1){
                $question_count['public_question_1'][1] = $question_count['public_question_1'][1] + 1;
                $question_count['pq1c'][1] =
                    $question_count['public_question_1'][1] != 0 ? number_format( ($question_count['public_question_1'][1] / $datas_count['pq1c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_1'] == 2){
                $question_count['public_question_1'][2] = $question_count['public_question_1'][2] + 1;
                $question_count['pq1c'][2] =
                    $question_count['public_question_1'][2] != 0 ? number_format( ($question_count['public_question_1'][2] / $datas_count['pq1c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_1'] == 3){
                $question_count['public_question_1'][3] = $question_count['public_question_1'][3] + 1;
                $question_count['pq1c'][3] =
                    $question_count['public_question_1'][3] != 0 ? number_format( ($question_count['public_question_1'][3] / $datas_count['pq1c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_1'] == 4){
                $question_count['public_question_1'][4] = $question_count['public_question_1'][4] + 1;
                $question_count['pq1c'][4] =
                    $question_count['public_question_1'][4] != 0 ? number_format( ($question_count['public_question_1'][4] / $datas_count['pq1c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_1'] == 5){
                $question_count['public_question_1'][5] = $question_count['public_question_1'][5] + 1;
                $question_count['pq1c'][5] =
                    $question_count['public_question_1'][5] != 0 ? number_format( ($question_count['public_question_1'][5] / $datas_count['pq1c']) * 100, 2, '.', '') : 0;
            }

            if ($val['public_question_2'] == 1){
                $question_count['public_question_2'][1] = $question_count['public_question_2'][1] + 1;
                $question_count['pq2c'][1] =
                    $question_count['public_question_2'][1] != 0 ? number_format( ($question_count['public_question_2'][1] / $datas_count['pq2c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_2'] == 2){
                $question_count['public_question_2'][2] = $question_count['public_question_2'][2] + 1;
                $question_count['pq2c'][2] =
                    $question_count['public_question_2'][2] != 0 ? number_format( ($question_count['public_question_2'][2] / $datas_count['pq2c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_2'] == 3){
                $question_count['public_question_2'][3] = $question_count['public_question_2'][3] + 1;
                $question_count['pq2c'][3] =
                    $question_count['public_question_2'][3] != 0 ? number_format( ($question_count['public_question_2'][3] / $datas_count['pq2c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_2'] == 4){
                $question_count['public_question_2'][4] = $question_count['public_question_2'][4] + 1;
                $question_count['pq2c'][4] =
                    $question_count['public_question_2'][4] != 0 ? number_format( ($question_count['public_question_2'][4] / $datas_count['pq2c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_2'] == 5){
                $question_count['public_question_2'][5] = $question_count['public_question_2'][5] + 1;
                $question_count['pq2c'][5] =
                    $question_count['public_question_2'][5] != 0 ? number_format( ($question_count['public_question_2'][5] / $datas_count['pq2c']) * 100, 2, '.', '') : 0;
            }

            if ($val['public_question_3'] == 1){
                $question_count['public_question_3'][1] = $question_count['public_question_3'][1] + 1;
                $question_count['pq3c'][1] =
                    $question_count['public_question_3'][1] != 0 ? number_format( ($question_count['public_question_3'][1] / $datas_count['pq3c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_3'] == 2){
                $question_count['public_question_3'][2] = $question_count['public_question_3'][2] + 1;
                $question_count['pq3c'][2] =
                    $question_count['public_question_3'][2] != 0 ? number_format( ($question_count['public_question_3'][2] / $datas_count['pq3c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_3'] == 3){
                $question_count['public_question_3'][3] = $question_count['public_question_3'][3] + 1;
                $question_count['pq3c'][3] =
                    $question_count['public_question_3'][3] != 0 ? number_format( ($question_count['public_question_3'][3] / $datas_count['pq3c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_3'] == 4){
                $question_count['public_question_3'][4] = $question_count['public_question_3'][4] + 1;
                $question_count['pq3c'][4] =
                    $question_count['public_question_3'][4] != 0 ? number_format( ($question_count['public_question_3'][4] / $datas_count['pq3c']) * 100, 2, '.', '') : 0;
            }if ($val['public_question_3'] == 5){
                $question_count['public_question_3'][5] = $question_count['public_question_3'][5] + 1;
                $question_count['pq3c'][5] =
                    $question_count['public_question_3'][5] != 0 ? number_format( ($question_count['public_question_3'][5] / $datas_count['pq3c']) * 100, 2, '.', '') : 0;
            }
        }

        halt($question_count);
    }
}