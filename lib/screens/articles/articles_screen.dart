import 'dart:convert';
import 'dart:js' as js;

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:gapura/constants.dart';
import 'package:gapura/controllers/articles_controller.dart';
import 'package:gapura/models/articles_model.dart';
import 'package:gapura/screens/articles/articles_add_modal.dart';
import 'package:gapura/screens/articles/articles_edit_modal.dart';
import 'package:gapura/screens/components/header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ArticlesScreen extends StatefulWidget {
  @override
  State<ArticlesScreen> createState() => _StateArticlesScreen();
}

class _StateArticlesScreen extends State<ArticlesScreen> {
  List<ArticlesModel> _listArticles;
  List _listCategories;
  String categoriesPicked;
  double page = 1;

  bool isLoading = true;
  bool isLoadingCategories = true;
  bool kosong = false;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _articlesList();
    getCategories();
  }

  _articlesList() async {
    await ListArticlesController.load(
            page, searchController.text, categoriesPicked)
        .then(
      (value) {
        if (value != null) {
          setState(() {
            _listArticles = value;
            isLoading = false;
            kosong = false;
          });
        } else {
          setState(() {
            isLoading = false;
            kosong = true;
          });
        }
      },
    );
  }

  getCategories() async {
    String url = dotenv.env['BASE_URL'] + "api/v1/categories";
    var uri = Uri.parse(url);

    var response = await http.get(uri);
    var decodeJson = json.decode(response.body)["data"];
    if (jsonDecode(response.body)["error"] == false) {
      setState(() {
        _listCategories = decodeJson;
        isLoadingCategories = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(titlePage: "Artikel"),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      subHeader(context),
                      (isLoading || isLoadingCategories)
                          ? Center(
                              child: LinearProgressIndicator(),
                            )
                          : table(context),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  subHeader(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton.icon(
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
              icon: Icon(Icons.add),
              label: Text("Tambah"),
              onPressed: () async {
                await Navigator.of(context)
                    .push(
                  PageRouteBuilder(
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: Duration(milliseconds: 300),
                    opaque: false,
                    pageBuilder: (_, __, ___) => ArticlesAddModal(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
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
                    },
                  ),
                )
                    .then((value) {
                  setState(() {
                    _articlesList();
                  });
                });
              },
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }

  table(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: fontColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
        color: greyColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "List Aset",
                style: TextStyle(fontSize: 16, color: fontColor),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 8,
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: fontColor),
                      onChanged: (value) {
                        page = 1;
                        _articlesList();
                      },
                      decoration: InputDecoration(
                        hintText: "Cari",
                        hintStyle: TextStyle(color: fontColor),
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
                  SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 8,
                    child: Theme(
                      data: ThemeData.dark().copyWith(
                        textTheme: GoogleFonts.signikaNegativeTextTheme(
                                Theme.of(context).textTheme)
                            .apply(bodyColor: fontColor),
                        canvasColor: primaryColor,
                      ),
                      child: DropdownButtonFormField(
                        items: _listCategories.map((item) {
                          return DropdownMenuItem(
                            child: Text(
                              item['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            categoriesPicked = newVal;
                            page = 1;
                            _articlesList();
                          });
                        },
                        value: categoriesPicked,
                        decoration: InputDecoration(
                          suffixIconColor: fontColor,
                          iconColor: fontColor,
                          hintText: "Semua Kategori",
                          hintStyle: TextStyle(color: fontColor),
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
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                      child: IconButton(
                    onPressed: () {
                      setState(() {
                        categoriesPicked = null;
                        _articlesList();
                      });
                    },
                    icon: const Icon(Icons.close, color: Colors.black),
                  ))
                ],
              ),
            ],
          ),
          Text(
            "List Aset",
            style: TextStyle(fontSize: 16, color: fontColor),
          ),
          (kosong)
              ? SizedBox(
                  width: double.infinity,
                  child: Center(child: Text("Data Kosong")))
              : SizedBox(
                  width: double.infinity,
                  child: DataTable2(
                    border: TableBorder(
                        horizontalInside:
                            BorderSide(color: fontColor, width: 1)),
                    bottomMargin: 10,
                    columnSpacing: defaultPadding,
                    minWidth: 600,
                    columns: [
                      DataColumn(
                        label: Text("Judul"),
                      ),
                      DataColumn(
                        label: Text("Kategori"),
                      ),
                      DataColumn(
                        label: Text("Slug"),
                      ),
                      DataColumn(
                        label: Text("Aksi"),
                      ),
                      DataColumn(
                        label: Text("Lihat"),
                      ),
                    ],
                    rows: List.generate(
                      _listArticles.length,
                      (index) =>
                          recentFileDataRow(_listArticles[index], context),
                    ),
                  ),
                ),
          SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (page != 1)
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              page = page - 1;
                              _articlesList();
                            });
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: fontColor,
                          ),
                        )
                      : SizedBox(),
                  Text(page.toString()),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        page = page + 1;
                        _articlesList();
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: fontColor,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  DataRow recentFileDataRow(ArticlesModel data, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(
          (data.title == null) ? "" : data.title,
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(
          (data.categories == null) ? "" : data.categories,
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(Text(
          (data.slug == null) ? "" : data.slug,
          overflow: TextOverflow.ellipsis,
        )),
        DataCell(
          Text("Ubah"),
          onTap: (() {
            navigateModalEdit(context, data.id.toString());
          }),
        ),
        DataCell(
          Text("Lihat"),
          onTap: (() {
            navigateNewTab(context, data.id.toString(),
                data.categories_id.toString(), data.slug);
          }),
        )
      ],
    );
  }

  navigateModalEdit(BuildContext context, String dataid) async {
    await Navigator.of(context)
        .push(
      PageRouteBuilder(
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 300),
        opaque: false,
        pageBuilder: (_, __, ___) => ArticlesEditModal(article_id: dataid),
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
        },
      ),
    )
        .then((value) {
      setState(() {
        _articlesList();
      });
    });
  }

  navigateNewTab(BuildContext context, String dataid, String datacategories,
      String dataslug) async {
    js.context.callMethod('open', [
      'https://gapuravirtual.surabaya.go.id/post/' +
          datacategories +
          '/' +
          dataslug +
          '/' +
          dataid
    ]);
  }
}
