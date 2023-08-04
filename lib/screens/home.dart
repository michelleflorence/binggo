// ignore_for_file: deprecated_member_use

import 'package:binggo/components/binggo_product.dart';
import 'package:binggo/constanta.dart';
import 'package:binggo/screens/binggo_detail_page.dart';
import 'package:binggo/components/binggo_carousel.dart';
import 'package:binggo/components/binggo_loading_carousel.dart';
import 'package:binggo/components/headerproduk.dart';
import 'package:binggo/screens/login.dart';
import 'package:binggo/services/binggo_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/models.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  getData() async {
    var url = Uri.parse(baseUrl + "binggo_adv.php");
    var response = await http.post(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET, PUT, PATCH, POST, DELETE",
        "Access-Control-Allow-Headers":
            "Origin, X-Requested-With, Content-Type, Accept",
      },
      body: {
        'whattodo': 'adv_binggo',
      },
    );
    return json.decode(response.body);
  }

  void logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Keluar Akun"),
            content: Text("Apakah anda yakin ingin keluar akun?"),
            actions: <Widget>[
              OutlinedButton(
                child: Text("Iya"),
                onPressed: () {
                  sharedPreferences.clear();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              OutlinedButton(
                child: Text("Tidak"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu_sharp, color: Colors.white),
          onPressed: () {},
        ),
        title: Text(
          "Binggo",
          style: GoogleFonts.lato(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.power_settings_new, color: Colors.white),
              onPressed: logout)
        ],
      ),
      body: SingleChildScrollView(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List listAds =
                        (snapshot.data! as Map<String, dynamic>)['data'];
                    return AdvertisingSlider(list: listAds);
                  } else {
                    return CarouselLoading();
                  }
                }),
            HeaderProduk(),
            FutureBuilder<ApiReturnValue<List<BinggoModels>>>(
              future: BinggoServices.getBinggo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final itemproduk = snapshot.data!.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: itemproduk.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: ((size.width / 2) / 290),
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 40,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        BinggoModels binggoModels = itemproduk[index];
                        return BinggoItemProduk(
                          size: size,
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BinggoDetailPage(
                                      idBinggo:
                                          binggoModels.id); //harus pake ID
                                },
                              ),
                            );
                          },
                          models: binggoModels,
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
