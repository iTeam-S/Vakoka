import 'package:flutter/material.dart';

class AppColor {
  static var black = Color(0xFF2F2F3E);
  static var bodyColor = Color(0xFF6F8398);
}

late double width, height;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
            child: Container(
      height: height * 0.9,
      width: width * 0.9,
      margin: EdgeInsets.all(20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0, 8),
            blurRadius: 5.0),
      ]),
      child: Column(
        children: [
          header(),
          // hero(),
          Expanded(child: section()),
          //bottomButton()
        ],
      ),
    )));
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text("MEN'S ORIGINAL",
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16)),
              Text("Smith Shoes",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24))
            ],
          ),
        ],
      ),
    );
  }

  Widget section() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In "
            "rutrum at ex non eleifend. Aenean sed eros a purus "
            "gravida scelerisque id in orci. Mauris elementum id "
            "nibh et dapibus. Maecenas lacinia volutpat magna",
            textAlign: TextAlign.justify,
            style:
                TextStyle(color: AppColor.bodyColor, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 20),
          property()
        ],
      ),
    );
  }

  Widget property() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bottomButton(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Size",
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  color: AppColor.bodyColor.withOpacity(0.10),
                  child: Text(
                    "Vote: 10.2",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget bottomButton() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
              onPressed: () {},
              child: Text(
                "Je valide",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
          Text(r"", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28))
        ],
      ),
    );
  }
}
