
var isReady=false;var onReadyCallbacks=[];
var isServiceReady=false;var onServiceReadyCallbacks=[];
var __uniConfig = {"pages":["pages/index/index","pages/home/settings","pages/lostandfound/detail","pages/activity/bill","pages/funcitons/index","pages/game/map","pages/timetable/manage","pages/timetable/change","pages/timetable/color","pages/timetable/add","pages/timetable/repeat","pages/timetable/kechengbiao","pages/lostandfound/index","pages/lostandfound/release","pages/recruitment/index","pages/article/article","pages/game/index","pages/home/index","pages/recruitment/index","pages/songStand/songStand"],"window":{"navigationBarTextStyle":"black","navigationBarTitleText":"cyonline","navigationBarBackgroundColor":"#F8F8F8","backgroundColor":"#F8F8F8"},"tabBar":{"selectedColor":"#3478f6","color":"#000000","backgroundColor":"#FFFFFF","list":[{"pagePath":"pages/index/index","iconPath":"/static/tabbar/1.png","selectedIconPath":"/static/tabbar/12.png","text":"首页"},{"pagePath":"pages/funcitons/index","iconPath":"/static/tabbar/functions.png","selectedIconPath":"/static/tabbar/functions_choice.png","text":"功能"},{"pagePath":"pages/timetable/kechengbiao","iconPath":"/static/tabbar/kechengbiao.png","selectedIconPath":"/static/tabbar/kechengbiao_choice.png","text":"课程表"},{"pagePath":"pages/lostandfound/index","iconPath":"/static/tabbar/lostandfound.png","selectedIconPath":"/static/tabbar/lostandfound_choice.png","text":"权益"},{"pagePath":"pages/home/index","iconPath":"/static/tabbar/about.png","selectedIconPath":"/static/tabbar/3.png","text":"我的"}]},"nvueCompiler":"uni-app","nvueStyleCompiler":"weex","renderer":"auto","splashscreen":{"alwaysShowBeforeRender":true,"autoclose":false},"appname":"兰大小萃","compilerVersion":"3.1.2","entryPagePath":"pages/index/index","networkTimeout":{"request":60000,"connectSocket":60000,"uploadFile":60000,"downloadFile":60000}};
var __uniRoutes = [{"path":"/pages/index/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/home/settings","meta":{},"window":{"navigationBarTitleText":"设置"}},{"path":"/pages/lostandfound/detail","meta":{},"window":{"navigationBarTitleText":"详情"}},{"path":"/pages/activity/bill","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/funcitons/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/game/map","meta":{"isNVue":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/timetable/manage","meta":{},"window":{"navigationBarTitleText":"管理","navigationBarBackgroundColor":"#fff"}},{"path":"/pages/timetable/change","meta":{},"window":{"navigationBarTitleText":"编辑","navigationBarBackgroundColor":"#fff"}},{"path":"/pages/timetable/color","meta":{},"window":{"navigationBarTitleText":"颜色","navigationBarBackgroundColor":"#fff"}},{"path":"/pages/timetable/add","meta":{},"window":{"navigationBarTitleText":"添加","navigationBarBackgroundColor":"#fff"}},{"path":"/pages/timetable/repeat","meta":{},"window":{"navigationBarTitleText":"重复","navigationBarBackgroundColor":"#fff"}},{"path":"/pages/timetable/kechengbiao","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/lostandfound/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationBarTitleText":"招领大厅","enablePullDownRefresh":true,"onReachBottomDistance":150}},{"path":"/pages/lostandfound/release","meta":{},"window":{"navigationBarTitleText":"发布招领"}},{"path":"/pages/recruitment/index","meta":{},"window":{"navigationBarTitleText":"记者排报名表单"}},{"path":"/pages/article/article","meta":{},"window":{"navigationBarTitleText":"每日打卡"}},{"path":"/pages/game/index","meta":{},"window":{"navigationStyle":"custom"}},{"path":"/pages/home/index","meta":{"isQuit":true,"isTabBar":true},"window":{"navigationStyle":"custom"}},{"path":"/pages/songStand/songStand","meta":{},"window":{"navigationBarTitleText":"点歌台"}}];
__uniConfig.onReady=function(callback){if(__uniConfig.ready){callback()}else{onReadyCallbacks.push(callback)}};Object.defineProperty(__uniConfig,"ready",{get:function(){return isReady},set:function(val){isReady=val;if(!isReady){return}const callbacks=onReadyCallbacks.slice(0);onReadyCallbacks.length=0;callbacks.forEach(function(callback){callback()})}});
__uniConfig.onServiceReady=function(callback){if(__uniConfig.serviceReady){callback()}else{onServiceReadyCallbacks.push(callback)}};Object.defineProperty(__uniConfig,"serviceReady",{get:function(){return isServiceReady},set:function(val){isServiceReady=val;if(!isServiceReady){return}const callbacks=onServiceReadyCallbacks.slice(0);onServiceReadyCallbacks.length=0;callbacks.forEach(function(callback){callback()})}});
service.register("uni-app-config",{create(a,b,c){if(!__uniConfig.viewport){var d=b.weex.config.env.scale,e=b.weex.config.env.deviceWidth,f=Math.ceil(e/d);Object.assign(__uniConfig,{viewport:f,defaultFontSize:Math.round(f/20)})}return{instance:{__uniConfig:__uniConfig,__uniRoutes:__uniRoutes,global:void 0,window:void 0,document:void 0,frames:void 0,self:void 0,location:void 0,navigator:void 0,localStorage:void 0,history:void 0,Caches:void 0,screen:void 0,alert:void 0,confirm:void 0,prompt:void 0,fetch:void 0,XMLHttpRequest:void 0,WebSocket:void 0,webkit:void 0,print:void 0}}}});
