import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybn/controllers/app.dart';
import 'package:mybn/views/responsive.dart';

late double width, height;
final AppController appController = Get.put(AppController());

class PubliPage extends StatelessWidget {
  const PubliPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Details"),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: height * .04,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (appController
                                          .currentContenue.user.officiel)
                                        Icon(Icons.check_circle,
                                            color: Colors.teal),
                                      Text(
                                        appController.currentContenue.user.nom,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal[600]),
                                      )
                                    ])),
                            Container(
                              height: height * .04,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (appController.currentContenue.files !=
                                        '')
                                    (!isMobile(context))?Container(
                                        child:Row(
                                          children: [
                                            IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.download_for_offline,
                                            color: Colors.teal,
                                          )),
                                    Text(appController.currentContenue.files,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal))
                                          ],
                                        )
                                      ) :Icon(
                                            Icons.download_for_offline,
                                            color: Colors.teal,
                                          )
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
                                title: Text(appController.currentContenue.titre,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    appController.currentContenue.description),
                              ),
                              Divider(height: 5),
                              Text(appController.currentContenue.texte,
                                  overflow: TextOverflow.fade)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * .03),
                      Divider(height: 5),
                      SizedBox(height: height * .03),
                     Container(
                       child: Column(
                        children: [
                         
                        ],
                        
        ),
                       ),
                     
                      Container(
                        
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/commentaire');
                          },
                          child: Text('Espace Commentaire'),
                        ),
                      )
                    ],
                  )),
            )/** */
          ],
        ),
      ),
    );
  }
}
