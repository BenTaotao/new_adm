功能说明：layui消息通知插件 6种样式，可手动关闭层，支持回调方法，可设置弹出位置，兼容主流浏览器，兼容至ie9 (ie没有svg动画)
![输入图片说明](https://images.gitee.com/uploads/images/2021/0731/194243_b57791df_1949066.png "20210731194204.png")

 **1、6种调用方法：** 

普通：info

警告：warning

成功：success

错误：error

加载：loading

关闭：destroyAll

 **2、layui使用方法** 


```
layui.use(['notify'],function(){
     var notify=layui.notify;
     notify.info("自定义消息")
})
```
基本用法

参数说明：对参数没有顺序要求，会根据参数的数据类型进行解析
 

```
        msg: "", //文字内容
        position: 'topCenter', // 弹出位置bottomRight, bottomLeft, topRight, topLeft, topCenter, bottomCenter, center
        duration: 2000, //默认2秒关闭
        showClose: true //显示关闭按钮
```




>         1、notify.info("提示消息");
>         2、notify.warning("警告消息");
>         3、notify.success("操作成功");
>         4、notify.loading("加载中");
>         5、notify.error("操作失败");
>         6、notify.error("不显示关闭按钮", false);
>         7、notify.info("提示消息", function () {
>             alert("回调成功");
>         });
>         8、notify.destroyAll(); 全部关闭
>         9、notify.info("位置显示", "topLeft"); 参数：topLeft、topCenter、topRight、bottomLeft、bottomCenter、bottomRight、center

演示地址：[https://www.17780.cn/notify/demo.html](https://www.17780.cn/notify/demo.html)