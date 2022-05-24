// ignore_for_file: unused_import, must_be_immutable

import 'package:cross_file_image/cross_file_image.dart';
import 'package:gapura/controllers/categories_controller.dart';
import 'package:gapura/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gapura/screens/articles/articles_label_modal.dart';
import 'package:gapura/screens/articles/articles_sublabel_modal.dart';
import 'package:gapura/screens/template/background_image_upload.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gapura/constants.dart';

import 'package:gapura/screens/components/my_fields.dart';
import 'package:gapura/screens/components/header.dart';
import 'package:gapura/screens/components/recent_files.dart';
import 'package:gapura/screens/components/storage_details.dart';

class ArticlesAddModal extends StatefulWidget {
  @override
  State<ArticlesAddModal> createState() => _ArticlesAddModal();
}

class _ArticlesAddModal extends State<ArticlesAddModal> {
  XFile imagePicked;
  TextEditingController titleController = TextEditingController();
  HtmlEditorController descriptionController = HtmlEditorController();

  String labelString = "";
  String sublabelString = "";

  @override
  void initState() {
    super.initState();
  }

  pickImage() async {
    XFile selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imagePicked = selectedImage;
    });
  }

  // uploadData() async {
  //   await AddCategoriesController.load(
  //     titleController.text,
  //     subtitleController.text,
  //     descriptionController.text,
  //     (imageBackgroundPicked != null) ? imageBackgroundPicked.name : "",
  //     (imagePicked != null) ? imagePicked.name : "",
  //   ).then((value) {});
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SingleChildScrollView(
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
                        color: secondaryColor,
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
                                backgroundColor: primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 1.5,
                                  vertical: defaultPadding,
                                ),
                              ),
                              child: Text("Sub Label Gambar"),
                              onPressed: () {
                                navigateSubLabelModal(context, sublabelString);
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
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding * 1.5,
                              vertical: defaultPadding,
                            ),
                          ),
                          child: Text("Sub Label Gambar"),
                          onPressed: () {
                            navigateSubLabelModal(context, sublabelString);
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: TextButton.styleFrom(
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
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding,
                        ),
                      ),
                      child: Text("Simpan"),
                      onPressed: () {
                        // uploadData();
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
          border: Border.all(color: secondaryColor)),
      child: Center(
        child: imagePicked == null
            ? TextButton.icon(
                onPressed: () {
                  pickImage();
                },
                icon: Icon(Icons.upload, color: secondaryColor),
                label: Text(
                  "Unggah Ilustrasi",
                  style: TextStyle(color: secondaryColor),
                ),
              )
            : Stack(
                children: <Widget>[
                  Image(
                      image: XFileImage(imagePicked, scale: 1),
                      fit: BoxFit.cover),
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
                          imagePicked = null;
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
            style: TextStyle(color: secondaryColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: titleController,
              style: TextStyle(color: secondaryColor),
              decoration: InputDecoration(
                  fillColor: secondaryColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: secondaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "..."),
            ),
          ),
        ],
      ),
    );
  }

  descriptionBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deskripsi",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 10),
          HtmlEditor(
            controller: descriptionController,
            htmlEditorOptions: HtmlEditorOptions(
              hint: '',
              darkMode: false,
            ),
            htmlToolbarOptions: HtmlToolbarOptions(
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
                  table: false,
                  audio: false,
                  hr: false,
                ),
                OtherButtons(
                  help: false,
                  copy: false,
                  paste: false,
                ),
              ],

              toolbarPosition: ToolbarPosition.aboveEditor, //by default
              toolbarType: ToolbarType.nativeScrollable, //by default
              onButtonPressed:
                  (ButtonType type, bool status, Function() updateStatus) {
                return true;
              },
              onDropdownChanged: (DropdownType type, dynamic changed,
                  Function(dynamic) updateSelectedItem) {
                return true;
              },
              mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                return true;
              },
              mediaUploadInterceptor:
                  (PlatformFile file, InsertFileType type) async {
                //filename
                return true;
              },
            ),
            otherOptions:
                OtherOptions(height: MediaQuery.of(context).size.height / 2),
            plugins: [
              SummernoteAtMention(
                  getSuggestionsMobile: (String value) {
                    var mentions = <String>['test1', 'test2', 'test3'];
                    return mentions
                        .where((element) => element.contains(value))
                        .toList();
                  },
                  mentionsWeb: ['test1', 'test2', 'test3'],
                  onSelect: (String value) {}),
            ],
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
          pageBuilder: (_, __, ___) => ArticlesSubLabelModal(),
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
      sublabel = sublabelData;
    });
  }
}
