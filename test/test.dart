import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
//    await tester.pumpWidget(MyApp());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);

    final age = 10;
    var name = '秦小杰';
    print(name);
    if (name == '秦小杰') {
      print(name == 'qxj');
    }

    switch (name) {
      case '秦小杰':
        name = "QXJ $name";
        print("我是${name.toLowerCase()}");
        break;
      case '123':
        print('我是$name');
        break;
    }

    var person = Person(name: name, six: "男", age: age);
    print(person);
    person.summary = 1;
    print(person);

    var x = 1.34;
    var y = 0xff;
    var z = 1.42e5;
    bool isX = true;
    var list = [];
    list.add(1);
    var list2 = [0, ...?list];

    toSay(sayHello, name);
  });
}

void sayHello(String name) => print(name);

void toSay(Function function, var name) {
  function(name);
}

void hello({String name, bool isApp}) {
  print('$name');
}

class Person {
  String name;
  String six;
  int age;
  dynamic summary;
  static const PERSON_SOLE = "Admin";

  Person({this.name, this.six, this.age, this.summary = "简介"}) {}

  @override
  String toString() {
    return 'Person: { name: $name, six: $six, age: $age, summary: $summary}';
  }
}
