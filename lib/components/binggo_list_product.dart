import 'package:binggo/screens/binggo_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/models.dart';

class BinggoListProduct extends StatelessWidget {
  const BinggoListProduct({
    Key? key,
    required this.size,
    required this.data,
  }) : super(key: key);

  final Size size;
  final List<BinggoModels> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          BinggoModels binggoModels = data[index];
          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            elevation: 0.2,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BinggoDetailPage(
                          idBinggo: binggoModels.id); //harus pake ID
                    },
                  ),
                );
              },
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: binggoModels.imageUrl,
                        height: 100,
                        width: size.width,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),

                    // Title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Text(
                            binggoModels.title,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),

                    // Price
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 7, right: 7),
                        child: Text(
                          "Rp. " + binggoModels.price.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        ),
                      ),
                    ),

                    // Description
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 7, right: 7, top: 2),
                          child: Text(binggoModels.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.normal))),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
