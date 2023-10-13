import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_utils_fork/widgets.dart';
import '../ui/pokemon_list.dart';
import '../theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) => KeyboardAware(
    builder: (context, keyboardConfig) => Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: primaryColor,
          statusBarColor: primaryColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: primaryColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        centerTitle: true,
        title: const Text(
          "Pokémons",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        ),
      ),
      body: const Material(
        child: PokemonList(),
      ),
      resizeToAvoidBottomInset: false,
    ),
  );
}