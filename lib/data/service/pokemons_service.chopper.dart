// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: type=lint
final class _$PokemonsService extends PokemonsService {
  _$PokemonsService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PokemonsService;

  @override
  Future<Response<Result<PokemonV2SpeciesGroup>>> postPokemons(
      Map<String, dynamic> body) {
    final Uri $url = Uri.parse('graphql/v1beta');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Result<PokemonV2SpeciesGroup>, PokemonV2SpeciesGroup>($request);
  }
}
