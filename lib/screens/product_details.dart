import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:ionicons/ionicons.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:mor_app/consts/my_icons.dart';
import 'package:mor_app/provider/cart_provider.dart';
import 'package:mor_app/provider/dark_theme_provider.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/screens/wishlist.dart';
import 'package:mor_app/widgets/feeds_products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'cart.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLiked = false;
  bool added = false;
  double _initialRating = 0.0;
  String _initialRatingWord = '';
  double _rating;
  String _ratingWord;
  GlobalKey previewContainer = new GlobalKey();
  void initState() {
    super.initState();
    _rating = _initialRating;
    _ratingWord = _initialRatingWord;
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productsData = Provider.of<Products>(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    print('productId $productId');
    final prodAttr = productsData.findById(productId);

    final productsList = productsData.products;
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistItems = Provider.of<Products>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            // foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
              prodAttr.imageUrl,
            ),
          ),
          Container(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 290),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.purple.shade200,
                            onTap: () {},
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.save,
                                size: 23,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.purple.shade200,
                            onTap: () {},
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.share,
                                size: 23,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //padding: const EdgeInsets.all(16.0),
                    color: Theme.of(context).backgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text(
                                  prodAttr.title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    // color: Theme.of(context).textSelectionColor,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'US \$ ${prodAttr.price}',
                                style: TextStyle(
                                    color: themeState.darkTheme
                                        ? Theme.of(context).disabledColor
                                        : ColorsConsts.subTitle,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21.0),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 3.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            prodAttr.description,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 21.0,
                              color: themeState.darkTheme
                                  ? Theme.of(context).disabledColor
                                  : ColorsConsts.subTitle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                            height: 1,
                          ),
                        ),
                        _details(
                            themeState.darkTheme, 'Brand: ', prodAttr.brand),
                        _details(themeState.darkTheme, 'Quantity: ',
                            '${prodAttr.quantity}'),
                        _details(themeState.darkTheme, 'Category: ',
                            prodAttr.productCategoryName),
                        _details(themeState.darkTheme, 'Popularity: ',
                            prodAttr.isPopular ? 'Popular' : 'Barely known'),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),

                        // const SizedBox(height: 15.0),
                        Container(
                          color: Theme.of(context).backgroundColor,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'No reviews yet',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).textSelectionColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 21.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'Be the first review!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                    color: themeState.darkTheme
                                        ? Theme.of(context).disabledColor
                                        : ColorsConsts.subTitle,
                                  ),
                                ),
                              ),
                              RatingBar.builder(
                                initialRating: 0,
                                itemCount: 5,
                                // ignore: missing_return
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.purple,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.blue,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                  if (_rating == 0.5) {
                                    setState(() {
                                      _ratingWord = 'Very Bad';
                                    });
                                  }
                                  if (_rating == 1) {
                                    setState(() {
                                      _ratingWord = 'Bad';
                                    });
                                  }
                                  if (_rating == 1.5) {
                                    setState(() {
                                      _ratingWord = 'Maybe Nice';
                                    });
                                  }
                                  if (_rating == 2) {
                                    setState(() {
                                      _ratingWord = 'Maybe Nice';
                                    });
                                  }
                                  if (_rating == 2.5) {
                                    setState(() {
                                      _ratingWord = 'Maybe Good/Okay';
                                    });
                                  }
                                  if (_rating == 3) {
                                    setState(() {
                                      _ratingWord = 'Good';
                                    });
                                  }
                                  if (_rating == 3.5) {
                                    setState(() {
                                      _ratingWord = 'Good/Nice';
                                    });
                                  }
                                  if (_rating == 4) {
                                    setState(() {
                                      _ratingWord = 'Very Good';
                                    });
                                  }
                                  if (_rating == 4.5) {
                                    setState(() {
                                      _ratingWord = 'Wonderful';
                                    });
                                  }
                                  if (_rating == 5) {
                                    setState(() {
                                      _ratingWord = 'Excellent';
                                    });
                                  }
                                },
                                updateOnDrag: true,
                                allowHalfRating: true,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Rating: $_rating',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '$_ratingWord',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 15.0),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.0),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text(
                      'Suggested products:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    width: double.infinity,
                    height: 340,
                    child: ListView.builder(
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ChangeNotifierProvider.value(
                            value: productsList[index], child: FeedProducts());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "DETAIL",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                actions: <Widget>[
                  Stack(children: [
                    IconButton(
                      icon: Icon(
                        Ionicons.md_heart,
                        color: Colors.red[900],
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(WishlistScreen.routeName);
                      },
                    ),
                    Badge(
                      animationType: BadgeAnimationType.scale,
                      animationDuration: Duration(milliseconds: 600),
                      elevation: 10,
                      toAnimate: true,
                      shape: BadgeShape.circle,
                      badgeColor: Colors.red[100],
                      badgeContent: Text('${wishlistItems.getWishlist.length}',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ]),
                  Stack(children: [
                    IconButton(
                      icon: Icon(
                        MyAppIcons.cart,
                        color: ColorsConsts.cartColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                    ),
                    Badge(
                      animationType: BadgeAnimationType.slide,
                      animationDuration: Duration(milliseconds: 600),
                      elevation: 10,
                      toAnimate: true,
                      shape: BadgeShape.circle,
                      badgeColor: Colors.purple[100],
                      badgeContent: Text('${cartProvider.getCartItems.length}',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ]),
                ]),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Colors.redAccent.shade400,
                      onPressed:
                          cartProvider.getCartItems.containsKey(productId)
                              ? () {}
                              : () {
                                  cartProvider.addToCart(
                                      productId,
                                      prodAttr.title,
                                      prodAttr.price,
                                      prodAttr.imageUrl);
                                  setState(() {
                                    added = true;
                                  });
                                },
                      child: (cartProvider.getCartItems.containsKey(productId))
                          ? Text('IN CART')
                          : Text(
                              'Add to Cart'.toUpperCase(),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 45,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Theme.of(context).backgroundColor,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Buy now'.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).textSelectionColor),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : ColorsConsts.subTitle,
                    height: 50,
                    child: InkWell(
                      splashColor: ColorsConsts.favColor,
                      onTap: (wishlistItems.getWishlist.containsKey(productId))
                          ? () {
                              wishlistItems.removeFromWishlist(productId);
                            }
                          : () {
                              wishlistItems.addToWishlist(
                                  productId,
                                  prodAttr.imageUrl,
                                  prodAttr.price,
                                  prodAttr.brand,
                                  prodAttr.title);
                              print('Added');
                            },
                      child: Center(
                        child:
                            (wishlistItems.getWishlist.containsKey(productId))
                                ? Icon(
                                    Ionicons.md_heart,
                                    color: Colors.red[900],
                                  )
                                : Icon(
                                    Ionicons.md_heart_empty,
                                    color: ColorsConsts.white,
                                  ),
                      ),
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }

  Widget _details(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: themeState
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
