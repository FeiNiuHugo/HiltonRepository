import 'package:color/color.dart' as pkg_color;
import 'package:flutter/material.dart' as lib_color;
import 'package:hilton_quiz/data/model/pokemons.dart';

extension PokemonV2SpeciesExt on PokemonV2Species {
  lib_color.Color parseColor() {
    try {
      final rgbColor = pkg_color.RgbColor.name(color.name);
      int red = rgbColor.r as int;
      int green = rgbColor.g as int;
      int blue = rgbColor.b as int;
      return lib_color.Color.fromARGB(128, red, green, blue);
    } catch (e) {
      return lib_color.Colors.white;
    }
  }

  lib_color.Color invertColor() {
    try {
      final rgbColor = pkg_color.RgbColor.name(color.name);
      int red = ~(rgbColor.r as int);
      int green = ~(rgbColor.g as int);
      int blue = ~(rgbColor.b as int);
      return lib_color.Color.fromARGB(255, red, green, blue);
    } catch (e) {
      return lib_color.Colors.white;
    }
  }
}