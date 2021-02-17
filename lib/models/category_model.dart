
class Category {
  final String uuid;
  final String name;
  final String picture;
  final String description;
  final String parent;

  Category({this.uuid, this.name, this.picture, this.description, this.parent});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
      description: json['description'] as String,
      parent: json['parent'] as String,
    );
  }
}