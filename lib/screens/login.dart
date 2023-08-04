// ignore_for_file: unnecessary_type_check

import 'package:binggo/components/register_here.dart';
import 'package:binggo/screens/home.dart';
import 'package:binggo/services/binggo_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constanta.dart';

import '../models/models.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool hidePass = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          InputLogin(
            size: size,
            username: _username,
            password: _password,
            hidePassword: () => setState(() {
              hidePass = !hidePass;
            }),
            secure: hidePass,
          ),
          RegisterHere(size: size),
        ],
      ),
    );
  }
}

class InputLogin extends StatelessWidget {
  InputLogin(
      {Key? key,
      required this.username,
      required this.password,
      required this.size,
      this.secure = false,
      required this.hidePassword})
      : super(key: key);

  final TextEditingController username;
  final TextEditingController password;

  final VoidCallback? hidePassword;

  final Size size;

  final bool secure;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "BINGGO",
                style: GoogleFonts.lato(
                    fontSize: 28,
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                    controller: username,
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Color(0xFF666666),
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: GoogleFonts.lato(color: Color(0xff666666)),
                      hintText: "Username",
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                    showCursor: true,
                    controller: password,
                    obscureText: !secure,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Color(0xFF666666),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: hidePassword,
                        child: Icon(
                          Icons.remove_red_eye,
                          color: secure ? colorPrimary : Color(0xFF777777),
                        ),
                      ),
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: GoogleFonts.lato(color: Color(0xff666666)),
                      hintText: "Password",
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await BinggoServices.login(
                          username.text, password.text);
                      if (result is ApiReturnValue) {
                        if (result.data.substring(0, 7).toUpperCase() ==
                            "WELCOME") {
                          //TAMPILKAN SNACK BAR
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result.data),
                              action: SnackBarAction(
                                label: "CLOSE",
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                          //NAVIGATE TO NEW PAGE
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          //TAMPILKAN SNACK BAR
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Login failed"),
                              action: SnackBarAction(
                                label: "CLOSE",
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.yellow,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: Text("Sign In",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 18,
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


 // void signin() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     loading = true;
  //   });

  //   var body = new Map<String, dynamic>();
  //   body['x1'] = _username.text;
  //   body['x2'] = _password.text;

  //   try {
  //     var url = Uri.parse(baseUrl + 'get_login.php');
  //     var response = await http.post(url, body: body);
  //     Map<String, dynamic> bodyResponse = json.decode(response.body);
  //     if (bodyResponse['success'] == 1) {
  //       sharedPreferences.setString(
  //           "bio", json.encode(bodyResponse['islogged'][0]).toString());
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //     } else {
  //       final snackbar = SnackBar(
  //           content: Text(bodyResponse['message']),
  //           action: SnackBarAction(label: "CLOSE", onPressed: hideSnackBar));
  //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //     }
  //   } catch (e) {
  //     final snackbar = SnackBar(
  //         content: Text("Terjadi Kesalahan Pada Server HTTPS " + e.toString()),
  //         action: SnackBarAction(label: "CLOSE", onPressed: hideSnackBar));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  // }