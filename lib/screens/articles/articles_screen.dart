import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:gapura/constants.dart';
import 'package:gapura/controllers/articles_controller.dart';
import 'package:gapura/models/articles_model.dart';
import 'package:gapura/models/categories_model.dart';
import 'package:gapura/screens/articles/articles_add_modal.dart';
import 'package:gapura/screens/articles/articles_edit_modal.dart';
import 'package:gapura/screens/components/header.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  State<ArticlesScreen> createState() => _StateArticlesScreen();
}

class _StateArticlesScreen extends State<ArticlesScreen> {
  List<ArticlesModel> _listArticles;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    articlesList();
  }

  articlesList() async {
    await ListArticlesController.load().then((value) {
      setState(() {
        _listArticles = value;
        isLoading = false;
      });
    });
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
                      // SizedBox(height: defaultPadding),
                      (isLoading)
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical: defaultPadding,
                ),
              ),
              icon: Icon(Icons.add),
              label: Text("Tambah"),
              onPressed: () {
                Navigator.of(context).push(
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
                      }),
                );
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
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "List Kategori",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
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
                  label: Text("Aksi"),
                ),
              ],
              rows: List.generate(
                _listArticles.length,
                (index) => recentFileDataRow(_listArticles[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(ArticlesModel data, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(Text((data.title == null) ? "" : data.title)),
      DataCell(Text((data.categories == null) ? "" : data.categories)),
      DataCell(
        Text("Ubah"),
        onTap: (() {
          Navigator.of(context).push(
            PageRouteBuilder(
                barrierDismissible: true,
                barrierColor: Colors.black.withOpacity(0.5),
                transitionDuration: Duration(milliseconds: 300),
                opaque: false,
                pageBuilder: (_, __, ___) => ArticlesEditModal(),
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
                }),
          );
        }),
      )
    ],
  );
}
