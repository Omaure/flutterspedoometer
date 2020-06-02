import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:sensors/sensors.dart';
import 'package:geolocator/geolocator.dart';

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
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  int _currentSpeed = 0;
  int _prevSpeed = 0;
  int _tenTothirty = 0;
  int _thirtyToten = 0;
  bool _speedingUp;
  bool _slowingDown;
  int _startingTime = 0;
  int _endTime = 0;

  void setCurrentSpeed(int speed) {
    setState(() {
      _currentSpeed = speed;
    });
  }

  void setPrevSpeed(int speed) {
    setState(() {
      _prevSpeed = speed;
    });
  }

  void _calculateTime(int speed) {
    setState(() {
      _currentSpeed = speed;
      print(_currentSpeed);
      print(_prevSpeed);

      if (_currentSpeed > _prevSpeed) {
        _speedingUp = true;
        _slowingDown = false;
      }

      if (_currentSpeed < _prevSpeed) {
        _slowingDown = true;
        _speedingUp = false;
      }

      setPrevSpeed(_currentSpeed);

      //if currentspeed == 10 save time
      // when speed is == 30 save time
      if (_currentSpeed == 30 && _slowingDown) {
        _startingTime = currentTime();
      }

      if (_currentSpeed == 10 && _slowingDown) {
        _endTime = currentTime();
        _thirtyToten = _endTime - _startingTime;
      }

      if (_currentSpeed == 10 && _speedingUp) {
        _startingTime = currentTime();
      }

      if (_currentSpeed == 30 && _speedingUp) {
        _endTime = currentTime();
        _tenTothirty = _endTime - _startingTime;
      }
    });
  }

  static int currentTime() {
    var now = new DateTime.now().millisecondsSinceEpoch;
    return (now / 1000).round();
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
                    GaugeRange(
                        startValue: 0, endValue: 90, color: Colors.green),
                    GaugeRange(
                        startValue: 90, endValue: 150, color: Colors.yellow),
                    GaugeRange(
                        startValue: 150, endValue: 240, color: Colors.red),
                  ], pointers: <GaugePointer>[
                    NeedlePointer(
                        value: _currentSpeed.toDouble(),
                        enableAnimation: true,
                        needleStartWidth: 1,
                        needleEndWidth: 1)
                  ], annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Text('$_currentSpeed',
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
                        widget: Text('$_tenTothirty',
                            style: TextStyle(color: Colors.green, fontSize: 9)),
                        positionFactor: 0.5,
                        angle: 10),
                    GaugeAnnotation(
                        widget: Text("From 30 to 10",
                            style: TextStyle(color: Colors.black, fontSize: 7)),
                        axisValue: 45,
                        positionFactor: 0.5),
                    GaugeAnnotation(
                        widget: Text('$_thirtyToten',
                            style: TextStyle(color: Colors.green, fontSize: 9)),
                        axisValue: 40,
                        positionFactor: 0.5,
                        verticalAlignment: GaugeAlignment.near)
                  ])
                ],
              ),
              Text('current speed: $_currentSpeed KMh',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
              Text('From 10 to 30: $_tenTothirty Seconds',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text('From 30 to 10: $_thirtyToten Seconds',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    _getCurrentLocation() {
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          print(position.speed);
          _currentSpeed = (position.speed.abs().round() * 3.6).round();
          print(_currentSpeed);
          _getCurrentLocation();
        });
      }).catchError((e) {
        print(e);
      });
    }

    _getCurrentLocation();

//    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//      int currSpeed = (event.y).abs().round() * 10;
//      setCurrentSpeed(currSpeed);
//      _calculateTime(_currentSpeed);
//    });

    super.initState();
  }
}
