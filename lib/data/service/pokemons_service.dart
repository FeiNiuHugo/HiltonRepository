import 'package:chopper/chopper.dart';
import 'package:hilton_quiz/data/model/pokemons.dart';
import 'pokemons_converter.dart';
import '../model/response.dart';

part 'pokemons_service.chopper.dart';

const String apiUrl = 'https://beta.pokeapi.co/';
const String tag = "pokemon_v2_pokemonspecies";

class PokemonsServiceHelper {
  static Future<Response<Result<PokemonV2SpeciesGroup>>> postPokemons(String name, int offset, int limit) {
    String where = name.isEmpty ? "" : '{_regex: "^\\\\w*$name\\\\w*\$"}';
    final query = "offset: $offset, limit: $limit, where: {name: $where}";
    final body = <String, dynamic> {
      "query": """
      {
        $tag($query) {
          id
          name
          capture_rate
          pokemon_v2_pokemoncolor {
            id
            name
          }
          pokemon_v2_pokemons {
            id
            name
            pokemon_v2_pokemonabilities {
              id
              pokemon_v2_ability {
                name
              }
            }
          }
        }
      }
      """,
    };
    return PokemonsService.create().postPokemons(body);
  }
}

@ChopperApi()
abstract class PokemonsService extends ChopperService {

  @Post(path: "graphql/v1beta")
  Future<Response<Result<PokemonV2SpeciesGroup>>> postPokemons(
    @Body() Map<String, dynamic> body);

  static PokemonsService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(apiUrl),
      interceptors: [_interceptReq, _interceptResp, HttpLoggingInterceptor()],
      converter: PokemonsConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$PokemonsService(),
      ],
    );
    return _$PokemonsService(client);
  }
}

Request _interceptReq(Request req) {
  return req;
}

Response _interceptResp(Response resp) {
  return resp;
}