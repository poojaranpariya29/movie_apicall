import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/movie_provider.dart';
import 'Provider/search_provider.dart';
import 'View/detail_screen.dart';
import 'View/home_screen.dart';
import 'View/like_screen.dart';
import 'View/splash_screen.dart';
import 'View/view_screen.dart';

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  List<String> list = preferences.getStringList("movie") ?? [];
  List<String> removeList = preferences.getStringList("movie") ?? [];
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: "Movie Bazaar",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        themeAnimationCurve: Curves.linear,
        initialRoute: "/",
        routes: {
          "/": (context) => SplashScreen(),
          "Home": (context) => HomeScreen(),
          "Detail": (context) => DetailScreen(),
          "View": (context) => ViewScreen(),
          "Like": (context) => LikeScreen(),
        },
      ),
    );
  }
}
