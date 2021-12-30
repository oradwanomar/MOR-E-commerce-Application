import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mor_app/models/product.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/widgets/feeds_products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = 'category-screen';
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context, listen: false);
    final categoryName = ModalRoute.of(context).settings.arguments as String;
    print(categoryName);
    final productList = productProvider.findByCategory(categoryName);

    // List<Product> listProduct = productProvider.products;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
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
        children: List.generate(productList.length, (index) {
          return ChangeNotifierProvider.value(
              value: productList[index], child: FeedProducts());
        }),
      )),
    );
  }
}
