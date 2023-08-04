import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderProduk extends StatelessWidget {
  const HeaderProduk({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Binggo: Love and Dessert",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700])),
          IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.orange.shade300,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }
}
