import 'package:app_pokemon/modal/pokehub.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget{
  Pokemon pokemon;
  DetailPage({this.pokemon}) : super();
  @override
  State<StatefulWidget> createState() {
    return _StateDetailPage();
  }
}

class _StateDetailPage extends State<DetailPage>{
  @override
  Widget build(BuildContext context) {
    Pokemon p = widget.pokemon;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Detail " + p.name,),
      ),
      body: Center(
        child: Card(
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Container(
            height: MediaQuery.of(context).size.height*0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  top: -50,
                  left: MediaQuery.of(context).size.width * 0.2,
                  child: CachedNetworkImage(
                    imageUrl: p.img,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      p.name,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                        "Height : " + p.height
                    ),
                    Text(
                        "Weight : " + p.weight
                    ),
                    Text(
                      "Types",
                      style: TextStyle(color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: p.type.map((t) => FilterChip(
                        backgroundColor: Colors.amber,
                        label: Text(t),
                        onSelected: (value) {
                          print(t);
                        },
                      )).toList(),
                    ),
                    Text("Weakness", style: TextStyle(color: Colors.black),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: p.weaknesses.map((e) => FilterChip(
                        backgroundColor: Colors.red,
                        label: Text(e),
                        onSelected: (value) {
                          print(value);
                        },
                      )).toList(),
                    ),
                    Text("Next Evolution", style: TextStyle(color: Colors.black),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: p.nextEvolution == null
                      ? [Text("Null next Evolution")]
                      :p.nextEvolution.map((e) => FilterChip(
                        backgroundColor: Colors.green,
                        label: Text(e.name),
                        onSelected: (value) {
                          print(value);
                        },
                      )).toList(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}