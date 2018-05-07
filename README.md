# swift_project
之前的项目，用swift敲了一遍，目前主体已经完成，只剩下一些小页面了，算是自己认真对待的一份代码。有意见和建议请指出，万分感谢。

另外，目前运行项目会报错，原因是由于版权问题，所以里面的接口和图片名称都没加上。后面我会加上运行效果图，到时候大家可以根据效果图查看代码了。

## 自定义控件
*这里面，我自己封装了一些经常用到的控件，如Segment、Refresh、PictureShow、Progress等，可以很方便地调用。*
* #### GJSegment
![GJSegment](https://github.com/manofit/ScreenPics/blob/master/swfit_pro_pics/segment.gif)
* #### GJRefresh
![GJRefresh](https://github.com/manofit/ScreenPics/blob/master/swfit_pro_pics/mj_footer.gif)![GJRefresh](https://github.com/manofit/ScreenPics/blob/master/swfit_pro_pics/mj_header.gif)
* #### GJPictureShow
![GJPictureShow](https://github.com/manofit/ScreenPics/blob/master/swfit_pro_pics/pic_show.gif)
* #### GJProgressView
![GJProgressView](https://github.com/manofit/ScreenPics/blob/master/swfit_pro_pics/progress.gif)

*后面还会继续对项目里面的一些其他内容，比如倒计时按钮进行封装。*

## 代码结构
* 项目主要采用MVC的设计模式，在ViewControllers文件夹中包含所有的页面：登录相关、主页、出借、个人中心。每一块下面又分为三个文件夹：Model、View、Controller。

* 封装了网络请求，基于Alamofire。文件夹NetWork下有GJNetwork、GJNetWorkTool、GJNetworkReachability三个类，其中GJNetworkReachability用来检查网络状态，GJNetWorkTool用来实现每一个网络请求，GJNetwork是直接与Alamofire交互的类。

* NetWorkFile类存放所有请求的URL；VariableDefineFile类存放所有的变量，相当于宏。

* GJUtil是工厂类，里面封装了几个常用UI控件的创建方法，还包含一些类似于检测手机号码、MD5加密、base64加密等常用方法。

* Base文件夹下是几个基类。GJBaseViewController是所有视图的父类，GJBaseWebViewController是所有需要加载H5页面的父类。

## 项目才创建不久，平时编写的时候难免会有纰漏的地方，请大家不吝赐教。
