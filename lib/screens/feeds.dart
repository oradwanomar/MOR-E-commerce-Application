import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:mor_app/consts/my_icons.dart';
import 'package:mor_app/models/cart.dart';
import 'package:mor_app/models/product.dart';
import 'package:mor_app/provider/cart_provider.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/screens/cart.dart';
import 'package:mor_app/screens/wishlist.dart';
import 'package:mor_app/widgets/feeds_products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = 'feeds-screen';
  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context).settings.arguments as String;
    final productProvider = Provider.of<Products>(context);
    final wishlistItems = Provider.of<Products>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    List<Product> listProduct = productProvider.products;
    if (popular == 'popular') {
      listProduct = productProvider.findPopular();
    }
    return Scaffold(
      appBar: AppBar(
          title: Text('Feeds',
              style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.normal)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            Stack(children: [
              IconButton(
                icon: Icon(
                  Ionicons.md_heart,
                  color: Colors.red[900],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(WishlistScreen.routeName);
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
      body:
          //      StaggeredGridView.countBuilder(
          //   crossAxisCount: 4,
          //   itemCount: 8,
          //   itemBuilder: (BuildContext context, int index) => FeedProducts(),
          //   staggeredTileBuilder: (int index) =>
          //       new StaggeredTile.count(2, index.isEven ? 2.9 : 3.2),
          //   mainAxisSpacing: 8.0,
          //   crossAxisSpacing: 6.0,
          // )
          Center(
              child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 240 / 420,
        children: List.generate(listProduct.length, (index) {
          return ChangeNotifierProvider.value(
              value: listProduct[index], child: FeedProducts());
        }),
      )),
    );
  }
}
