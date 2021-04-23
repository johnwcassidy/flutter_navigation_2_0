import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String itemId;

  DetailsScreen({Key key, this.itemId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailsScreenAppState();
}

class _DetailsScreenAppState extends State<DetailsScreen> {
  @override
  void initState() {
    // do something for the details screen
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Details for selected item ${widget.itemId}',
              textAlign: TextAlign.center,
              textScaleFactor: 3,
            ),
          ],
        ),
      ),
    );
  }
}
