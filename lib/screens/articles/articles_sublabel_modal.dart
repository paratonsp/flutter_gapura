// ignore_for_file: unused_import, must_be_immutable

import 'package:cross_file_image/cross_file_image.dart';
import 'package:gapura/controllers/categories_controller.dart';
import 'package:gapura/responsive.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gapura/constants.dart';

import 'package:gapura/screens/components/my_fields.dart';
import 'package:gapura/screens/components/header.dart';
import 'package:gapura/screens/components/recent_files.dart';
import 'package:gapura/screens/components/storage_details.dart';

class ArticlesSubLabelModal extends StatefulWidget {
  ArticlesSubLabelModal({
    this.sublabel,
  });
  String sublabel;
  @override
  State<ArticlesSubLabelModal> createState() => _ArticlesSubLabelModal();
}

class _ArticlesSubLabelModal extends State<ArticlesSubLabelModal> {
  HtmlEditorController subLabelController = HtmlEditorController();

  @override
  void initState() {
    super.initState();
  }

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
                        color: fontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              labelBody(context),
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
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding,
                        ),
                      ),
                      child: Text("Batal"),
                      onPressed: () async {
                        var text = await subLabelController.getText();
                        Navigator.pop(context, text);
                      },
                    ),
                    SizedBox(width: 5),
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
                      child: Text("Simpan"),
                      onPressed: () async {
                        var text = await subLabelController.getText();
                        Navigator.pop(context, text);
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

  labelBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sub Label",
            style: TextStyle(fontSize: 16, color: bgColor),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: fontColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: HtmlEditor(
              controller: subLabelController,
              htmlEditorOptions: HtmlEditorOptions(
                initialText: widget.sublabel,
                hint: 'Sub Label',
                darkMode: false,
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
            ),
          ),
        ],
      ),
    );
  }
}
