import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/home/home.dart';
import 'package:flutter_app/login/login.dart';
import 'package:flutter_app/login/register.dart';
import 'package:flutter_app/other/save.dart';

class BottomAppBarTab extends StatefulWidget {
  @override
  _BottomAppBarTabState createState() => _BottomAppBarTabState();
}

class _BottomAppBarTabState extends State<BottomAppBarTab> {
  int page = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this.page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[HomePage(title: '首页'), RandomWords(), RegisterPage(), LoginPage()],
        onPageChanged: onPageChanged,
        controller: pageController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).accentColor,
        shape: CircularNotchedRectangle(), //悬浮按钮与菜单栏结合的方式
        notchMargin: 6.0, //悬浮按钮与菜单栏之间的距离
        child: _tabBars(),
      ),
    );
  }

  Widget _tabBars() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buttonBottomItem(Icons.home, 0, "首页"),
        _buttonBottomItem(Icons.message, 1, "消息"),
        _buttonBottomItem(null, -1, "发布"),
        _buttonBottomItem(Icons.fingerprint, 2, "发现"),
        _buttonBottomItem(Icons.edit_location, 3, "我的"),
      ],
    );
  }

  GestureDetector _buttonBottomItem(IconData iconData, int index, String name) {
    Widget padItem = SizedBox();
    EdgeInsetsGeometry padding = this.page == index
        ? EdgeInsets.only(top: 8.0)
        : EdgeInsets.only(top: 6.0);
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          color: Theme.of(context).accentColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _selectIcon(iconData, index),
              Text(
                name,
                style: _selectTextStyle(index),
              )
            ],
          ),
        ),
      );
    }

    return GestureDetector(
        onTap: () {
          _onTap(index);
        },
        child: padItem);
  }

  TextStyle _selectTextStyle(int value) {
    return this.page == value
        ? TextStyle(fontSize: 11.0, color: Theme.of(context).cardColor)
        : TextStyle(fontSize: 10.0, color: Colors.black);
  }

  Widget _selectIcon(IconData iconData, int value) {
    return this.page == value
        ? Icon(
            iconData,
            color: Theme.of(context).cardColor,
            size: 25,
          )
        : Icon(
            iconData,
            color: Colors.black,
            size: 20,
          );
  }

  void _onTap(int value) {
    if (value == -1) return;
    print("滑动到" + value.toString());
    pageController.animateToPage(value,
        duration: const Duration(microseconds: 100), curve: Curves.ease);
  }

  void onPageChanged(int value) {
    setState(() {
      this.page = value;
    });
  }
}
