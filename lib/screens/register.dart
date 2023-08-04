// ignore_for_file: unnecessary_type_check

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:binggo/constanta.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import 'package:binggo/screens/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool loading = false;
  bool hidePass = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          InputRegister(
            name: _name,
            email: _email,
            username: _username,
            password: _password,
            size: size,
            loading: loading,
            hidePassword: () => setState(() {
              hidePass = !hidePass;
            }),
            secure: hidePass,
          ),
        ],
      ),
    );
  }
}

class InputRegister extends StatelessWidget {
  InputRegister(
      {Key? key,
      required this.name,
      required this.email,
      required this.username,
      required this.password,
      required this.loading,
      required this.size,
      this.secure = false,
      required this.hidePassword})
      : super(key: key);

  final bool loading;

  final VoidCallback? hidePassword;

  final Size size;

  late final bool secure;

  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController username;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned(
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
                        showCursor: true,
                        controller: name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.account_circle,
                            color: Color(0xFF666666),
                          ),
                          fillColor: Color(0xFFF2F3F5),
                          hintText: "Name",
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextField(
                        showCursor: true,
                        controller: email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xFF666666),
                          ),
                          fillColor: Color(0xFFF2F3F5),
                          hintText: "Email",
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextField(
                        showCursor: true,
                        controller: username,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                          hintText: "Password",
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await BinggoServices.register(
                                name.text,
                                email.text,
                                username.text,
                                password.text);
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
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            foregroundColor: Colors.yellow, // foreground
                          ),
                          child: loading
                              ? CircularProgressIndicator()
                              : Text("Register",
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        Positioned(
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
                  "Already have An Account?",
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Text("Login here",
                      style: GoogleFonts.lato(
                          fontSize: 15,
                          color: colorPrimary,
                          fontWeight: FontWeight.w700)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
