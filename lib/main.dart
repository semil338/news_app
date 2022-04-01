import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app/widgets/themes.dart';
import 'package:news_app/repositories/data_repositories.dart';
import 'package:news_app/services/api.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/view/home.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (context) => DataRepository(apiService: ApiService(Api.key())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: MyTheme.lightTheme(),
        darkTheme: MyTheme.darkTheme(),
        themeMode: ThemeMode.dark,
        home: const Home(),
      ),
    );
  }
}
