// ignore_for_file: non_constant_identifier_names

class ArticlesModel {
  double id;
  double categories_id;
  String title;
  String label;
  String sublabel;
  String description;
  String image;
  String categories;

  ArticlesModel({
    this.id,
    this.categories_id,
    this.title,
    this.label,
    this.sublabel,
    this.description,
    this.image,
    this.categories,
  });

  ArticlesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categories_id = json['categories_id'];
    title = json['title'];
    label = json['label'];
    sublabel = json['sublabel'];
    description = json['description'];
    image = json['image'];
    categories = json['categories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categories_id'] = this.categories_id;
    data['title'] = this.title;
    data['label'] = this.label;
    data['sublabel'] = this.sublabel;
    data['description'] = this.description;
    data['image'] = this.image;
    data['categories'] = this.categories;

    return data;
  }
}
