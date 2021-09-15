import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mybn/Models/data.dart';
import 'package:mybn/views/doctor_info.dart';
import 'package:mybn/views/publiPage.dart';
import 'package:mybn/Models/speciality.dart';
import 'package:mybn/views/responsive.dart';

String selectedCategorie = "Adults";
late double width, height;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ["All", "Biby", "Ravinkazo", "Ody gasy"];

  late List<SpecialityModel> specialities;
  late List<AuteurModel> lauteurs;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    specialities = getSpeciality();
    lauteurs = getAuteur();
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Arlème JONSON'),
            accountEmail: Text('arlemeJ.com@gmail.com'),
            currentAccountPicture: Image.asset('assets/img/doc.png'),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Drawer layout Item 1'),
            onTap: () {
              // This line code will close drawer programatically....
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.accessibility),
            title: Text('Drawer layout Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            height: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Drawer layout Item 3'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ) // Populate the Drawer in the next step.
          ),
      body: ListView(children: [
        /*Container(
            height: height * 0.1,
            color: Colors.white,
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
                        color: Colors.black,
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        })
                  // Spacer(),
                ],
              ),
            )),*/
        SizedBox(),
        SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                if (!isMobile(context))
                  Row(
                    children: [
                      Text(
                        "MYBN \nVolontaires",
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.8),
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          width: width * 0.25,
                          height: 50,
                          child: TextField(
                              decoration: InputDecoration(
                            hintText: 'Recherche',
                            prefixIcon: Icon(Icons.search, color: Colors.teal),
                            fillColor: Colors.blueGrey[50],
                            filled: true,
                            labelStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.blueGrey.shade50)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.blueGrey.shade50)),
                          ))),
                    ],
                  ),
                if (isMobile(context))
                  Column(
                    children: [
                      Text(
                        "Find Your \nConsultation",
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.8),
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          /*width: width * 0.75, */
                          height: 50,
                          child: TextField(
                              decoration: InputDecoration(
                            hintText: 'Recherche',
                            prefixIcon: Icon(Icons.search, color: Colors.teal),
                            fillColor: Colors.blueGrey[50],
                            filled: true,
                            labelStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.only(left: 30),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.blueGrey.shade50)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Colors.blueGrey.shade50)),
                          ))),
                    ],
                  ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                      color: Colors.black87.withOpacity(0.8),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 30,
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategorieTile(
                          categorie: categories[index],
                          isSelected: selectedCategorie == categories[index],
                          context: this,
                          key: null,
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: height * 0.15,
                  child: ListView.builder(
                      itemCount: specialities.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SpecialistTile(
                          imgAssetPath: specialities[index].imgAssetPath,
                          speciality: specialities[index].speciality,
                          noOfDoctors: specialities[index].noOfDoctors,
                          backColor: specialities[index].backgroundColor,
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Auteurs",
                  style: TextStyle(
                      color: Colors.black87.withOpacity(0.8),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                /*DoctorsTile()


                OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            // Create a grid with 2 columns in portrait mode, or 3 columns in
            // landscape mode.
            crossAxisCount: orientation == Orientation.portrait ? 2 : 5,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
             return CardList(
                          imgAssetPath: lauteurs[index].imgAssetPath,
                          speciality: lauteurs[index].speciality,
                          validite: lauteurs[index].validite,
                          name: lauteurs[index].name,
                        );
            }),
          );
        },
      ),







                GridView.count(
  // Create a grid with 2 columns. If you change the scrollDirection to
  // horizontal, this produces 2 rows.
  crossAxisCount: ,
  // Generate 100 widgets that display their index in the List.
  children: List.generate(100, (index) {
    return Center(
      child: Text(
        imgAssetPath: lauteurs[index].imgAssetPath,
                          speciality: lauteurs[index].speciality,
                          validite: lauteurs[index].validite,
                          name: lauteurs[index].name,
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }),
);
                
                */
                Center(
                  child: Container(
                    margin: EdgeInsets.only(left: width * .05),
                    height: height * .4,
                    child: OrientationBuilder(
                      builder: (context, orientation) {
                        return GridView.count(
                          // Create a grid with 2 columns in portrait mode, or 3 columns in
                          // landscape mode.
                          crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 5,
                          // Generate 100 widgets that display their index in the List.
                          children: List.generate(4, (index) {
                            return DocWidget(
                              imgAssetPath: lauteurs[index].imgAssetPath,
                              speciality: lauteurs[index].speciality,
                              validite: lauteurs[index].validite,
                              name: lauteurs[index].name,
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// ignore: must_be_immutable
class CategorieTile extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  _HomePageState context;
  CategorieTile({
    required Key? key,
    required this.categorie,
    required this.isSelected,
    required this.context,
  }) : super(key: key);

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xff008080) : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.categorie,
          style: TextStyle(
              color: widget.isSelected ? Colors.white : Color(0xff008080)),
        ),
      ),
    );
  }
}

class SpecialistTile extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final int noOfDoctors;
  final Color backColor;
  SpecialistTile(
      {required this.imgAssetPath,
      required this.speciality,
      required this.noOfDoctors,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PubliPage()));
        },
        child: Container(
          width: 150,
          height: 300,
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(imgAssetPath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            height: 50,
            width: 150,
            child: Column(
              children: [
                Text(
                  speciality,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "$noOfDoctors Votes",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ));
  }
}

class BigCard extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final bool validite;
  final String name;

  const BigCard(
      {Key? key,
      required this.imgAssetPath,
      required this.speciality,
      required this.validite,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DoctorsInfo()));
        },
        child: Container(
          width: 300,
          height: 400,
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(imgAssetPath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 100,
            width: 300,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    if (validite)
                      Icon(Icons.check_circle)
                    else
                      Icon(Icons.unpublished),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  speciality,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ));
  }
}

class CardList extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final bool validite;
  final String name;

  const CardList(
      {Key? key,
      required this.imgAssetPath,
      required this.speciality,
      required this.validite,
      required this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DoctorsInfo()));
      },
      child: Card(
        elevation: 8.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height * .1,
              width: width,
              child: Image(image: AssetImage(imgAssetPath), fit: BoxFit.cover),
            ),
            Container(
                height: height * .03,
                child: ListTile(
                  title: Text(name),
                  subtitle: Text(speciality),
                )),
          ],
          //flex: 8,
        ),
      ),
    );
  }
}

class DocWidget extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final bool validite;
  final String name;

  const DocWidget(
      {Key? key,
      required this.imgAssetPath,
      required this.speciality,
      required this.validite,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DoctorsInfo()));
      },
      child: Card(
          elevation: 8.0,
          child: Container(
            height: height * .1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(imgAssetPath),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              height: height * .2,
              width: width * .30,
              child: Row(
                children: [
                  SizedBox(height: height * 0.5),
                  if (validite)
                    Icon(Icons.check_circle)
                  else
                    Icon(Icons.unpublished),
                  Text(
                    speciality,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
