import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/login/loginPage.dart';
import 'package:flutter_app/other/save.dart';

//StatefulWidget

//1.Stateful widget可以拥有状态，这些状态在widget生命周期中是可以变的，而Stateless widget是不可变的。
//
//2.Stateful widget至少由两个类组成：
//
//一个StatefulWidget类。
//一个 State类； StatefulWidget类本身是不变的，但是State类中持有的状态在widget生命周期中可能会发生变化。
class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //该组件的状态。由于我们只需要维护一个点击次数计数器，所以定义一个_counter状态：
  int _counter = 0;

  //构建UI界面的逻辑在build方法中，当MyHomePage第一次创建时，_MyHomePageState类会被创建，
  // 当初始化完成后，Flutter框架会调用Widget的build方法来构建widget树，最终将widget树渲染到设备屏幕上。
  @override
  Widget build(BuildContext context) {
    //Scaffold 是 Material组件库中提供的一个组件，
    // 它提供了默认的导航栏、标题和包含主屏幕widget树（后同”组件树“或”部件树“）的body属性。组件树可以很复杂。
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushLogin)
        ],
      ),
      //body 组件树
      body: Center(
        //Center 可以将其子组件树对齐到屏幕中心
        child: Column(
          //Center 子组件是一个Column 组件，Column的作用是将其所有子组件沿屏幕垂直方向依次排列
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
                FlatButton(
                  child: Text("open new router"),
                  textColor: Colors.blue,
                  onPressed: () async {
                    //可以动态传递参数
                    //等待返回结果
//                    var result = await Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) {
//                        return new RandomWords();
//                      }),
//                    );

                    var result = await Navigator.of(context).pushNamed("save_page");
                    print("路由返回值: $result");
                  },
                ),
                RandomWordsWidget(), //添加一个widget
              ],
            )
          ],
        ),
      ),
      //onPressed属性接受一个回调函数，代表它被点击后的处理器
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //设置状态的自增函数。
  //当按钮点击时，会调用此函数，该函数的作用是先自增_counter，然后调用setState 方法。
  void _incrementCounter() {
    //setState方法的作用是通知Flutter框架，有状态发生了改变，Flutter框架收到通知后，会执行build方法来根据新的状态重新构建界面，
    // Flutter 对此方法做了优化，使重新执行变的很快，所以你可以重新构建任何需要更新的东西，而无需分别去修改各个widget。
    setState(() {
      _counter++;
    });
  }

  Future _pushLogin() async {
//    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//      return LoginPage();
//    }));
    var result = await Navigator.of(context).pushNamed("login", arguments: "hi");
    print("登录路由返回值：$result");
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

/**
 * 路由管理
 *
 *
 * MaterialApp(
 *  routes: {
 *          "new_page": (context) => TwoApp("内容被固定"),
 *  },)
 *
 * Navigator:
 *
 * Navigator类中第一个参数为context的静态方法都对应一个Navigator的实例方法，
 * 比如Navigator.push(BuildContext context, Route route)等价于Navigator.of(context).push(Route route)
 *
 *  1.通过路由表跳转 传递的参数必须在路由表中固定
 *      Navigator.pushNamed(context, "new_page").then((value) {
 *         //返回值 value
 *       });
 *       Navigator.push(context,
 *            MaterialPageRoute(builder: (context) {return new RandomWords();}),);
 *
 *            MaterialPageRoute继承自PageRoute类，PageRoute类是一个抽象类，表示占有整个屏幕空间的一个模态路由页面，
 *            它还定义了路由构建及切换时过渡动画的相关接口及属性。
 *            MaterialPageRoute 是Material组件库提供的组件，它可以针对不同平台，实现与平台页面切换动画风格一致的路由切换动画：
 *              1）.对于Android，当打开新页面时，新的页面会从屏幕底部滑动到屏幕顶部；
 *             当关闭页面时，当前页面会从屏幕顶部滑动到屏幕底部后消失，同时上一个页面会显示到屏幕上。
 *               2）.对于iOS，当打开页面时，新的页面会从屏幕右侧边缘一致滑动到屏幕左边，直到新页面全部显示到屏幕上，
 *             而上一个页面则会从当前屏幕滑动到屏幕左侧而消失；
 *             当关闭页面时，正好相反，当前页面会从屏幕右侧滑出，同时上一个页面会从屏幕左侧滑入。
 *  2.pushReplacement方法进入screen3页面后，此页面会执行dispose方法销毁，
 *      在screen3返回会直接进入此页面的上一个页面
 *      Navigator.pushReplacement( context, MaterialPageRoute(builder: (BuildContext context) => screen4()));
 *      Navigator.of(context).pushReplacementNamed('/screen3');
 *  3.popAndPushNamed  返回到一个存在的页面，并且pop当前页面并传递参数
 *      Navigator.popAndPushNamed(context, '/screen4');
 *  4.pushNamedAndRemoveUntil将指定的页面加入路由并且把其他所有页面pop销毁掉
 *      Navigator.of(context).pushNamedAndRemoveUntil('/screen4', (Route<dynamic> route) => false);
 *  5.pushNamedAndRemoveUntil将指定的页面加入路由，并且pop掉和screen1之间的所有页面
 *      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context) => new  screen4()),ModalRoute.withName('/'),
 *      Navigator.of(context).pushNamedAndRemoveUntil('/screen4', ModalRoute.withName('/screen1'));
 *      举例：
 *         1)1-->2-->3,3到4时使用Navigator.pushNamedAndRemoveUntil(context,"/screen4",ModalRoute.withName('/screen1'));
 *           这时候如果在页面4点击返回，将会直接退出程序。
 *         2)1-->2-->3,3到4时使用Navigator.pushNamedAndRemoveUntil(context,"/screen4",ModalRoute.withName('/'));
 *           这时候如果在页面4点击返回，将会直接回到页面1。
 *         3)1-->2-->1-->2-->3,3到4时使用Navigator.pushNamedAndRemoveUntil(context,"/screen4",ModalRoute.withName('/screen1'));
 *           这时候如果在页面4点击返回，将会回到第二个1页面。
 *
 * Pop:
 *  1.Navigator.of(context).pop();
 *      直接退出当前页面
 *  2.Navigator.of(context).maybePop();
 *      判断如果退出当前页面后出现其他页面不会出现问题就执行，否则不执行
 *  3.Navigator.of(context).canPop();
 *      判断当前页面能否执行pop操作，并返回bool
 *
 * 参数的传递也接收：
 * Navigator.of(context).pop(“传递的参数”)
 * Navigator.pushNamed(context, "new_page").then((value) {
 *         //接收的返回值 value
 *       });
 */
