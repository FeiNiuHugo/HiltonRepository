import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../data/service/pokemons_service.dart';
import '../components/pokemon_card.dart';
import '../data/model/pokemons.dart';
import '../data/model/response.dart';
import '../data/repository/PokemonRepository.dart';

const pageCount = 10;

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  State createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late Future<Response<Result<PokemonV2SpeciesGroup>>> _future;
  late TextEditingController _searchTextController;
  late ScrollController _scrollController;
  late PokemonRepository _repository;

  int _curPageNum = 0;
  bool _loading = false;
  bool _loadMore = true;
  String _curSearchKey = "";

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController(text: "");
    _searchTextController.addListener(() {
      _curSearchKey = _searchTextController.text.trim();
    });
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final max = _scrollController.position.maxScrollExtent;
      final cur = _scrollController.position.pixels;
      if (cur >= max && _scrollController.position.atEdge) {
        loadMore();
      }
    });
    _repository = PokemonRepository();
    _future = _newRequest();
  }

  void startSearch(String value) {
    setState(() {
      _repository.dataList.clear();
      _curPageNum = 0;
      _loading = true;
      _loadMore = true;
      _repository.searchKey = value.trim();
      _future = _newRequest();
    });
  }

  void loadMore() {
    if (_loadMore && _repository.searchKey == _curSearchKey) {
      setState(() {
        _loading = true;
        _future = _newRequest();
      });
    }
  }

  _newRequest() => PokemonsServiceHelper.postPokemons(
    _searchTextController.text.trim(),
    _curPageNum,
    pageCount,
  );

  @override
  void dispose() {
    _searchTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _buildPokemonLoadingFrm(context);

  Widget _buildSearchCard() {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(_searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Search'
                      ),
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        startSearch(_searchTextController.text);
                      },
                      controller: _searchTextController,
                    )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonLoadingFrm(BuildContext context) => FutureBuilder<Response<Result<PokemonV2SpeciesGroup>>>(
    future: _future,
    builder: (context, snapshot) {
      return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    _buildSearchCard(),
                    Expanded(
                      child: _buildPokemonLoader(context, snapshot),
                    ),
                  ],
                )
            ),
            if (_loading) _buildPokemonLoadingProgress(),
          ]
        ),
      );
    },
  );

  Widget _buildPokemonLoader(BuildContext context, AsyncSnapshot<Response<Result<PokemonV2SpeciesGroup>>> snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        _loading = false;
        return _buildPokemonDefault("Something goes wrong~");
      }
      final result = snapshot.data?.body;
      if ((result == null || result is Error) && _repository.dataList.isEmpty) {
        _loading = false;
        return _buildPokemonDefault("It's empty, Oops~");
      }
      final PokemonV2SpeciesGroup pokemonV2SpeciesGroup = (result as Success<PokemonV2SpeciesGroup>).value;
      final List<PokemonV2Species> pokemonV2Species = pokemonV2SpeciesGroup.pokemonSpecies;
      if (pokemonV2Species.isEmpty && _repository.dataList.isEmpty) {
        _loading = false;
        return _buildPokemonDefault("It's empty, Oops~");
      }
      if (_loading) {
        if (pokemonV2Species.isNotEmpty) {
          _repository.dataList.addAll(pokemonV2Species.map((e) {
            return PokemonV2SpeciesWrapper("normal", e);
          }));
          _curPageNum += pageCount;
        } else {
          _loadMore = false;
          _repository.addLoadMore();
        }
        _loading = false;
      }
      return _buildPokemonList(context, _repository.dataList,);
    } else {
      if (_repository.dataList.isEmpty) {
        return Container();
      } else {
        return _buildPokemonList(context, _repository.dataList,);
      }
    }
  }

  Widget _buildPokemonList(BuildContext context, List<PokemonV2SpeciesWrapper> hits) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 310;
    final itemWidth = size.width;
    return GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: hits.length,
        itemBuilder: (BuildContext context, int index) {
          PokemonV2SpeciesWrapper wrapper = hits[index];
          if ("normal" == wrapper.type) {
            return pokemonCard(
              context,
              wrapper.item,
            );
          } else {
            return Container(
              color: Colors.white,
              height: 30.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: const Text(
                "no items can be loaded~",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
            );
          }
        },
      );
  }

  Widget _buildPokemonDefault(String content) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/images/empty_list.webp", width: 200, height: 200,),
      Text(content),
    ]
  );

  Widget _buildPokemonLoadingProgress() => Container(
    color: const Color.fromARGB(112, 0, 0, 0),
    child: Stack(
      fit: StackFit.loose,
      children: [
        Align(
          alignment: Alignment.center,
          child: LottieBuilder.asset(
            "assets/lottie/preloader.json",
            width: 200,
            height: 200,
          ),
        )
      ],
    ),
  );
}