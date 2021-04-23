import 'dart:collection';
import 'package:flutter/material.dart';
import 'route_path.dart';

class PathStack with ChangeNotifier {
  // define the root path that will be the basis of your navigation stack
  RoutePath _rootPath;

  // store all the paths in your stack to be rendered out
  List<RoutePath> _paths;

  // construct the stack with the root path being inserted by default
  PathStack({RoutePath root}) {
    _rootPath = root;
    _paths = [_rootPath];
  }

  UnmodifiableListView<RoutePath> get items => UnmodifiableListView(_paths);

  void push(RoutePath path) {
    // check to see if this path is our root, in which case ensure we reset to the root
    if (path.id == _rootPath.id) {
      _paths = [_rootPath];
      notifyListeners();
      return;
    }

    // add route path to our navigation stack
    _paths.add(path);

    // notify listeners that we need to redraw our application to account for new pages
    notifyListeners();
  }

  RoutePath pop() {
    try {
      final poppedItem = _paths.removeLast();
      notifyListeners();
      return poppedItem;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // reset the stack to be just to root path
  void reset() {
    _paths = [_rootPath];
  }
}
