import 'package:flutter/material.dart';
import 'package:hilton_quiz/data/model/pokemons.dart';

class PokemonRepository with ChangeNotifier {
  final empty = PokemonV2Species.empty();
  final dataList = <PokemonV2SpeciesWrapper>[];
  var searchKey = "";

  void addLoadMore() {
    if (dataList.isNotEmpty && "more" != dataList.last.type) {
      dataList.add(PokemonV2SpeciesWrapper("more", empty));
    }
  }
}

class PokemonV2SpeciesWrapper {
  final String type;
  final PokemonV2Species item;
  PokemonV2SpeciesWrapper(this.type, this.item);
}