# CountDown
倒计时控件，包括按钮倒计时，label倒计时以及在cell中的倒计时


----------

# Explanation
倒计时分两种，一种是、`固定时间的`、`短时间的`倒计时，比如按钮发送验证码（固定倒计时1分钟），或者某些功能需要的固定3、5分钟的倒计时。另一种是`截止到某日的`、`长时间的`倒计时，如活动时间一般好几天，截止到某天为止。

----------

### 固定、短时间的

* 使用多线程NSOperation，将每个倒计时放入一条线程中，可实现页面退出，重新进入继续计时，可以默认最多支持3条子线程同时工作，如果想修改，可以直接去队列OperationQueue中修改

![图片](https://github.com/WallaceYou/CountDown/blob/master/ShowImages/%E6%8C%89%E9%92%AE%E5%80%92%E8%AE%A1%E6%97%B6.gif)       ![图片](https://github.com/WallaceYou/CountDown/blob/master/ShowImages/Label%E5%80%92%E8%AE%A1%E6%97%B6.gif)


### 截止到某个时间点、长时间的

* 这类就简单很多了，由于最终的截止日期是定死的，可以直接使用GCD计时器，每秒都刷新显示一下显示计时器的View，显示的时间是当前时间和截止时间的差

![图片](https://github.com/WallaceYou/CountDown/blob/master/ShowImages/Cell%E5%80%92%E8%AE%A1%E6%97%B6.gif)
