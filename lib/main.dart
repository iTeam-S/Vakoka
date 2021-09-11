import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mybn/responsive.dart';

import 'navBar.dart';

void main() {
  runApp(MyApp());
}

late double width, height;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MYBN',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: ListView(
      children: [
        Container(
            height: height * 0.1,
            color: Colors.black,
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(9.0),
                    child: Image.asset("assets/img/LOGO.png"),
                  ),
                  Spacer(),
                  if (!isMobile(context)) NavBar(),
                  if (isMobile(context))
                    IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                        onPressed: () {})
                  // Spacer(),
                ],
              ),
            )),
        //SizedBox(),
        Login()
      ],
    ));
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) ? Container(
        margin: EdgeInsets.only(left:width*0.15,top:height*0.15),
        /*width: width * 0.5,
        height: height * 0.5,*/
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
        ),
        child: 
             Row(children: [
                Positioned(
                    right: width * 0.4,
                    child: Column(
                      children: [
                        ImageMouv(),
                      ],
                    )),
                
                Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.1,
                      top: height * 0.1,
                    ),
                    child: Container(
                      width: width * 0.2,
                      child: _loginForm(),
                    ))
              ]))
            : Container(
            margin:EdgeInsets.only(left:width*0.15,right:width*0.15),
            child:Column(children: [
                Image.asset('assets/img/login.png',
                    width: width * 0.8, height: height * 0.5),
                //SizedBox(height: height * 0.1),
                Container(
                height: height * 0.5,
                  width: width * 0.8,
                  child: _loginForm(),
                )
              ])
            );
             
    /*Padding(
          padding: EdgeInsets.only(left: width * 0.4, bottom: height * 0.8),
          child: )*/
  }
}

class ImageMouv extends StatefulWidget {
  const ImageMouv({Key? key}) : super(key: key);

  @override
  _ImageMouvState createState() => _ImageMouvState();
}

class _ImageMouvState extends State<ImageMouv>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 5),
  )..repeat(reverse: true);
  late Animation<Offset> _animation = Tween(
          begin: Offset.zero, end: Offset(0, 0.08))
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SlideTransition(
        position: _animation,
        child: Column(
          children: [
            Text(
              'Veillez vous connecté ici!',
              style: TextStyle(
                fontSize: width * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset('assets/img/login.png',
                width: width * 0.4, height: height * 0.5)
          ],
        ));
  }
}

Widget _loginForm() => Column(children: [
      TextField(
          decoration: InputDecoration(
        hintText: 'email ou numéro télephone',
        fillColor: Colors.blueGrey[50],
        filled: true,
        labelStyle: TextStyle(fontSize: 12),
        contentPadding: EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blueGrey.shade50)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blueGrey.shade50)),
      )),
      SizedBox(
        height: 30,
      ),
      TextField(
          decoration: InputDecoration(
        hintText: 'Mot de passe',
        counterText: 'Mot de passe oublié ?',
        suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.teal),
        fillColor: Colors.blueGrey[50],
        filled: true,
        labelStyle: TextStyle(fontSize: 12),
        contentPadding: EdgeInsets.only(left: 30),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blueGrey.shade50)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.blueGrey.shade50)),
      )),
      SizedBox(
        height: 25,
      ),
      Container(
          decoration: BoxDecoration(
          
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 5,
                  blurRadius: 15,
                )
              ]),
          child: ElevatedButton(
            onPressed: () {},
            child: Container(
                width: double.infinity,
                child: Center(
                  child: Text('se connecter'),
                )),
            style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
          ))
    ]);