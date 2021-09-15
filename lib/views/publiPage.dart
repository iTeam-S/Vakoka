import 'package:flutter/material.dart';

late double width, height;

class PubliPage extends StatelessWidget {
  const PubliPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      /*appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Zavaboary"),
      ),*/
      body: Stack(
        children: [
          Container(
            width: width,
            height: height * .6,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage("assets/img/baobab.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * .5,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.2),
                          offset: Offset(0, -4),
                          blurRadius: 0)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 30,
                        right: 30,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Fandraoka",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                )),
                          ),
                          MaterialButton(
                              onPressed: () {},
                              shape: CircleBorder(),
                              child: Icon(Icons.favorite_border,
                                  size: 30, color: Colors.teal))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 30,
                        right: 30,
                      ),
                      child: Flexible(
                        child: Text("data"),
                      ),
                    )
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                  onPressed: () {},
                  shape: CircleBorder(),
                  child: Icon(Icons.favorite, size: 30, color: Colors.teal)),
              MaterialButton(
                  onPressed: () {},
                  shape: CircleBorder(),
                  child: Icon(Icons.favorite, size: 30, color: Colors.teal))
            ],
          )
        ],
      ),
    );
  }
}