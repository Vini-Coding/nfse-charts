import 'package:charts_test/app/app_widget.dart';
import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeRepository(),
      child: const AppWidget(),
    ),
  );
}
