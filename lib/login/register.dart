import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  String icons = "";
  int _count = 0;
  bool _switchSelected = false;
  bool _checkboxSelected = false;

  TextEditingController _nameController = new TextEditingController();
  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _pswFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode;

  void _getUser() {
    setState(() {
      _count++;
      icons += "\uE914";
      icons += "\uE000";
      icons += "\uE90D";
    });
  }

  @override
  void initState() {
    _nameController.text = "我是账号名称";
//    _nameController.selection =
//        TextSelection(baseOffset: 2, extentOffset: _nameController.text.length);
    _nameController.addListener(() {
      print(_nameController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "注册",
          style: TextStyle(fontFamily: 'Flamante'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
//              autofocus: true,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "手机号或邮箱",
                  prefixIcon: Icon(Icons.person)),
              controller: _nameController,
              focusNode: _nameFocusNode,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "密码",
                labelStyle: TextStyle(color: Colors.blue),
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock, color: Colors.blue),
              ),
              focusNode: _pswFocusNode,
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "电子邮件地址",
                    prefixIcon: Icon(Icons.email),
                    border: InputBorder.none),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.blue[200], width: 1.0))),
            ),
//            RaisedButton(
//              child: Text("点击"),
//              onPressed: _getUser,
//            ),
//            Text('$_count'),
            FlatButton(
              child: Text("点击2"),
              onPressed: () {
                if (null == _focusScopeNode) {
                  _focusScopeNode = FocusScope.of(context);
                }
                _focusScopeNode.requestFocus(_pswFocusNode);
              },
            ),
            OutlineButton(
              child: Text("注册"),
              onPressed: () {
                _nameFocusNode.unfocus();
                _pswFocusNode.unfocus();
              },
            ),
//            IconButton(
//              icon: Icon(Icons.add),
//              onPressed: () => {},
//            ),
//            RaisedButton(
//              color: Colors.blue,
//              highlightColor: Colors.blue[700],
//              colorBrightness: Brightness.dark,
//              splashColor: Colors.grey,
//              child: Text("自定义"),
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(20.0)),
//              onPressed: _getUser,
//            ),
//            Image(
//              image: AssetImage("assets/images/tmc_poi_hl.png"),
//              width: 100.0,
//            ),
//            Image.asset(
//              "assets/images/b_poi_hl.png",
//              width: 50.0,
//              color: Colors.grey,
//              colorBlendMode: BlendMode.difference,
//            ),
//            Image(
//              image: NetworkImage(
//                "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
//              ),
//              width: 50.0,
//              repeat: ImageRepeat.repeatY,
//            ),
//            Image.network(
//              "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
//              width: 50.0,
//            ),
//            Text(
//              icons,
//              style: TextStyle(
//                  fontFamily: "MaterialIcons",
//                  fontSize: 24.0,
//                  color: Colors.blueAccent),
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Icon(
//                  Icons.account_circle,
//                  color: Colors.green,
//                ),
//                Icon(
//                  Icons.ac_unit,
//                  color: Colors.amberAccent,
//                ),
//                Icon(
//                  Icons.accessible_forward,
//                  color: Colors.indigoAccent,
//                ),
//                Icon(
//                  MyIcons.Icons.book,
//                  color: Colors.green,
//                ),
//              ],
//            ),
//            Switch(
//              value: _switchSelected,
//              onChanged: (value) {
//                setState(() {
//                  _switchSelected = value;
//                });
//              },
//            ),
//            Checkbox(
//              value: _checkboxSelected,
//              activeColor: Colors.blue,
//              onChanged: (value) {
//                setState(() {
//                  _checkboxSelected = value;
//                });
//              },
//            )
          ],
        ),
      ),
    );
  }
}
