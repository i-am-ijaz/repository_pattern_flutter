import 'package:exception_handling/repositories/base_repository.dart';
import 'package:exception_handling/views/feed_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  BaseRepository.configure(baseUrl: "jsonplaceholder.typicode.com");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostScreen(),
    );
  }
}
