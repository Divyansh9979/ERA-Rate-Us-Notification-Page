import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:open_appstore/open_appstore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Rating Prompt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // appStoreIdentifier: '',
    googlePlayIdentifier: 'com.assitantera.strot&hl=en',
  );

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {
      // ignore: todo
      // TODO: Comment out this if statement to test rating dialog (Remember to uncomment)
      //if (_rateMyApp.shouldOpenDialog) {
      _rateMyApp.showRateDialog(
        context,
        title: 'Enjoying The App?',
        message: 'Please leave a rating!',
        actionsBuilder: (context) {
          return [
            FlatButton(
              child: Text('Rate Us'),
              onPressed: () {
                OpenAppstore.launch(
                    androidAppId: "com.assitantera.strot&hl=en", iOSAppId: "");
              },
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No Thanks')),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Remind Me Later'))
          ];
        },
        dialogStyle: DialogStyle(
          titleAlign: TextAlign.center,
          messageAlign: TextAlign.center,
          messagePadding: EdgeInsets.only(bottom: 20.0),
        ),
        //starRatingOptions: StarRatingOptions(),
      );
      //}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
