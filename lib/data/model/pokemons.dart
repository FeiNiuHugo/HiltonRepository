import 'package:json_annotation/json_annotation.dart';

part 'pokemons.g.dart';

@JsonSerializable()
class PokemonColor {
  final int id;
  final String name;

  PokemonColor({required this.id, required this.name});

  @override
  String toString() {
    return 'PokemonColor{id: $id, name: $name}';
  }

  factory PokemonColor.fromJson(Map<String, dynamic> json) => _$PokemonColorFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonColorToJson(this);
}

@JsonSerializable()
class PokemonV2PokemonAbility {
  final String name;
  PokemonV2PokemonAbility({required this.name});

  @override
  String toString() {
    return 'PokemonV2PokemonAbility{name: $name}';
  }

  factory PokemonV2PokemonAbility.fromJson(Map<String, dynamic> json) => _$PokemonV2PokemonAbilityFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonV2PokemonAbilityToJson(this);
}

@JsonSerializable()
class PokemonV2PokemonAbilityWithID {
  final int id;
  @JsonKey(name: "pokemon_v2_ability")
  final PokemonV2PokemonAbility ability;
  PokemonV2PokemonAbilityWithID({required this.id, required this.ability});

  @override
  String toString() {
    return 'PokemonV2PokemonAbilityWithID{id: $id, ability: $ability}';
  }

  factory PokemonV2PokemonAbilityWithID.fromJson(Map<String, dynamic> json) => _$PokemonV2PokemonAbilityWithIDFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonV2PokemonAbilityWithIDToJson(this);
}

@JsonSerializable()
class PokemonV2Pokemons {
  final int id;
  final String name;
  @JsonKey(name: "pokemon_v2_pokemonabilities")
  final List<PokemonV2PokemonAbilityWithID> abilities;
  PokemonV2Pokemons({required this.id, required this.name, required this.abilities});

  @override
  String toString() {
    return 'PokemonV2Pokemons{id: $id, name: $name, abilities: $abilities}';
  }

  factory PokemonV2Pokemons.fromJson(Map<String, dynamic> json) => _$PokemonV2PokemonsFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonV2PokemonsToJson(this);
}

@JsonSerializable()
class PokemonV2Species {
  final int id;
  final String name;
  @JsonKey(name: "capture_rate")
  final int captureRate;
  @JsonKey(name: "pokemon_v2_pokemoncolor")
  final PokemonColor color;
  @JsonKey(name: "pokemon_v2_pokemons")
  final List<PokemonV2Pokemons> pokemons;
  PokemonV2Species({required this.id, required this.name, required this.captureRate, required this.color, required this.pokemons});

  PokemonV2Species.empty(): this(id: 0, name: "", captureRate: 0, color: PokemonColor(id: 0, name: ""), pokemons: <PokemonV2Pokemons>[]);

  @override
  String toString() {
    return 'PokemonV2Species{id: $id, name: $name, captureRate: $captureRate, color: $color, pokemons: $pokemons}';
  }

  factory PokemonV2Species.fromJson(Map<String, dynamic> json) => _$PokemonV2SpeciesFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonV2SpeciesToJson(this);
}

@JsonSerializable()
class PokemonV2SpeciesGroup {
  @JsonKey(name: "pokemon_v2_pokemonspecies")
  final List<PokemonV2Species> pokemonSpecies;
  PokemonV2SpeciesGroup({required this.pokemonSpecies});

  @override
  String toString() {
    return 'PokemonV2SpeciesGroup{pokemonSpecies: $pokemonSpecies}';
  }

  factory PokemonV2SpeciesGroup.fromJson(Map<String, dynamic> json) => _$PokemonV2SpeciesGroupFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonV2SpeciesGroupToJson(this);
}