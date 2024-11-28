import 'package:blutv_odev6/filmler_yerli.dart';
import 'package:flutter/material.dart';

class yerliFilmlerDetaySayfa extends StatefulWidget {
  FilmlerYerli yfilm;
  yerliFilmlerDetaySayfa({required this.yfilm});

  @override
  State<yerliFilmlerDetaySayfa> createState() => _yerliFilmlerDetaySayfaState();
}

class _yerliFilmlerDetaySayfaState extends State<yerliFilmlerDetaySayfa> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(widget.yfilm.ad),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("medyalar/${widget.yfilm.resim}"),
              Text(
                "film açıklaması",
                style: const TextStyle(fontSize: 50),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
