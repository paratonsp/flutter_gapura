// ignore_for_file: non_constant_identifier_names

import 'package:gapura/models/articles_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ListArticlesController {
  static load(
    double page,
    String search,
    String categories_id,
  ) async {
    String url = dotenv.env['BASE_URL'] + "api/v1/article";

    Uri parseUrl = Uri.parse(url).replace(queryParameters: {
      'page': page.toString(),
      "search": search,
      "categories_id": categories_id,
      "sortBy": "id",
      "sort": "DESC",
      "admin": "true",
    });

    final response = await http.get(parseUrl);

    List<ArticlesModel> list = [];
    if (jsonDecode(response.body)["status"] == 200) {
      for (var data in jsonDecode(response.body)['data'] as List) {
        list.add(ArticlesModel.fromJson(data));
      }
      return list;
    } else {
      return null;
    }
  }
}

class AddArticlesController {
  static load(
    String title,
    String subtitle,
    String description,
    String background,
    String image,
  ) async {
    String url = dotenv.env['BASE_URL'] + "api/v1/article/add";

    Uri parseUrl = Uri.parse(
      url,
    );
    final response = await http.post(parseUrl, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "title": title,
      "subtitle": subtitle,
      "description": description,
      "background": background,
      "image": image,
    });

    return jsonDecode(response.body);
  }
}
