import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/fruits/presentation/bindings/fruit_binding.dart';
import 'features/fruits/presentation/pages/fruits_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Fruits Clean Architecture GetX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      initialBinding: FruitBinding(),
      home: const FruitsPage(),
    );
  }
}