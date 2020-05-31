import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connected Car Uduria',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Connected Car Task, Digital Speedometer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          // Here inside the widget of the home page
          children: <Widget>[
            // defining SfrRadial gauge I was following the documentation
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(minimum: 0, maximum: 240, interval: 30, ranges: <
                    GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 90, color: Colors.green),
                  GaugeRange(
                      startValue: 90, endValue: 150, color: Colors.yellow),
                  GaugeRange(startValue: 150, endValue: 240, color: Colors.red),
                ], pointers: <GaugePointer>[
                  NeedlePointer(
                      value: 30,
                      enableAnimation: true,
                      needleStartWidth: 1,
                      needleEndWidth: 1)
                ], annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      widget: Text("30 KMh",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      positionFactor: 0.5,
                      angle: 90),
                  GaugeAnnotation(
                      widget: Text("From 10 to 30",
                          style: TextStyle(color: Colors.black, fontSize: 7)),
                      positionFactor: 0.5),
                  GaugeAnnotation(
                      widget: Text("10 Seconds",
                          style: TextStyle(color: Colors.green, fontSize: 9)),
                      positionFactor: 0.5,
                      angle: 10),
                  GaugeAnnotation(
                      widget: Text("From 30 to 10",
                          style: TextStyle(color: Colors.black, fontSize: 7)),
                      axisValue: 45,
                      positionFactor: 0.5),
                  GaugeAnnotation(
                      widget: Text("12 Seconds",
                          style: TextStyle(color: Colors.green, fontSize: 9)),
                      axisValue: 40,
                      positionFactor: 0.5,
                      verticalAlignment: GaugeAlignment.near)
                ])
              ],
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
