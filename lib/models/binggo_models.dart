import 'package:flutter/material.dart';

class BinggoModels {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;

  const BinggoModels(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price})
      : super();

  factory BinggoModels.fromJSON(Map<String, dynamic> json) => BinggoModels(
        id: json['id_product'],
        title: json['product_name'],
        description: json['product_description'],
        imageUrl: json['product_image'],
        price: double.tryParse(json['product_price']) ?? 0,
      );
}
