import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'providers/fruit_provider.dart';
import 'screens/fruit_screen.dart';
import 'services/fruit_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(
          create: (_) => http.Client(),
          dispose: (_, client) => client.close(),
        ),

        ProxyProvider<http.Client, FruitService>(
          update: (_, client, previousService) => FruitService(client: client),
        ),

        ChangeNotifierProxyProvider<FruitService, FruitProvider>(
          create: (context) => FruitProvider(
            fruitService: context.read<FruitService>(),
          ),
          update: (_, service, previousProvider) => FruitProvider(
            fruitService: service,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Fruits (Provider)',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        home: const FruitsScreen(),
      ),
    );
  }
}