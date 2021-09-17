import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybn/controllers/app.dart';

class Commentaire extends StatefulWidget {
  const Commentaire({Key? key}) : super(key: key);

  @override
  _Commentaire createState() => _Commentaire();
}

class _Commentaire extends State<Commentaire> {
  AppController appController = Get.put(AppController());

  bool efaVita = false;
  List colorAvatar = [
    Colors.blue[900],
    Colors.blueGrey[200],
    Colors.pinkAccent[50],
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        builder: (_) => Scaffold(
            appBar: AppBar(
              toolbarHeight: 45,
              backgroundColor: Colors.teal[600],
              title: Text('Espace Commentaire',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "ProductSans",
                      fontSize: 17)),
              centerTitle: true,
              actions: [
                Stack(children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.017,
                        right: MediaQuery.of(context).size.height * 0.02),
                    child: Icon(Icons.notifications_sharp),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.018,
                    right: MediaQuery.of(context).size.height * 0.02,
                    child:
                        Icon(Icons.brightness_1, size: 10, color: Colors.red),
                  )
                ]),
              ],
              actionsIconTheme: IconThemeData(color: Colors.white, size: 21),
            ),
            body: ListView(children: [
              Column(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Container(
                        width: Get.width,
                        height: Get.height * .31,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: ExactAssetImage("assets/img/baobab.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.12,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.001,
                        left: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                // top: MediaQuery.of(context).size.height * 0.00,
                                left: MediaQuery.of(context).size.width * 0.0,
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blueGrey,
                                child: Text(appController
                                    .currentContenue.user.nom[0]
                                    .toUpperCase()),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: Text(
                                            appController.currentContenue.titre,
                                            softWrap: false,
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: Colors.black))),
                                    Container(
                                      child: TextButton(
                                        onPressed: () {
                                          print("WLL");
                                        },
                                        child: Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 18,
                                                  color: Colors.grey),
                                              Text(
                                                  appController
                                                      .currentContenue.user.nom,
                                                  softWrap: false,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.grey[700])),
                                            ]),
                                      ),
                                    )
                                  ]),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    // top: MediaQuery.of(context).size.height * 0.08,
                                    // left: MediaQuery.of(context).size.width * 0.0,
                                    ),
                                child: IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.delete_sweep,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ))
                          ])),
                  Divider(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: Card(
                        color: Colors.grey[50],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                        child: ListView(children: [
                          Container(
                              // height: MediaQuery.of(context).size.height * 0.1,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.001,
                                left: MediaQuery.of(context).size.width * 0.08,
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                        // top: MediaQuery.of(context).size.height * 0.00,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.0,
                                      ),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: colorAvatar[1],
                                        child: Text(appController.user.nom[0]
                                            .toUpperCase()),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        child: Card(
                                            elevation: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(14),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.50,
                                                        child: Text(
                                                            appController
                                                                .user.nom,
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black))),
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.50,
                                                        child: Text(
                                                            "commentair.text",
                                                            softWrap: true,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black)))
                                                  ]),
                                            ))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            // top: MediaQuery.of(context).size.height * 0.08,
                                            // left: MediaQuery.of(context).size.width * 0.0,
                                            ),
                                        child:
                                            appController.user.admin == 'admin'
                                                ? IconButton(
                                                    onPressed: null,
                                                    icon: Icon(
                                                      Icons.delete_sweep,
                                                      size: 20,
                                                    ),
                                                  )
                                                : IconButton(
                                                    onPressed: null,
                                                    icon: Icon(
                                                      Icons.delete_sweep,
                                                      size: 20,
                                                      color: Colors.grey[50],
                                                    ),
                                                  ))
                                  ])),
                        ])),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.65,
                        margin: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.0113),
                        child: TextField(
                          // controller: appController.newComment,
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[800]),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.teal[100],
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide.none),
                            focusedBorder: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide.none),
                            hintText: "Entrer votre commentaire...",
                            prefixIcon: Icon(
                              Icons.message_outlined,
                              color: Colors.teal,
                              size: 17.5,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.teal[600]),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.005,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                            )),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () {
                          /*
                              if (appController.newComment.text.trim() == '')
                                return;
                              void sendComment() async {
                                //String textsave = appController.newComment.text;

                                bool res = await appController.sendComment(
                                    userController.user.id,
                                    userController.user.token,
                                    appController.newComment.text,
                                    currentVideoController.video!.id);

                                if (res) {
                                  currentVideoController.video!.commentaire.add(
                                      Commentaire(
                                          id: 0,
                                          text: appController.newComment.text,
                                          userid: userController.user.id,
                                          email: userController.user.email));
                                  appController.newComment.text = '';
                                  Get.snackbar(
                                    "Succes",
                                    "Votre Commentaire a été ajouté.",
                                    backgroundColor: Colors.grey,
                                    snackPosition: SnackPosition.BOTTOM,
                                    borderColor: Colors.grey,
                                    borderRadius: 10,
                                    borderWidth: 2,
                                    barBlur: 0,
                                    duration: Duration(seconds: 2),
                                  );
                                  currentVideoController.update();
                                }
                              }

                              sendComment();*/
                        },
                        icon: Icon(Icons.send),
                        label: Text("Commenter"),
                      )
                    ],
                  )
                ],
              ),
            ])));
  }
}
