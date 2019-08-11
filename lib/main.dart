import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'home/homePage.dart';
import 'login/loginPage.dart';
import 'login/registerPage.dart';
import 'other/save.dart';

Color white = const Color(0xFFFFFFFF); //16进制的ARGB  Colors.white
Color blue = const Color.fromARGB(0xFF, 0x42, 0xA5, 0xF5);
Color blue1 = const Color.fromARGB(255, 66, 165, 245);
Color blue2 = const Color.fromRGBO(66, 165, 245, 1.0); //opacity：不透明度

//MyApp 应用的根组件 MyApp类代表Flutter应用，它继承了 StatelessWidget类，这也就意味着应用本身也是一个widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //MaterialApp 是Material库中提供的Flutter APP框架，
    // 通过它可以设置应用的名称、主题、语言、首页及路由列表等。
    // MaterialApp也是一个widget。
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.grey, //主题颜色
            primaryColor: white),
        home: HomePage(title: '首页'),
        //命名路由 注册路由表
        //优点：
        //1.语义化更明确。
        //2.代码更好维护；如果使用匿名路由，则必须在调用Navigator.push的地方创建新路由页，这样不仅需要import新路由页的dart文件，而且这样的代码将会非常分散。
        //3.可以通过onGenerateRoute做一些全局的路由跳转前置处理逻辑。
        routes: {
          //1.传参 类似构造函数传值 参数在Navigator.of(context).pushNamed("login_page", arguments: "hi")时传递
          //"tip2": (context){
          //     return TipRoute(text: ModalRoute.of(context).settings.arguments);
          //   },
          "login_page": (context) => LoginPage(),
          "register_page": (context) => RegisterPage(),
          "save_page": (context) => RandomWords(),
        },
        //onGenerateRoute只会对命名路由生效  在需要判断页面进入权限是拦截
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) {
            String routeName = settings.name;
            debugPrint("路由钩子：${routeName.toString()}");
            switch (routeName) {
              case "login":
                return RegisterPage();
                break;
              default:
                break;
            }
            // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
            // 引导用户登录；其它情况则正常打开路由。
            return LoginPage();
          });
        });
  }
}

void _collectLog(ZoneDelegate parent, Zone zone, String line) {
  //收集日志
  parent.print(zone, "main-collectLog: $line");
//  print("main-collectLog: $line");
}

void _reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志的逻辑
  print("main-reportErrorAndLog: ${details.toString()}");
}

FlutterErrorDetails _makeDetails(Object obj, StackTrace stack) {
  //构建错误信息
  return FlutterErrorDetails(stack: stack, exception: obj);
}

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'route1':
      return MyApp();
    default:
      return MyApp();
  }
}

//接收android 原生传递过来的参数  window.defaultRouteName
//void main() => runApp(_widgetForRoute(window.defaultRouteName));

void main() {
  //捕获异常信息
  FlutterError.onError = (FlutterErrorDetails details) {
    _reportErrorAndLog(details);
  };
//  runApp(_widgetForRoute(window.defaultRouteName));
  runZoned(() => runApp(_widgetForRoute(window.defaultRouteName)),
      zoneSpecification: ZoneSpecification(
          print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
    _collectLog(parent, zone, line);
  }), onError: (Object obj, StackTrace stack) {
    //Zone中未捕获异常处理回调， 该error-zone中发生未捕获异常(无论同步还是异步)时都会调用开发者提供的回调
    var details = _makeDetails(obj, stack);
    _reportErrorAndLog(details);
  });
//Zone表示一个代码执行的环境范围，为了方便理解，读者可以将Zone类比为一个代码执行沙箱，
// 不同沙箱的之间是隔离的，沙箱可以捕获、拦截或修改一些代码行为，
// 如Zone中可以捕获日志输出、Timer创建、微任务调度的行为，同时Zone也可以捕获所有未处理的异常
} //应用入口main函数
