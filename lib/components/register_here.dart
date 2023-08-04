import 'package:binggo/constanta.dart';
import 'package:binggo/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterHere extends StatelessWidget {
  const RegisterHere({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: size.width,
      child: Container(
        width: size.width,
        decoration: BoxDecoration(color: Colors.grey[200]),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Don't Have An Account?",
              style: GoogleFonts.lato(fontSize: 15),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              child: Text("Register here",
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      color: colorPrimary,
                      fontWeight: FontWeight.w700)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
