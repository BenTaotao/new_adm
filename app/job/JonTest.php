<?php

namespace app\job;

use think\facade\Db;
use think\Log;
use think\queue\Job;

class JobTest
{
    /**
     * fire方法是消息队列默认调用的方法
     *
     * @param Job $job
     *            当前的任务对象
     * @param array|mixed $data
     *            发布任务时自定义的数据
     */
    public function fire(Job $job, $data)
    {
        while (true) {
            // 有些消息在到达消费者时,可能已经不再需要执行了
            $isJobStillNeedToBeDone = $this->checkDatabaseToSeeIfJobNeedToBeDone($data);
            if (!$isJobStillNeedToBeDone) {
                $job->delete();
                return;
            }
            $isJobDone = $this->doJob($data);
            echo $isJobDone;
            if ($isJobDone) {
                // 如果任务执行成功， 记得删除任务
                $job->delete();
                print(date('Y-m-d H:i:s') . "<info>Hello Job已完成并已删除" . "</info>\n");
            } else {
                if ($job->attempts() > 3) {
                    // 通过这个方法可以检查这个任务已经重试了几次了
                    print(date('Y-m-d H:i:s') . "<warn>Hello Job重试超过3次!" . "</warn>\n");
                    $job->delete();
                    // 也可以重新发布这个任务
                    // print("<info>Hello Job将在2s后再次可用."."</info>\n");
                    // $job->release(2); //$delay为延迟时间，表示该任务延迟2秒后再执行
                }
            }
            sleep(1);
        }
    }

    /**
     * 有些消息在到达消费者时,可能已经不再需要执行了
     *
     * @param array|mixed $data
     *            发布任务时自定义的数据
     * @return boolean 任务执行的结果
     */
    private function checkDatabaseToSeeIfJobNeedToBeDone($data)
    {
        return true;
    }

    /**
     * 根据消息中的数据进行实际的业务处理...
     */
    private function doJob($data)
    {
        //
    }
}