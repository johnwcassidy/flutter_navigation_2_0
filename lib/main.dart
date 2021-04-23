import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'path_stack.dart';
import 'route_path.dart';
import 'navigation_manager.dart';

import 'lander_screen.dart';
import 'details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
  final AppRouterDelegate _routerDelegate = AppRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        key: ValueKey('main_router'), routeInformationParser: _routeInformationParser, routerDelegate: _routerDelegate);
  }
}

class AppRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  NavigationManagerDelegate _navigationManagerDelegate = NavigationManagerDelegate();

  // This router uses a Stack to push/pop/reset. All paths are stored in this stack
  // and it notifies out when any changes are made.
  final PathStack stack = PathStack(root: RoutePath.lander());

  AppRouterDelegate({Key key}) : super() {
    // inline handlers for navigation to allow to receive intents from users
    // who interact with the Navigation Manager of this class
    _navigationManagerDelegate.onPush = (RoutePath path) {
      stack.push(path);
    };

    _navigationManagerDelegate.onPop = () {
      stack.pop();
    };

    _navigationManagerDelegate.onReset = () {
      stack.reset();
    };

    // connect the notifier of the PathStack to the router notifier to trigger
    // a re-draw of this router with all the paths
    stack.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => NavigationManager(delegate: _navigationManagerDelegate),
        child: Navigator(
          key: navigatorKey,
          pages: stack.items.asMap().entries.map((e) {
            int index = e.key;
            RoutePath configuration = e.value;
            // iterate through each of the pages in our stack and construct them
            // providing the same key should prevent a new item from being created
            // so let's use the index which will be unique
            ValueKey key = ValueKey(index);
            if (configuration.isDetailsPage)
              return MaterialPage(key: key, child: DetailsScreen(itemId: configuration.argument));
            if (configuration.isLanderPage) return MaterialPage(key: key, child: LanderScreen());
          }).toList(),
          onPopPage: (route, result) {
            // let the OS handle the back press if there was nothing to pop
            if (!route.didPop(result)) {
              return false;
            }

            // if we are on the route of the application, the lander, we probably want to just exit
            // returning false means we want the OS to handle the back press
            if (stack.items.length == 1) {
              return false;
            }

            // remove from the stack and consume the back event so the
            // OS doesn't exit
            stack.pop();
            return true;
          },
        ));
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) {
    // we receive the RoutePath we created in AppRouteInformationParser::parseRouteInformation
    // This allows us to push it on the stack or manipulate the stack to what we want it to be.
    // any time we enter this code path, we probably want to rebuild the stack to control the flow
    // of the application. THis means we won't end up with a bunch of nested screens where the history
    // doesn't make sense.
    stack.push(configuration);
  }
}

class AppRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    // parsing this information will have us return something that will then be handled
    // by setNewRoutePath, so we would use this data to set stateful information
    // which is then notified to the routerdelegate, which redraws it's pages based on that information.

    // for this simple example, always assume the app launches to the lander
    return RoutePath.lander();
  }
}
