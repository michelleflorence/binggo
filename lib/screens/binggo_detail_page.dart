// ignore_for_file: unnecessary_type_check

import 'package:binggo/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:binggo/constanta.dart';
import 'package:binggo/models/models.dart';
import 'package:binggo/services/services.dart';
import 'package:binggo/components/binggo_rating.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BinggoDetailPage extends StatelessWidget {
  const BinggoDetailPage({required this.idBinggo});

  final String idBinggo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/share.svg"),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/more.svg"),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<ApiReturnValue<BinggoModels>>(
        future: BinggoServices.getBinggoDetail(idBinggo),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final binggo = snapshot.data!.data;
            return Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: binggo.imageUrl,
                  height: size.height * 0.35,
                  width: double.infinity,
                  // it cover the 35% of total height
                  fit: BoxFit.fill,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.discount,
                              color: ksecondaryColor,
                            ),
                            SizedBox(width: 5),
                            Text(binggo.title),
                          ],
                        ),
                        BinggoRating(numOfReviews: 24),
                        ClipPath(
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            height: 50,
                            width: 100,
                            color: colorPrimary,
                            child: Text(
                              "\Rp. ${binggo.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Hadirnya aplikasi “Bing-Go” adalah untuk memudahkan konsumen atau pengguna dalam memesan makanan dan minuman melalui aplikasi di smartphone yang terhubung dengan internet. Hal ini sangat memudahkan user untuk dapat menikmati makanan dan minuman khas Bing-Go secara praktis tanpa perlu keluar dari rumah.",
                          style: TextStyle(
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        // Free space 4% of total height
                        Container(
                          width: size.width * 0.8,
                          // it will cover 80% of total width
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: ElevatedButton(
                              onPressed: () async {
                                final result = await BinggoServices.order();
                                if (result is ApiReturnValue) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(result.data),
                                        action: SnackBarAction(
                                          label: "CLOSE",
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                          },
                                        )),
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset("assets/icons/bag.svg"),
                                    SizedBox(width: 10),
                                    Text(
                                      "Order Now",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
