class Product {
  final String uuid;
  final String name;
  final String picture;
  final double price;
  final double duration;
  final String hintTitle;
  final String hintDescription;

  Product(
      {this.uuid,
      this.name,
      this.picture,
      this.price,
      this.duration,
      this.hintTitle,
      this.hintDescription});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
      price: json['price'] as double,
      duration: json['duration'] as double,
      hintTitle: json['hint']['title'] as String,
      hintDescription: json['hint']['description'] as String,
    );
  }
}
