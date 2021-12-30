import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:mor_app/models/product.dart';
import 'package:mor_app/provider/cart_provider.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/screens/product_details.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class PopularProduct extends StatefulWidget {
  @override
  _PopularProductState createState() => _PopularProductState();
}

class _PopularProductState extends State<PopularProduct> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    bool added = false;
    final cartProvider = Provider.of<CartProvider>(context);
    final productsData = Provider.of<Products>(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Product>(context, listen: false);
    final wishlistItems = Provider.of<Products>(context);

    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(10),
                    bottomRight: const Radius.circular(10))),
            width: 250,
            height: 400,
            child: Stack(children: [
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProductDetails.routeName,
                        arguments: product.id);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/c2.gif',
                          fadeOutDuration: Duration(milliseconds: 500),
                          image: product.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              product.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                icon: cartProvider.getCartItems
                                        .containsKey(product.id)
                                    ? Icon(
                                        Ionicons.checkmark_done,
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                      )
                                    : Icon(
                                        Ionicons.cart_outline,
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                      ),
                                onPressed: cartProvider.getCartItems
                                        .containsKey(product.id)
                                    ? () {}
                                    : () {
                                        cartProvider.addToCart(
                                            product.id,
                                            product.title,
                                            product.price,
                                            product.imageUrl);
                                        setState(() {
                                          added = true;
                                        });
                                        showTopSnackBar(
                                          context,
                                          CustomSnackBar.success(
                                            message:
                                                "Your Item has been added successfully ✌🏻",
                                          ),
                                        );
                                      })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: InkWell(
                      onTap: () {
                        wishlistItems.addToWishlist(
                            product.id,
                            product.imageUrl,
                            product.price,
                            product.brand,
                            product.title);
                      },
                      child: (wishlistItems.getWishlist.containsKey(product.id))
                          ? Icon(
                              Ionicons.heart,
                              color: Colors.red[900],
                            )
                          : Icon(
                              Ionicons.heart_outline,
                              color: Colors.red[900],
                            )),
                ),
                top: 3.5,
                right: 3.5,
              ),
              Positioned(
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${product.price}',
                      maxLines: 1,
                    ),
                  ),
                ),
                right: 5,
                top: 150,
              )
            ])));
  }
}
