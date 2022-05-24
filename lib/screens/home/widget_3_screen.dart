import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';

import 'package:gapura/constants.dart';
import 'package:gapura/responsive.dart';
import 'package:gapura/screens/components/header.dart';
import 'package:image_picker/image_picker.dart';

class Widget3Screen extends StatefulWidget {
  @override
  State<Widget3Screen> createState() => _StateWidget3Screen();
}

class _StateWidget3Screen extends State<Widget3Screen> {
  XFile imagePicked;
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
  //     (imagePicked != null) ? imagePicked.name : "",
  //   ).then((value) {});
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(titlePage: "Widget Edisi Lama"),
            SizedBox(height: defaultPadding),
            imageBody(context),
            SizedBox(height: defaultPadding),
            titleBody(context),
            SizedBox(height: defaultPadding),
            subtitleBody(context),
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
                  "Unggah Background",
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

  subtitleBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sub Judul",
            style: TextStyle(color: secondaryColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: subtitleController,
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
}
