import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mybn/controllers/app.dart';
import 'package:mybn/views/responsive.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

late double width, height;
final RoundedLoadingButtonController _btnController =
    RoundedLoadingButtonController();

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
            color: Colors.white,
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(9.0),
                    child: Image.asset("assets/img/LOGO.png"),
                  ),
                  /*Spacer(),
                  if (!isMobile(context)) Container(),
                  if (isMobile(context))
                    IconButton(
                        icon: Icon(Icons.menu),
                        color: Colors.black,
                        onPressed: () {})*/
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
    return (!isMobile(context))
        ? Container(
            margin: EdgeInsets.only(left: width * 0.15, top: height * 0.15),
            /*width: width * 0.5,
        height: height * 0.5,*/
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent,
            ),
            child: Row(children: [
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
                    child: LoginForm(),
                  ))
            ]))
        : Container(
            margin: EdgeInsets.only(left: width * 0.15, right: width * 0.15),
            child: Column(children: [
              SvgPicture.asset('assets/img/login_mobile.svg',
                  width: width * 0.8, height: height * 0.5),
              //SizedBox(height: height * 0.1),
              Container(
                height: height * 0.5,
                width: width * 0.8,
                child: LoginForm(),
              )
            ]));

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
            SvgPicture.asset('assets/img/login_mobile.svg',
                width: width * 0.8, height: height * 0.5),
          ],
        ));
  }
}

class LoginForm extends StatelessWidget {
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(children: [
      Text('TONGASOA !',
          style: TextStyle(
              color: Colors.teal,
              fontSize: width * 0.020,
              fontWeight: FontWeight.bold)),
      TextField(
          controller: appController.emailController,
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
          controller: appController.passwordController,
          obscureText: true,
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
          ),
          child: RoundedLoadingButton(
            controller: _btnController,
            color: Colors.teal,
            successColor: Colors.teal[700],
            borderRadius: 30,
            onPressed: () {
              appController.login(
                  _btnController,
                  appController.emailController.text,
                  appController.passwordController.text);
            },
            child: Container(
                width: double.infinity,
                child: Center(
                  child: Text('se connecter'),
                )),
          ))
    ]));
  }
}
