// ignore_for_file: unused_import, must_be_immutable, avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:html';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gapura/controllers/categories_controller.dart';
import 'package:gapura/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gapura/screens/articles/articles_label_modal.dart';
import 'package:gapura/screens/articles/articles_sublabel_modal.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:gapura/constants.dart';

import 'package:gapura/screens/components/my_fields.dart';
import 'package:gapura/screens/components/header.dart';
import 'package:gapura/screens/components/recent_files.dart';
import 'package:gapura/screens/components/storage_details.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticlesAddModal extends StatefulWidget {
  @override
  State<ArticlesAddModal> createState() => _ArticlesAddModal();
}

class _ArticlesAddModal extends State<ArticlesAddModal> {
  String labelString = "";
  String sublabelString = "";

  String categoriesPicked;
  List listCategories;

  DateTime _selectedDate;

  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController tableuController = TextEditingController();
  TextEditingController tableuHeightController =
      TextEditingController(text: "400");
  TextEditingController iframeController = TextEditingController();
  HtmlEditorController descriptionController = HtmlEditorController(
    processInputHtml: true,
    processOutputHtml: true,
  );
  TextEditingController dateController = TextEditingController();

  List<int> imageBytes;
  String imageString;

  bool contentLoad = true;

  getCategories() async {
    String url = dotenv.env['BASE_URL'] + "api/v1/categories";
    var uri = Uri.parse(url);

    var response = await http.get(uri);
    var decodeJson = json.decode(response.body)["data"];
    if (jsonDecode(response.body)["error"] == false) {
      setState(() {
        listCategories = decodeJson;
      });
      contentLoad = false;
      notif("Updated");
    } else {
      setState(() {});
      notif("Error");
    }
  }

