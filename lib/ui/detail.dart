import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hilton_quiz/data/model/pokemons.dart';
import '../components/pokemon_detail_card.dart';
import '../theme/colors.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
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
      leading: Container(
        margin: const EdgeInsets.all(10),
        child: IconButton(
          color: Colors.white,
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      centerTitle: true,
      title: const Text(
        "Pokémon Detail",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white),
      ),
    ),
    body: () {
      final map = GoRouterState.of(context).extra as Map<String, dynamic>;
      PokemonV2Species pokemonV2Species = map["pokemonV2Species"];
      PokemonV2Pokemons item = map["item"];
      return pokemonDetailCard(context, pokemonV2Species, item);
    }(),
  );
}