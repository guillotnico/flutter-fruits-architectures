import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/fruits/data/datasources/fruit_remote_data_source.dart';
import 'features/fruits/data/repositories/fruit_repository_impl.dart';
import 'features/fruits/domain/usecases/get_all_fruits.dart';
import 'features/fruits/presentation/bloc/fruit_bloc.dart';
import 'features/fruits/presentation/pages/fruits_page.dart';

void main() {
  final httpClient = http.Client();
  final remoteDataSource = FruitRemoteDataSourceImpl(client: httpClient);
  final repository = FruitRepositoryImpl(remoteDataSource: remoteDataSource);
  final getAllFruitsUseCase = GetAllFruits(repository);

  runApp(MyApp(getAllFruits: getAllFruitsUseCase));
}

class MyApp extends StatelessWidget {
  final GetAllFruits getAllFruits;

  const MyApp({Key? key, required this.getAllFruits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fruits Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => FruitBloc(getAllFruits: getAllFruits),
        child: const FruitsPage(),
      ),
    );
  }
}