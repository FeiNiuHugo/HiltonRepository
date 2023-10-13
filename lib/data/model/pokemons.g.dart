// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonColor _$PokemonColorFromJson(Map<String, dynamic> json) => PokemonColor(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$PokemonColorToJson(PokemonColor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

PokemonV2PokemonAbility _$PokemonV2PokemonAbilityFromJson(
        Map<String, dynamic> json) =>
    PokemonV2PokemonAbility(
      name: json['name'] as String,
    );

Map<String, dynamic> _$PokemonV2PokemonAbilityToJson(
        PokemonV2PokemonAbility instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

PokemonV2PokemonAbilityWithID _$PokemonV2PokemonAbilityWithIDFromJson(
        Map<String, dynamic> json) =>
    PokemonV2PokemonAbilityWithID(
      id: json['id'] as int,
      ability: PokemonV2PokemonAbility.fromJson(
          json['pokemon_v2_ability'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonV2PokemonAbilityWithIDToJson(
        PokemonV2PokemonAbilityWithID instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pokemon_v2_ability': instance.ability,
    };

PokemonV2Pokemons _$PokemonV2PokemonsFromJson(Map<String, dynamic> json) =>
    PokemonV2Pokemons(
      id: json['id'] as int,
      name: json['name'] as String,
      abilities: (json['pokemon_v2_pokemonabilities'] as List<dynamic>)
          .map((e) =>
              PokemonV2PokemonAbilityWithID.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonV2PokemonsToJson(PokemonV2Pokemons instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pokemon_v2_pokemonabilities': instance.abilities,
    };

PokemonV2Species _$PokemonV2SpeciesFromJson(Map<String, dynamic> json) =>
    PokemonV2Species(
      id: json['id'] as int,
      name: json['name'] as String,
      captureRate: json['capture_rate'] as int,
      color: PokemonColor.fromJson(
          json['pokemon_v2_pokemoncolor'] as Map<String, dynamic>),
      pokemons: (json['pokemon_v2_pokemons'] as List<dynamic>)
          .map((e) => PokemonV2Pokemons.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonV2SpeciesToJson(PokemonV2Species instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capture_rate': instance.captureRate,
      'pokemon_v2_pokemoncolor': instance.color,
      'pokemon_v2_pokemons': instance.pokemons,
    };

PokemonV2SpeciesGroup _$PokemonV2SpeciesGroupFromJson(
        Map<String, dynamic> json) =>
    PokemonV2SpeciesGroup(
      pokemonSpecies: (json['pokemon_v2_pokemonspecies'] as List<dynamic>)
          .map((e) => PokemonV2Species.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonV2SpeciesGroupToJson(
        PokemonV2SpeciesGroup instance) =>
    <String, dynamic>{
      'pokemon_v2_pokemonspecies': instance.pokemonSpecies,
    };
