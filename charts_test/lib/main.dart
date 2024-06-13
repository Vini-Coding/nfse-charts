import 'package:charts_test/app/app_widget.dart';
import 'package:charts_test/app/home/presenter/store/home_store.dart';
import 'package:charts_test/app/home/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<HomeRepository>(create: (context) => HomeRepository()),
        ChangeNotifierProvider<HomeStore>(
          create: (context) => HomeStore(
            repository: context.read<HomeRepository>()
          ),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
