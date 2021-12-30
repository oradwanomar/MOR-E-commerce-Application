import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  Cart({this.id, this.title, this.quantity, this.price, this.imageUrl});
}
