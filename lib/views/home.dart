import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mybn/models/data.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybn/controllers/app.dart';
import 'package:mybn/controllers/upload.dart';
import 'package:mybn/translation.dart';
import 'package:mybn/views/doctor_info.dart';
import 'package:mybn/views/publiPage.dart';
import 'package:mybn/models/speciality.dart';
import 'package:mybn/views/responsive.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

String selectedCategorie = "Adults";
late double width, height;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ["All", "Biby", "Ravinkazo", "Ody gasy"];
  final AppController appController = Get.put(AppController());
  final UploadController uploadController = Get.put(UploadController());
  late List<SpecialityModel> specialities;
  late List<AuteurModel> lauteurs;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  bool isLoadingPath = false;

  void onFocusChange() {
    debugPrint("Focus: " + appController.focus.hasFocus.toString());
    if (appController.focus.hasFocus) _openFileExplorer();
  }

  dynamic _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null) {
        print('ato va?');
        PlatformFile file = result.files.first;
        uploadController.filepath = file.path.toString();
        uploadController.filetitre.text = file.name;
      } else {
        print("Annuler");
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    appController.focus.addListener(onFocusChange);

    specialities = getSpeciality();
    lauteurs = getAuteur();
  }

  void addVideo(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text(
                "Ajout d'un Document",
              ),
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                        vertical: MediaQuery.of(context).size.height * 0.0113),
                    child: TextField(
                      controller: uploadController.titre,
                      style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal[60],
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none),
                        hintText: "Titre",
                        prefixIcon: Icon(Icons.edit, color: Colors.teal),
                      ),
                    )),
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                        vertical: MediaQuery.of(context).size.height * 0.0113),
                    child: TextField(
                      controller: uploadController.description,
                      keyboardType: TextInputType.multiline,
                      minLines: 1, //Normal textInputField will be displayed
                      maxLines: null, // when
                      style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal[60],
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none),
                        hintText: "Description",
                        prefixIcon: Icon(Icons.edit, color: Colors.teal),
                      ),
                    )),
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                        vertical: MediaQuery.of(context).size.height * 0.0113),
                    child: TextField(
                      controller: uploadController.texte,
                      style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal[60],
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none),
                        hintText: "Texte",
                        prefixIcon: Icon(Icons.edit, color: Colors.teal),
                      ),
                    )),
                Container(
                    color: Colors.teal[60],
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.5,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.09,
                      // vertical: MediaQuery.of(context).size.height*0.0110,
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      value: uploadController.regionChoix,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconEnabledColor: Colors.teal[700],
                      iconSize: 25,
                      underline: SizedBox(),
                      hint: Text(uploadController.regionChoix,
                          style: TextStyle(fontSize: 14)),
                      items: [
                        for (String mod in uploadController.regions)
                          DropdownMenuItem(
                            child: Text(mod),
                            value: mod,
                          ),
                      ],
                      onChanged: (value) {
                        uploadController.regionChoix = value.toString();
                        //dataController.forceUpdate();
                        Navigator.pop(context);
                        addVideo(context);
                      },
                    )),
                Container(
                    color: Colors.teal[60],
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.5,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.09,
                      // vertical: MediaQuery.of(context).size.height*0.0110,
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      value: uploadController.categorie,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconEnabledColor: Colors.teal[700],
                      iconSize: 25,
                      underline: SizedBox(),
                      hint: Text(uploadController.categorie,
                          style: TextStyle(fontSize: 14)),
                      items: [
                        DropdownMenuItem(
                            child: Text('Catégories'), value: 'Catégories'),
                        DropdownMenuItem(child: Text('Biby'), value: 'Biby'),
                        DropdownMenuItem(child: Text('Ody'), value: 'Ody'),
                      ],
                      onChanged: (value) {
                        uploadController.categorie = value.toString();
                        //dataController.forceUpdate();
                        Navigator.pop(context);
                        addVideo(context);
                      },
                    )),
                Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                      // vertical: MediaQuery.of(context).size.height*0.0110
                    ),
                    child: TextField(
                      controller: uploadController.filetitre,
                      focusNode: appController.focus,
                      style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.teal[60],
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none),
                        hintText: "Fichier",
                        prefixIcon:
                            Icon(Icons.file_copy_outlined, color: Colors.teal),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06,
                    // vertical:MediaQuery.of(context).size.height*0.01
                  ),
                  child: RoundedLoadingButton(
                    onPressed: () {
                      appController.process(_btnController);
                    },
                    color: Colors.teal,
                    successColor: Colors.teal[600],
                    controller: _btnController,
                    valueColor: Colors.white,
                    borderRadius: 90,
                    child:
                        Text("AJOUTER", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('ok');
          addVideo(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal[700],
        elevation: 10,
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(appController.user.nom),
            accountEmail: Text(appController.user.email),
            currentAccountPicture: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.teal,
              child: Text(appController.user.email[0].toUpperCase()),
            ),
            decoration: BoxDecoration(color: Colors.teal[600]),
          ),
          ListTile(
            leading: Icon(Icons.place_outlined),
            title: Text(translate('carte', appController.lang)),
            onTap: () {
              // appController.logout();
            },
          ),
          Divider(
            height: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text(translate('deconnexion', appController.lang)),
            onTap: () {
              appController.logout();
            },
          ),
          Divider(
            height: 2.0,
          ),
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
