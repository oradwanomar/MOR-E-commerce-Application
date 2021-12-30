import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mor_app/models/product.dart';
import 'package:mor_app/screens/cart.dart';
import 'package:mor_app/screens/product_details.dart';
import 'package:provider/provider.dart';

class BrandsNavigationRail extends StatefulWidget {
  @override
  _BrandsNavigationRailState createState() => _BrandsNavigationRailState();
}

class _BrandsNavigationRailState extends State<BrandsNavigationRail> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final productAttributes = Provider.of<Product>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetails.routeName,
          arguments: productAttributes.id,
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        margin: EdgeInsets.only(right: 20.0, bottom: 5, top: 18),
        constraints: BoxConstraints(
            minHeight: 150, minWidth: double.infinity, maxHeight: 180),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 170,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/c2.gif',
                  fadeOutDuration: Duration(milliseconds: 500),
                  image: productAttributes.imageUrl,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // image: DecorationImage(
                  //     image: NetworkImage(
                  //       'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/white-tee-1623337322.jpg?crop=0.502xw:1.00xh;0.250xw,0&resize=640:*',
                  //     ),
                  //     fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 2.0)
                  ],
                ),
              ),
            ),
            Stack(children: [
              FittedBox(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 10.0)
                      ]),
                  width: 160,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        productAttributes.title,
                        maxLines: 4,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).textSelectionColor),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      FittedBox(
                        child: Text('${productAttributes.price}',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.orange[200],
                              fontSize: 30.0,
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(productAttributes.productCategoryName,
                          style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                      Padding(
                        padding: const EdgeInsets.only(left: 95),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(15),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: LikeButton(
                    // animationDuration: Duration(milliseconds: 1000),

                    padding: EdgeInsets.only(left: 2.5, top: 1),
                    size: 22,
                    isLiked: isLiked,
                  ),
                ),
                top: 3.5,
                right: 0,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
