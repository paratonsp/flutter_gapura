// ignore_for_file: unused_import, must_be_immutable

import 'package:cross_file_image/cross_file_image.dart';
import 'package:gapura/controllers/categories_controller.dart';
import 'package:gapura/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gapura/screens/template/background_image_upload.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gapura/constants.dart';

import 'package:gapura/screens/components/my_fields.dart';
import 'package:gapura/screens/components/header.dart';
import 'package:gapura/screens/components/recent_files.dart';
import 'package:gapura/screens/components/storage_details.dart';

class ArticlesSubLabelModal extends StatefulWidget {
  @override
  State<ArticlesSubLabelModal> createState() => _ArticlesSubLabelModal();
}

class _ArticlesSubLabelModal extends State<ArticlesSubLabelModal> {
  HtmlEditorController subLabelController = HtmlEditorController();

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
                    "Sub Label Gambar",
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              subLabelBody(context),
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

  subLabelBody(BuildContext context) {
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
            "Sub Label",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 10),
          HtmlEditor(
            controller: subLabelController,
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
                OtherOptions(height: MediaQuery.of(context).size.height / 7),
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
}
