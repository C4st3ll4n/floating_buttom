import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const platform = const MethodChannel("floating_buttom");
  int count = 0;
  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler((call) {
      if(call.method =="touch"){
        setState(() {
          count++;
        });
      }
    });
    
    //platform.invokeMethod("isShowing").then((value) => print(value));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Float"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text("$count", style: TextStyle(
                fontSize: 40
              ),),
            ),
            RaisedButton(child: Text("Create"), onPressed: () {
              platform.invokeMethod("create");
            }),
            RaisedButton(child: Text("Show"), onPressed: () {
              platform.invokeMethod("show");
            }),
            RaisedButton(child: Text("Hide"), onPressed: () {
              platform.invokeMethod("hide");
            }),
          ],
        ),
      ),
    );
  }
}

/*
Caso alguém não consiga utilizar o comando

MethodChannel channel = new MethodChannel(getFlutterView(), CHANNEL);

substitua-o por

MethodChannel channel = new  MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL);
 */
