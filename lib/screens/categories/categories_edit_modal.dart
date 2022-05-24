// ignore_for_file: unused_import, must_be_immutable

import 'package:cross_file_image/cross_file_image.dart';
import 'package:gapura/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gapura/screens/template/background_image_upload.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';

import 'package:gapura/screens/components/my_fields.dart';
import 'package:gapura/screens/components/header.dart';
import 'package:gapura/screens/components/recent_files.dart';
import 'package:gapura/screens/components/storage_details.dart';

class CategoriesEditModal extends StatefulWidget {
  @override
  State<CategoriesEditModal> createState() => _CategoriesEditModal();
}

class _CategoriesEditModal extends State<CategoriesEditModal> {
  XFile imagePicked;
  XFile imageBackgroundPicked;
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

  pickImageBackground() async {
    XFile selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageBackgroundPicked = selectedImage;
    });
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
                    "Ubah Kategori",
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              (Responsive.isDesktop(context))
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imageBody(context),
                        imageBackgroundBody(context),
                      ],
                    )
                  : Column(children: [
                      imageBody(context),
                      SizedBox(height: defaultPadding),
                      imageBackgroundBody(context),
                    ]),
              SizedBox(height: defaultPadding),
              titleBody(context),
              SizedBox(height: defaultPadding),
              subtitleBody(context),
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
                      child: Text("Hapus"),
                      onPressed: () {},
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
                      onPressed: () {},
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
        ? MediaQuery.of(context).size.width / 3.7
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
                  "Unggah Gambar",
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

  imageBackgroundBody(BuildContext context) {
    double containerSize = (Responsive.isDesktop(context))
        ? MediaQuery.of(context).size.width / 3.7
        : MediaQuery.of(context).size.width / 1;
    return Container(
      width: containerSize,
      height: 160,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: secondaryColor)),
      child: Center(
        child: imageBackgroundPicked == null
            ? TextButton.icon(
                onPressed: () {
                  pickImageBackground();
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
                      image: XFileImage(imageBackgroundPicked, scale: 1),
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
                          imageBackgroundPicked = null;
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

  descriptionBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deskripsi",
            style: TextStyle(color: secondaryColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: descriptionController,
              maxLines: 4,
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
