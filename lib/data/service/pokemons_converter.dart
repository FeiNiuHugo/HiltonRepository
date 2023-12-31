import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:hilton_quiz/data/model/pokemons.dart';
import '../model/response.dart';

class PokemonsConverter implements Converter {

  @override
  FutureOr<Request> convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );
    return encodeJson(req);
  }

  Request encodeJson(Request request) {
    final contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(Response response) async {
    return decodeJson<BodyType, InnerType>(response);
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      final mapData = json.decode(body);
      if (mapData['errors'] != null) {
        return response.copyWith<BodyType>(
          body: Error<PokemonV2SpeciesGroup>(Exception(mapData['errors'])) as BodyType
        );
      }
      final pokemonSpeciesGroup = PokemonV2SpeciesGroup.fromJson(mapData['data']);
      return response.copyWith<BodyType>(body: Success(pokemonSpeciesGroup) as BodyType);
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(
        body: Error<PokemonV2SpeciesGroup>(e as Exception) as BodyType
      );
    }
  }
}