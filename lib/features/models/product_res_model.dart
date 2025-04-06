class ProductResModel {
  final int id;
  final String title;
  final double price;
  final String desc;
  final String category;
  final String image;
  final Rating rating;

  ProductResModel({
    required this.id,
    required this.title,
    required this.price,
    required this.desc,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductResModel.fromJson(Map<String, dynamic> json) {
    return ProductResModel(
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      desc: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating(
        rate: double.parse(json['rating']['rate'].toString()),
        count: json['rating']['count'],
      ),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});
}
