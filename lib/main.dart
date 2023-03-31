import 'package:flutter/material.dart';
import 'package:flutter_todo/route/route_constant.dart';
import 'package:flutter_todo/route/route_manager.dart';
import 'package:flutter_todo/style/app_colors.dart';
import 'package:flutter_todo/task/database/db_helper.dart';
import 'package:flutter_todo/task/ui/task_listing_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: AppRouteManager.navigatorKey,
      onGenerateRoute: AppRouteManager.onGenerateRoute,
      initialRoute: RouteConstant.home,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: AppColors.appBarColor,
          centerTitle: true,
          elevation: 0,
        ),
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        fontFamily: 'Poppins',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.fABColor,
        ),
      ),
      home: const TaskListingScreen(),
    );
  }
}
