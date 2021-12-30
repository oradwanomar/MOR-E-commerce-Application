import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:mor_app/models/product.dart';
import 'package:mor_app/provider/cart_provider.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/screens/product_details.dart';
import 'package:provider/provider.dart';

class FeedProducts extends StatefulWidget {
  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  @override
  Widget build(BuildContext context) {
    bool state = false;
    final productAttributes = Provider.of<Product>(context);
    final wishlistItems = Provider.of<Products>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetails.routeName,
                arguments: productAttributes.id);
          },
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      constraints: BoxConstraints(
                          minHeight: 100,
                          maxHeight: MediaQuery.of(context).size.height * 0.3),
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.contain,
                        placeholder: 'assets/images/c2.gif',
                        fadeOutDuration: Duration(milliseconds: 500),
                        image: productAttributes.imageUrl,
                      ),
                    ),
                  ),
                  Badge(
                    animationType: BadgeAnimationType.scale,
                    animationDuration: Duration(milliseconds: 600),
                    elevation: 10,
                    toAnimate: true,
                    shape: BadgeShape.square,
                    badgeColor: Colors.orange[400],
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(8)),
                    badgeContent:
                        Text('New', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Container(
                color: Theme.of(context).backgroundColor,
                padding: EdgeInsets.only(left: 5, top: 3),
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      productAttributes.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).textSelectionColor,
                          fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        '\$ ${productAttributes.price}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).textSelectionColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${productAttributes.quantity}' + ' Left',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                        child: Container(
                                          height: 420,
                                          width: 300,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 300,
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/images/c2.gif',
                                                  fadeOutDuration: Duration(
                                                      milliseconds: 500),
                                                  image: productAttributes
                                                      .imageUrl,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  DialogContent(
                                                    icon: (wishlistItems
                                                            .getWishlist
                                                            .containsKey(
                                                                productAttributes
                                                                    .id))
                                                        ? Ionicons.heart
                                                        : Ionicons
                                                            .heart_outline,
                                                    color: Colors.red[900],
                                                    func: (wishlistItems
                                                            .getWishlist
                                                            .containsKey(
                                                                productAttributes
                                                                    .id))
                                                        ? () {
                                                            wishlistItems
                                                                .removeFromWishlist(
                                                                    productAttributes
                                                                        .id);
                                                          }
                                                        : () {
                                                            wishlistItems.addToWishlist(
                                                                productAttributes
                                                                    .id,
                                                                productAttributes
                                                                    .imageUrl,
                                                                productAttributes
                                                                    .price,
                                                                productAttributes
                                                                    .brand,
                                                                productAttributes
                                                                    .title);
                                                            setState(() {
                                                              state = true;
                                                            });
                                                          },
                                                  ),
                                                  DialogContent(
                                                    icon: Ionicons.eye,
                                                    color: Colors.black,
                                                    func: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              ProductDetails
                                                                  .routeName,
                                                              arguments:
                                                                  productAttributes
                                                                      .id);
                                                    },
                                                  ),
                                                  DialogContent(
                                                    icon: (cartProvider
                                                            .getCartItems
                                                            .containsKey(
                                                                productAttributes
                                                                    .id))
                                                        ? Ionicons.checkmark
                                                        : Ionicons.cart,
                                                    color: Colors.purple,
                                                    func: () {
                                                      cartProvider.addToCart(
                                                          productAttributes.id,
                                                          productAttributes
                                                              .title,
                                                          productAttributes
                                                              .price,
                                                          productAttributes
                                                              .imageUrl);
                                                    },
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ));
                                  });
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogContent extends StatelessWidget {
  final IconData icon;
  final Function func;
  final Color color;
  const DialogContent({this.icon, this.func, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: func,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: ClipOval(
              // inkwell color
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    icon,
                    color: color,
                    size: 25,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
