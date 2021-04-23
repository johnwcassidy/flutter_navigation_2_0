import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation_manager.dart';
import 'route_path.dart';

class LanderScreen extends StatefulWidget {
  LanderScreen({Key key}) : super(key: key);

  @override
  _MyLanderScreenState createState() => _MyLanderScreenState();
}

class _MyLanderScreenState extends State<LanderScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lander Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is a lander screen.',
              textAlign: TextAlign.center,
              textScaleFactor: 3,
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<NavigationManager>(context, listen: false).push(RoutePath.details('9999'));
                },
                child: Text(
                  'Details for 9999',
                  textScaleFactor: 2,
                )),
          ],
        ),
      ),
    );
  }
}
