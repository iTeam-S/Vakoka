import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mybn/models/contenue.dart';
import 'package:mybn/views/home.dart';
import 'package:mybn/views/responsive.dart';

late double width, height;
class Gallery extends StatelessWidget {
const Gallery({ Key? key }) : super(key: key);

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
        title: Text("Musée"),
      ),
      body: 
        Center(
                          child: SingleChildScrollView(
                            child: Container(
                              height: height * .85,
                              child: OrientationBuilder(
                                builder: (context, orientation) {
                                  return GridView.count(
                                      // Create a grid with 2 columns in portrait mode, or 3 columns in
                                      // landscape mode.
                                      crossAxisCount: isMobile(context) ? 2 : 4,
                                      // Generate 100 widgets that display their index in the List.
                                      children: [
                                        // ignore: unused_local_variable
                                        for (Contenue contenue in appController
                                            .getContenues(appController
                                                .selectedCategorie))
                                          GestureDetector(
                                            onTap: () {
                                              
                                            },
                                            child: Card(
                                              elevation: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: Image.asset(
                                                          'assets/img/gidro.jpg',
                                                          width: width * 0.95,
                                                          height: height * 0.5,
                                                          fit:BoxFit.fill),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Flexible(
                                                    flex: 2,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Flexible(
                                                          flex: 1,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        6.0),
                                                            child: Text(
                                                              "Gidro fotsy",
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Flexible(
                                                          flex: 1,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Flexible(
                                                                flex: 5,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          6.0),
                                                                  child: Text(
                                                                      "Biby an'ala, ary efa ho lanitaminana",
                                                                      maxLines:
                                                                          2,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11.5),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                      ]);
                                },
                              ),
                            ),
                          ),
                        ),
        );
  
  }
}


