import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/model/pokemons.dart';
import '../data/model/color_map.dart';

Widget _buildPokemons(PokemonV2Species pokemonV2Species, Color fgColor) {
  List<PokemonV2Pokemons> pokemonV2Pokemons = pokemonV2Species.pokemons;
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: SizedBox(
      height: 150,
      child: pokemonV2Pokemons.isNotEmpty ? ListView.separated(
        itemCount: pokemonV2Pokemons.length,
        itemBuilder: (context, index) {
          final item = pokemonV2Pokemons[index];
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              GoRouter.of(context).push("/detail", extra: <String, dynamic>{
                "pokemonV2Species": pokemonV2Species,
                "item": item,
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Text(
                item.name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: fgColor,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8.0,);
        },
      ) : Container(),
    )
  );
}

Widget pokemonCard(BuildContext context, PokemonV2Species hit) {
  Color fgColor = hit.invertColor();
  return Card(
    elevation: 4.0,
    color: hit.parseColor(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            hit.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: fgColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "${hit.captureRate}",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: fgColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        _buildPokemons(hit, fgColor),
      ],
    ),
  );
}
