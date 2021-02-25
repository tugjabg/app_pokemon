import 'dart:convert';

import 'package:app_pokemon/component/detail/detail_page.dart';
import 'package:app_pokemon/modal/pokehub.dart';
import 'package:flutter/material.dart';
import "package:cached_network_image/cached_network_image.dart";
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeList _pokeList;
  fetchData() async{
    var response = await http.get(url);
    var decodeJsonPokemon = jsonDecode(response.body);
    _pokeList = PokeList.fromJson(decodeJsonPokemon);
    print(_pokeList.POKEMON.length);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Widget _element(Pokemon pokemon){
    return InkWell(
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: CachedNetworkImage(
                imageUrl: pokemon.img,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(
              pokemon.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(pokemon: pokemon,)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is pokemon app"),
      ),
      body: _pokeList == null
      ? Center(
        child: CircularProgressIndicator(),
      )
      : GridView.builder(
        itemCount: _pokeList.POKEMON.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => _element(_pokeList.POKEMON.elementAt(index))
      )
    );
  }
}