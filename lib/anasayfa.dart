import 'package:blutv_odev6/filmler.dart';
import 'package:blutv_odev6/filmler_detay_sayfa.dart';
import 'package:blutv_odev6/filmler_yerli.dart';
import 'package:blutv_odev6/tema_kart.dart';
import 'package:blutv_odev6/mycolor.dart';
import 'package:blutv_odev6/yerli_filmler_detay_sayfa.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<List<Filmler>> filmleriYukle() async {
    var filmlerListesi = <Filmler>[];
    var f1 = Filmler(id: 1, ad: "Harry Potter 1", resim: "harry_potter_1.png");
    var f2 = Filmler(id: 2, ad: "Harry Potter 4", resim: "harry_potter_4.jpg");
    var f3 = Filmler(id: 3, ad: "Harry Potter 2", resim: "harry_potter_2.jpg");
    var f4 = Filmler(id: 4, ad: "Harry Potter 6", resim: "harry_potter_6.jpg");
    filmlerListesi.addAll([f1, f2, f3, f4]);
    return filmlerListesi;
  }

  Future<List<temaKart>> temalariYukle() async {
    var temaListesi = <temaKart>[
      temaKart(tur: "Aile", renk: Colors.purpleAccent),
      temaKart(tur: "Aksiyon & Macera", renk: Colors.greenAccent),
      temaKart(tur: "Animasyon", renk: Colors.blueAccent),
    ];
    return temaListesi;
  }

  Future<List<FilmlerYerli>> yerlifilmleriYukle() async {
    var yerliFilmlerListesi = <FilmlerYerli>[];
    var y1 = FilmlerYerli(
        id: 5, ad: "Making of Prens", resim: "Making_of_prens.jpg");
    var y2 = FilmlerYerli(id: 6,
        ad: "İnsanlar İkiye Ayrılır",
        resim: "insanlar_ikiye_ayrilir.jpg");
    var y3 = FilmlerYerli(id: 7, ad: "Kar ve Ayı", resim: "kar_ve_ayi.jpg");
    var y4 = FilmlerYerli(
        id: 8, ad: "Beni Sevenler Listesi", resim: "beni_sevenler_listesi.jpg");
    yerliFilmlerListesi.addAll([y1, y2, y3, y4]);
    return yerliFilmlerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: anaRenk,
      appBar: AppBar(
        backgroundColor: anaRenk,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('medyalar/blutv_logo.png', height: 32),
              SizedBox(width: 20),
              Text("Film", style: TextStyle(color: Colors.white)),
              SizedBox(width: 20),
              Text("Dizi", style: TextStyle(color: Colors.white)),
              SizedBox(width: 20,),
              Image.asset('medyalar/discovery.jpg', height: 30),
              SizedBox(width: 10),
              Image.asset('medyalar/kids_logo.jpg', height: 30),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tüm Türler ", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: FutureBuilder<List<temaKart>>(
                    future: temalariYukle(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Hata: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("Hiç tema bulunamadı"));
                      } else {
                        var temaListesi = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: temaListesi.length,
                          itemBuilder: (context, index) {
                            var tema = temaListesi[index];
                            return _buildCard(tema.tur, tema.renk);
                          },
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("En Çok İzlenen Yabancı Filmler ", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 180,
                  child: FutureBuilder<List<Filmler>>(
                    future: filmleriYukle(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Hata: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("Hiç film bulunamadı"));
                      } else {
                        var filmlerListesi = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filmlerListesi.length,
                          itemBuilder: (context, indeks) {
                            var film = filmlerListesi[indeks];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FilmlerDetaySayfa(film: film),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.only(right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("medyalar/${film.resim}", fit: BoxFit.cover, height: 150,),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("En Çok İzlenen Yerli Filmler ", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: FutureBuilder<List<FilmlerYerli>>(
                    future: yerlifilmleriYukle(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Hata: ${snapshot.error}"));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("Hiç film bulunamadı"));
                      } else {
                        var yerliFilmlerListesi = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: yerliFilmlerListesi.length,
                          itemBuilder: (context, indeks) {
                            var film = yerliFilmlerListesi[indeks];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => yerliFilmlerDetaySayfa(yfilm: film),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                margin: EdgeInsets.only(right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("medyalar/${film.resim}", fit: BoxFit.cover, height: 150,),
                                    SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'medyalar/navbar.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, Color color) {
    return Container(
      width: 275,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
