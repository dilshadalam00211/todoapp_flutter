import 'package:flutter/material.dart';
import 'package:flutter_todo/route/route_constant.dart';
import 'package:flutter_todo/task/ui/add_task_screen.dart';
import 'package:flutter_todo/task/ui/task_listing_screen.dart';

class AppRouteManager {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static PageRoute onGenerateRoute(RouteSettings settings) {
    Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case RouteConstant.home:
        return MaterialPageRoute(
          builder: (context) => const TaskListingScreen(),
          settings: const RouteSettings(
            name: RouteConstant.home,
          ),
        );
      case RouteConstant.addTask:
        return MaterialPageRoute(
          builder: (context) => AddTaskScreen(
            task: args?["task"],
            index: args?["index"],
          ),
          settings: const RouteSettings(
            name: RouteConstant.addTask,
          ),
        );
    }

    return MaterialPageRoute(
      builder: (context) => const Center(
        child: Text('404!!'),
      ),
    );
  }

  static Future<T?>? pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  static void pop<T extends Object?>() {
    return navigatorKey.currentState?.pop();
  }
}
