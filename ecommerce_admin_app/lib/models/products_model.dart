import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  String name, description, image, category, id;
  int old_price, new_price, maxQuantity;

  ProductsModel({
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.id,
    required this.old_price,
    required this.new_price,
    required this.maxQuantity
  });

  // convert json to object model
  factory ProductsModel.fromJson(Map<String, dynamic> json, String id) {
    return ProductsModel(
      name: json["name"] ?? "",
      description: json["desc"] ?? "",
      image: json["image"] ?? "",
      new_price: json["new_price"] ?? 0,
      old_price: json["old_price"] ?? 0,
      category: json["category"] ?? "",
      maxQuantity: json["quantity"] ?? 0,
      id: id ??  "",
    );
  }

  // convert List<QueryDocumentSnapshot> to List<ProductModel>
  static List<ProductsModel> fromJsonList(List<QueryDocumentSnapshot> list) {
    return list.map((e) => ProductsModel.fromJson(e.data() as Map<String, dynamic>, e.id)).toList();
  }
}