  pickImage() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = false;
    uploadInput.accept = '.png,.jpg,.jpeg';
    uploadInput.size = 2000000;
    uploadInput.click();
    document.body.append(uploadInput);
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = FileReader();
      reader.onLoadEnd.listen((value) {
        var _bytesData =
            Base64Decoder().convert(reader.result.toString().split(",").last);
        setState(() {
          imageBytes = _bytesData;
          imageString = reader.result;
        });
      });
      reader.readAsDataUrl(file);
    });
    uploadInput.remove();
  }

  postData() async {
    final prefs = await SharedPreferences.getInstance();
    var descriptionText = await descriptionController.getText();
    String url = dotenv.env['BASE_URL'] + "api/v1/article/add";
    var uri = Uri.parse(url);
    var response = await http.post(
      uri,
      headers: {"Authorization": "Bearer " + prefs.getString('token')},
      body: (imageString == null)
          ? {
              "categories_id": categoriesPicked,
              "title": titleController.text,
              "label": labelString,
              "sublabel": sublabelString,
              "description": descriptionText,
              "publishedAt": (_selectedDate == null)
                  ? DateTime.now().toString()
                  : _selectedDate.toString(),
            }
          : {
              "categories_id": categoriesPicked,
              "title": titleController.text,
              "label": labelString,
              "sublabel": sublabelString,
              "description": descriptionText,
              "publishedAt": (_selectedDate == null)
                  ? DateTime.now().toString()
                  : _selectedDate.toString(),
              "image": imageString,
            },
    );

    if (jsonDecode(response.body)["error"] == false) {
      notif("Behasil Update");
      setState(() {});
      Navigator.pop(context);
    } else {
      notif("Gagal Update");
      setState(() {});
    }
  }

  notif(String msg) async {
    Fluttertoast.showToast(
        msg: msg, webBgColor: "linear-gradient(to right, #A22855, #A22855)");
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: (contentLoad)
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: (Responsive.isDesktop(context))
                        ? MediaQuery.of(context).size.width / 5
                        : 20,
                    vertical: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tambah Artikel",
                          style: TextStyle(
                              color: fontColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (Responsive.isDesktop(context))
                            ? imageBody(context)
                            : SizedBox(),
                        (Responsive.isDesktop(context))
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // <-- Radius
                                      ),
                                      backgroundColor: primaryColor,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding * 1.5,
                                        vertical: defaultPadding,
                                      ),
                                    ),
                                    child: Text("Label Gambar"),
                                    onPressed: () {
                                      navigateLabelModal(context, labelString);
                                    },
                                  ),
                                  SizedBox(height: 5),
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // <-- Radius
                                      ),
                                      backgroundColor: primaryColor,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: defaultPadding * 1.5,
                                        vertical: defaultPadding,
                                      ),
                                    ),
                                    child: Text("Sub Label Gambar"),
                                    onPressed: () {
                                      navigateSubLabelModal(
                                          context, sublabelString);
                                    },
                                  ),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
                    (!Responsive.isDesktop(context))
                        ? imageBody(context)
                        : SizedBox(),
                    (!Responsive.isDesktop(context))
                        ? SizedBox(height: defaultPadding)
                        : SizedBox(),
                    (!Responsive.isDesktop(context))
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // <-- Radius
                                  ),
                                  backgroundColor: primaryColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: defaultPadding,
                                  ),
                                ),
                                child: Text("Label Gambar"),
                                onPressed: () {
                                  navigateLabelModal(context, labelString);
                                },
                              ),
                              SizedBox(height: defaultPadding),
                              ElevatedButton(
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // <-- Radius
                                  ),
                                  backgroundColor: primaryColor,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: defaultPadding,
                                  ),
                                ),
                                child: Text("Sub Label Gambar"),
                                onPressed: () {
                                  navigateSubLabelModal(
                                      context, sublabelString);
                                },
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(height: defaultPadding),
                    titleBody(context),
                    SizedBox(height: defaultPadding),
                    descriptionBody(context),
                    SizedBox(height: defaultPadding),
                    tableuBody(context),
                    SizedBox(height: defaultPadding),
                    iframeBody(context),
                    SizedBox(height: defaultPadding),
                    categoriesBody(context),
                    SizedBox(height: defaultPadding),
                    customDate(context),
                    SizedBox(height: defaultPadding),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                              backgroundColor: primaryColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            child: Text("Batal"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(width: 5),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                              backgroundColor: primaryColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding,
                              ),
                            ),
                            child: Text("Simpan"),
                            onPressed: () async {
                              postData();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  imageBody(BuildContext context) {
    double containerSize = (Responsive.isDesktop(context))
        ? MediaQuery.of(context).size.width / 3
        : MediaQuery.of(context).size.width / 1;
    return Container(
      width: containerSize,
      height: 160,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: fontColor)),
      child: Center(
        child: imageBytes == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      pickImage();
                    },
                    icon: Icon(Icons.upload, color: fontColor),
                    label: Text(
                      "Unggah Background",
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                  Text(
                    "Upload max: 2MB",
                    style: TextStyle(color: fontColor),
                  ),
                ],
              )
            : Stack(
                children: <Widget>[
                  Image.memory(imageBytes),
                  Positioned(
                    right: 5.0,
                    child: InkWell(
                      child: Icon(
                        Icons.remove_circle,
                        size: 30,
                        color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          imageBytes = null;
                          imageString = null;
                        });
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }

  titleBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Judul",
            style: TextStyle(color: fontColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: titleController,
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                fillColor: fontColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  categoriesBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kategori",
            style: TextStyle(color: fontColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DropdownButtonFormField(
              items: listCategories.map((item) {
                return DropdownMenuItem(
                  child: Text(item['title']),
                  value: item['id'].toString(),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  categoriesPicked = newVal;
                });
              },
              value: categoriesPicked,
              decoration: InputDecoration(
                fillColor: fontColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  tableuBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tableau",
                    style: TextStyle(color: fontColor, fontSize: 16),
                  ),
                  SizedBox(height: defaultPadding),
                  TextField(
                    controller: tableuController,
                    style: TextStyle(color: fontColor),
                    decoration: InputDecoration(
                      fillColor: fontColor,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: fontColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              )),
              SizedBox(width: defaultPadding),
              SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tinggi Tableau",
                      style: TextStyle(color: fontColor, fontSize: 16),
                    ),
                    SizedBox(height: defaultPadding),
                    TextField(
                      controller: tableuHeightController,
                      style: TextStyle(color: fontColor),
                      decoration: InputDecoration(
                        fillColor: fontColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fontColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
            style: TextButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical: defaultPadding,
              ),
            ),
            child: Text("Masukkan Tableau"),
            onPressed: () {
              // uploadData();
              setState(() {
                descriptionController.insertHtml('<iframe src=' +
                    tableuController.text +
                    '?:showVizHome=no&:embed=true" width="100%" height="' +
                    tableuHeightController.text +
                    '"></iframe>');
              });
            },
          ),
        ],
      ),
    );
  }

  iframeBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Embed",
            style: TextStyle(color: fontColor, fontSize: 16),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: iframeController,
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                fillColor: fontColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
            style: TextButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
              backgroundColor: primaryColor,
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical: defaultPadding,
              ),
            ),
            child: Text("Masukkan Embed"),
            onPressed: () {
              // uploadData();
              setState(() {
                descriptionController.insertHtml(iframeController.text);
              });
            },
          ),
        ],
      ),
    );
  }

  descriptionBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deskripsi",
            style: TextStyle(fontSize: 16, color: fontColor),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: fontColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: HtmlEditor(
              controller: descriptionController,
              htmlEditorOptions: HtmlEditorOptions(
                hint: 'Deskripsi',
                darkMode: false,
                initialText: "",
              ),
              htmlToolbarOptions: HtmlToolbarOptions(
                dropdownBackgroundColor: bgColor,
                dropdownBoxDecoration:
                    BoxDecoration(border: Border.all(color: primaryColor)),
                buttonBorderColor: fontColor,
                buttonColor: fontColor,
                textStyle: TextStyle(color: fontColor),
                defaultToolbarButtons: [
                  StyleButtons(),
                  FontSettingButtons(
                    fontName: false,
                    fontSizeUnit: false,
                  ),
                  ListButtons(
                    listStyles: false,
                  ),
                  FontButtons(
                    clearAll: false,
                    strikethrough: false,
                    superscript: false,
                    subscript: false,
                  ),
                  InsertButtons(
                    picture: false,
                    table: false,
                    audio: false,
                    hr: false,
                  ),
                ],
                toolbarPosition: ToolbarPosition.aboveEditor, //by default
                toolbarType: ToolbarType.nativeScrollable, //by default
              ),
              callbacks: Callbacks(
                onPaste: () async {
                  var descriptionText = await descriptionController.getText();
                  String removedDescriptionText =
                      descriptionText.replaceAll(RegExp('\\<p.*?\\>'), '<p>');
                  descriptionController.setText(removedDescriptionText);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  customDate(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal Terbit",
            style: TextStyle(color: fontColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              focusNode: AlwaysDisabledFocusNode(),
              onTap: () {
                _selectDate(context);
              },
              controller: dateController,
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                fillColor: fontColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: fontColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateLabelModal(BuildContext context, String label) async {
    var labelData = await Navigator.of(context).push(
      PageRouteBuilder(
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 300),
          opaque: false,
          pageBuilder: (_, __, ___) => ArticlesLabelModal(label: label),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          }),
    );
    setState(() {
      labelString = labelData;
    });
  }

  void navigateSubLabelModal(BuildContext context, String sublabel) async {
    var sublabelData = await Navigator.of(context).push(
      PageRouteBuilder(
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: Duration(milliseconds: 300),
          opaque: false,
          pageBuilder: (_, __, ___) =>
              ArticlesSubLabelModal(sublabel: sublabel),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          }),
    );
    setState(() {
      sublabelString = sublabelData;
    });
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dateController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateController.text.length,
            affinity: TextAffinity.upstream));
      print(_selectedDate);
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
