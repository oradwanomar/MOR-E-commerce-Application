import 'package:flutter/material.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/screens/empty_wishlist.dart';
import 'package:mor_app/widgets/feeds_products.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mor_app/widgets/wishlist_item.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = 'wishlist-screen';
  @override
  Widget build(BuildContext context) {
    final WishlistsItem = Provider.of<Products>(context);
    return (WishlistsItem.getWishlist.isEmpty)
        ? EmptyWishlitScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              actions: [
                IconButton(
                  tooltip: 'Remove All',
                  icon: Icon(Ionicons.trash),
                  color: Theme.of(context).textSelectionColor,
                  onPressed: () {},
                )
              ],
              title: Text(
                'Wishlists Items',
                style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                ),
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                    return ChangeNotifierProvider.value(
                      value: WishlistsItem.getWishlist.values.toList()[index],
                      child: WishlistItem(
                        prodId: WishlistsItem.getWishlist.keys.toList()[index],
                      ),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: WishlistsItem.getWishlist.length,
                )),
          );
  }
}
