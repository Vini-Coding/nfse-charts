import 'package:charts_test/app/home/presenter/home_page.dart';
import 'package:charts_test/app/home/presenter/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFSEs Charts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00935F),
      ),
      home: HomePage(
        store: context.watch<HomeStore>(),
      ),
    );
  }
}
