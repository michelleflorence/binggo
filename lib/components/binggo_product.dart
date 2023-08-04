import 'package:binggo/models/binggo_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BinggoItemProduk extends StatelessWidget {
  const BinggoItemProduk({
    Key? key,
    required this.ontap,
    required this.size,
    required this.models,
  }) : super(key: key);

  final Size size;
  final VoidCallback? ontap;
  final BinggoModels models;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 0.2,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: ontap,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: models.imageUrl,
                    height: 150,
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
                        models.title,
                        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),

                // Price
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 7, right: 7),
                    child: Text(
                      "Rp. " + models.price.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                // Description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 7, right: 7, top: 2),
                      child: Text(models.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.normal))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
