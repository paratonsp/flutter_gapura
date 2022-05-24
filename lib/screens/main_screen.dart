// ignore_for_file: must_be_immutable

import 'package:gapura/constants.dart';
import 'package:gapura/controllers/MenuController.dart';
import 'package:gapura/responsive.dart';
import 'package:flutter/material.dart';
import 'package:gapura/screens/about/about_screen.dart';
import 'package:gapura/screens/about/aset_merk_dart.dart';
import 'package:gapura/screens/articles/articles_screen.dart';
import 'package:gapura/screens/categories/categories_screen.dart';
import 'package:gapura/screens/dashboard_screen.dart';
import 'package:gapura/screens/footer/footer_screen.dart';
import 'package:gapura/screens/home/landing_screen.dart';
import 'package:gapura/screens/home/widget_1_screen.dart';
import 'package:gapura/screens/home/widget_2_screen.dart';
import 'package:gapura/screens/home/widget_3_screen.dart';
import 'package:gapura/screens/template/template_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

enum Section {
  Dashboard,
  Landing,
  Widget1,
  Widget2,
  Widget3,
  About,
  BrandAssets,
  Categories,
  Articles,
  Footer,
  Template
}
var section;

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Widget switchBody;

    switch (section) {
      case Section.Dashboard:
        switchBody = DashboardScreen();
        break;

      case Section.Landing:
        switchBody = LandingScreen();
        break;

      case Section.Widget1:
        switchBody = Widget1Screen();
        break;

      case Section.Widget2:
        switchBody = Widget2Screen();
        break;

      case Section.Widget3:
        switchBody = Widget3Screen();
        break;

      case Section.About:
        switchBody = AboutScreen();
        break;

      case Section.BrandAssets:
        switchBody = AsetMerekScreen();
        break;

      case Section.Categories:
        switchBody = CategoriesScreen();
        break;

      case Section.Articles:
        switchBody = ArticlesScreen();
        break;

      case Section.Footer:
        switchBody = FooterScreen();
        break;

      case Section.Template:
        switchBody = TemplateScreen();
        break;
    }
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: sideMenu(context),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: sideMenu(context),
              ),
            Expanded(
              flex: 5,
              child: (switchBody != null) ? switchBody : DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget sideMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          ListTile(
            onTap: () {
              setState(() => section = Section.Dashboard);
            },
            leading: Icon(Icons.circle),
            title: Text(
              "Beranda",
              style: TextStyle(color: fontColor),
            ),
          ),
          ExpansionTile(
            textColor: primaryColor,
            collapsedTextColor: fontColor,
            iconColor: primaryColor,
            collapsedIconColor: fontColor,
            leading: Icon(Icons.circle),
            title: Text("Halaman Utama"),
            children: [
              ListTile(
                onTap: () {
                  setState(() => section = Section.Landing);
                },
                title: Text(
                  "Header",
                  style: TextStyle(color: fontColor),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() => section = Section.Widget1);
                },
                title: Text(
                  "Widget Edisi Terbaru",
                  style: TextStyle(color: fontColor),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() => section = Section.Widget2);
                },
                title: Text(
                  "Widget Baca Gapura Jadi Tahu",
                  style: TextStyle(color: fontColor),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() => section = Section.Widget3);
                },
                title: Text(
                  "Widget Edisi Lama",
                  style: TextStyle(color: fontColor),
                ),
              ),
            ],
          ),
          ExpansionTile(
            textColor: primaryColor,
            collapsedTextColor: fontColor,
            iconColor: primaryColor,
            collapsedIconColor: fontColor,
            leading: Icon(Icons.circle),
            title: Text("Halaman Tentang"),
            children: [
              ListTile(
                onTap: () {
                  setState(() => section = Section.About);
                },
                title: Text(
                  "Tentang",
                  style: TextStyle(color: fontColor),
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() => section = Section.BrandAssets);
                },
                title: Text(
                  "Aset Merek",
                  style: TextStyle(color: fontColor),
                ),
              ),
            ],
          ),
          ListTile(
            onTap: () {
              setState(() => section = Section.Categories);
            },
            leading: Icon(Icons.circle),
            title: Text(
              "Kategori",
              style: TextStyle(color: fontColor),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() => section = Section.Articles);
            },
            leading: Icon(Icons.circle),
            title: Text(
              "Artikel",
              style: TextStyle(color: fontColor),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() => section = Section.Footer);
            },
            leading: Icon(Icons.circle),
            title: Text(
              "Footer",
              style: TextStyle(color: fontColor),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.circle),
            title: Text(
              "Manajemen Pengguna",
              style: TextStyle(color: fontColor),
            ),
          ),
          ListTile(
            onTap: () {
              setState(() => section = Section.Template);
            },
            leading: Icon(Icons.circle),
            title: Text(
              "Template",
              style: TextStyle(color: fontColor),
            ),
          ),
        ],
      ),
    );
  }
}
