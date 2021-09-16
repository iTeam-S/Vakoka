import 'package:flutter/material.dart';

late double width, height;

class PubliPage extends StatelessWidget {
  const PubliPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Zavaboary"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height * .2,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage("assets/img/baobab.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: height * .8,
                  decoration: BoxDecoration(color: Colors.white,
                      /*borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),*/
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: height * .04,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Colors.teal[300],
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.check_circle,
                                          color: Colors.white),
                                      Text(
                                        'Rakoto',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )
                                    ])),
                            Container(
                              height: height * .04,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  color: Colors.teal[300],
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.white,
                                    ),
                                    Text('Download',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))
                                  ]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: height * .025),
                      Divider(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Flexible(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Morengy',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    "Le Morengy est un sport dangereux pratiquer par les malagasy"),
                              ),
                              Divider(height: 5),
                              Text('lorem', overflow: TextOverflow.fade)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * .03),
                      Divider(height: 5),
                      SizedBox(height: height * .03),
                      Container(
                        width: width * .7,
                        child: Row(children: []),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
