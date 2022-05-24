import 'package:flutter/material.dart';

import 'package:gapura/constants.dart';
import 'package:gapura/screens/components/header.dart';

class FooterScreen extends StatefulWidget {
  @override
  State<FooterScreen> createState() => _StateFooterScreen();
}

class _StateFooterScreen extends State<FooterScreen> {
  TextEditingController copyrightController = TextEditingController();
  TextEditingController telponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController dinasController = TextEditingController();

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
            Header(titlePage: "Footer"),
            SizedBox(height: defaultPadding),
            copyrightBody(context),
            SizedBox(height: defaultPadding),
            telponBody(context),
            SizedBox(height: defaultPadding),
            alamatBody(context),
            SizedBox(height: defaultPadding),
            dinasBody(context),
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

  copyrightBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Copyright",
            style: TextStyle(color: secondaryColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: copyrightController,
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

  telponBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Telepon",
            style: TextStyle(color: secondaryColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: telponController,
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

  alamatBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alamat",
            style: TextStyle(color: secondaryColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: alamatController,
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

  dinasBody(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dinas",
            style: TextStyle(color: secondaryColor, fontSize: 16),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: dinasController,
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
