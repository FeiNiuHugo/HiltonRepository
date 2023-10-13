import 'package:flutter/material.dart';
import '../data/model/pokemons.dart';
import '../data/model/color_map.dart';

Widget _buildDetailPokemon(PokemonV2Pokemons pokemon, Color fgColor) {
  String abilities = "";
  if (pokemon.abilities.isNotEmpty) {
    abilities = pokemon.abilities.map((e) => e.ability.name).join("\n\n");
  }
  return "" == abilities ? Container() : Text(
    abilities,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: TextStyle(
      fontSize: 22,
      color: fgColor,
    ),
  );
}

Widget pokemonDetailCard(BuildContext context, PokemonV2Species hit, PokemonV2Pokemons pokemon) {
  Color fgColor = hit.invertColor();
  return ConstrainedBox(
    constraints: const BoxConstraints.expand(),
    child: ColoredBox(
      color: hit.parseColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              pokemon.name,
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
            child: _buildDetailPokemon(pokemon, fgColor),
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    ),
  );
}
