import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybn/models/contenue.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mybn/controllers/app.dart';
import 'package:mybn/controllers/upload.dart';
import 'package:mybn/translation.dart';
// ignore: unused_import
import 'package:mybn/views/publiPage.dart';
import 'package:mybn/models/speciality.dart';
import 'package:mybn/views/responsive.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

late double width, height;
final AppController appController = Get.put(AppController());

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    appController.init();
  }

  void addDocument(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Text(
                translate("Ajout_d_un_document", appController.lang),
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
                        hintText: translate('Titre', appController.lang),
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
                        hintText: translate('Description', appController.lang),
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
                        hintText: translate('Texte', appController.lang),
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
                        addDocument(context);
                      },
                    )),
                /*Container(
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
                            child: Text(
                                translate('categorie', appController.lang)),
                            value: 'categorie'),
                        DropdownMenuItem(
                            child: Text(translate('biby', appController.lang)),
                            value: 'biby'),
                        
                      ],
                      onChanged: (value) {
                        uploadController.categorie = value.toString();
                        //dataController.forceUpdate();
                        Navigator.pop(context);
                        addDocument(context);
                      },
                    )),*/
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
                        hintText: translate('Fichier', appController.lang),
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
                    child: Text(translate('AJOUTER', appController.lang),
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ));
  }

  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return GetBuilder<AppController>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0.0,
          // ignore: deprecated_member_use
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addDocument(context);
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
                Get.toNamed('/carte');
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
            ListTile(
              leading: Icon(Icons.g_translate_sharp),
              title: Text(translate('Traduire', appController.lang)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.collections_outlined),
              title: Text(translate('Gellery', appController.lang)),
              onTap: () {
                Get.toNamed('/gallery');
              },
            ),
          ],
        ) // Populate the Drawer in the next step.
            ),
        body: appController.data.length == 0
            ? Shimmer(
                color: Colors.black,
                child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Chargement...'),
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.9,
                        minWidth: MediaQuery.of(context).size.width * 0.9),
                  ),
                ),
              )
            : ListView(children: [
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
                              Image.asset(
                                'assets/img/logof.png',
                                width: Get.width * .2,
                                height: Get.height * .2,
                              ),
                              Spacer(),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  width: width * 0.3,
                                  height: 50,
                                  child: TextField(
                                      onChanged: (text) {
                                        appController.search(text);
                                      },
                                      controller: appController.queryController,
                                      decoration: InputDecoration(
                                        hintText: 'Recherche',
                                        prefixIcon: Icon(Icons.search,
                                            color: Colors.teal),
                                        fillColor: Colors.blueGrey[50],
                                        filled: true,
                                        labelStyle: TextStyle(fontSize: 12),
                                        contentPadding:
                                            EdgeInsets.only(left: 30),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.blueGrey.shade50)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.blueGrey.shade50)),
                                      ))),
                            ],
                          ),
                        if (isMobile(context))
                          Column(
                            children: [
                              Image.asset(
                                'assets/img/logof.png',
                                width: Get.width * .35,
                                height: Get.height * .1,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  /*width: width * 0.75, */
                                  height: 50,
                                  child: TextField(
                                      onChanged: (text) {
                                        appController.search(text);
                                      },
                                      controller: appController.queryController,
                                      decoration: InputDecoration(
                                        hintText: 'Recherche',
                                        prefixIcon: Icon(Icons.search,
                                            color: Colors.teal),
                                        fillColor: Colors.blueGrey[50],
                                        filled: true,
                                        labelStyle: TextStyle(fontSize: 12),
                                        contentPadding:
                                            EdgeInsets.only(left: 30),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.blueGrey.shade50)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color:
                                                    Colors.blueGrey.shade50)),
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
                        Center(
                          child: Container(
                            height: 30,
                            child: ListView.builder(
                                itemCount: appController.getCategories().length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CategorieTile(
                                    categorie:
                                        appController.getCategories()[index],
                                    isSelected: appController
                                            .selectedCategorie ==
                                        appController.getCategories()[index],
                                    context: this,
                                    key: null,
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SingleChildScrollView(
                            child: Container(
                              height: height * .5,
                              child: OrientationBuilder(
                                builder: (context, orientation) {
                                  return GridView.count(
                                      // Create a grid with 2 columns in portrait mode, or 3 columns in
                                      // landscape mode.
                                      crossAxisCount: isMobile(context) ? 2 : 4,
                                      // Generate 100 widgets that display their index in the List.
                                      children: [
                                        for (Contenue contenue in appController
                                            .getContenues(appController
                                                .selectedCategorie))
                                          GestureDetector(
                                            onTap: () {
                                              appController.currentContenue =
                                                  contenue;
                                              Get.toNamed('/page');
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
                                                              8.0),
                                                      child: SvgPicture.asset(
                                                          'assets/img/book.svg',
                                                          width: width * 0.8,
                                                          height: height * 0.5),
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
                                                              contenue.titre,
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
                                                                      contenue
                                                                          .description,
                                                                      maxLines:
                                                                          2,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11.5),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
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
                      ],
                    ),
                  ),
                ),
              ]),
      ),
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
          appController.selectedCategorie = widget.categorie;
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
