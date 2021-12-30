import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:mor_app/provider/cart_provider.dart';
import 'package:mor_app/provider/dark_theme_provider.dart';
import 'package:mor_app/screens/empty_cart.dart';
import 'package:mor_app/widgets/cart_item.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CartScreen extends StatefulWidget {
  static const routeName = 'cart-screen';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final int price = 300;

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context);
    // ignore: unused_local_variable
    return (cartItems.getCartItems.isEmpty)
        ? EmptyCartScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              actions: [
                IconButton(
                  tooltip: 'Remove All',
                  icon: Icon(Ionicons.ios_trash),
                  color: Theme.of(context).textSelectionColor,
                  onPressed: () {
                    cartItems.clearCart();
                  },
                )
              ],
              title: Text(
                'Cart Items ' + ' ${(cartItems.getCartItems.length)}',
                style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 12),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartItems.getCartItems.length,
                      itemBuilder: (context, index) =>
                          ChangeNotifierProvider.value(
                              value:
                                  cartItems.getCartItems.values.toList()[index],
                              child: CartItem(
                                prodId:
                                    cartItems.getCartItems.keys.toList()[index],
                              ))),
                  SizedBox(
                    height: 32,
                  ),
                  Material(
                    color: Colors.black12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Checkout Price:",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "\$${cartItems.totalAmount.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            color: Colors.red,
                            elevation: 1.0,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Colors.teal, Colors.white])),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Checkout",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  )
                ],
              ),
            ),
          );
  }
}
