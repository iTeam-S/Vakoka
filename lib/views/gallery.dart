import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      body: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          
          children: List.generate(10, (index) {
              return  Container(
                  height: height *.03,
                  width: height*.02,
      child: Card(
                                              elevation: 8,
                                              child: Column(
                                                   children: [
                                                     
                                                    /*child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),*/
                                                      Image.asset(
                                                          'assets/img/gidro.jpg',
                                                          width: width * 0.05,
                                                          height: height * 0.05,
                                                          fit:BoxFit.cover,
                                                          ),
                                                    
                                                  
                                                  SizedBox(height: 10),
                                                
                                                    
                                                           
                                                             Text(
                                                              "Voninkiazo",
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
                                                          
                                                        
                                                        
                                                   ],
                                                 )
                                                    
                                                    )
                                                  );
                                       
    
              
            },),
        )
    );
  }
}


