import 'package:flutter/material.dart';
import 'package:mor_app/models/cart.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartItems = {};

  Map<String, Cart> get getCartItems {
    return _cartItems;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addToCart(String prodId, String title, double price, String imgUrl) {
    if (_cartItems.containsKey(prodId)) {
      _cartItems.update(
          prodId,
          // ignore: non_constant_identifier_names
          (ExistingItem) => Cart(
              id: ExistingItem.id,
              imageUrl: ExistingItem.imageUrl,
              title: ExistingItem.title,
              price: ExistingItem.price,
              quantity: ExistingItem.quantity + 1));
    } else {
      _cartItems.putIfAbsent(
          prodId,
          () => Cart(
              id: DateTime.now().toString(),
              imageUrl: imgUrl,
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void reducItemInCart(
      String prodId, String title, double price, String imgUrl) {
    if (_cartItems.containsKey(prodId)) {
      _cartItems.update(
          prodId,
          // ignore: non_constant_identifier_names
          (ExistingItem) => Cart(
              id: ExistingItem.id,
              imageUrl: ExistingItem.imageUrl,
              title: ExistingItem.title,
              price: ExistingItem.price,
              quantity: ExistingItem.quantity - 1));
    }
    notifyListeners();
  }

  void deleteItem(String prodId) {
    _cartItems.remove(prodId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
