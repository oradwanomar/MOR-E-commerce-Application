import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:mor_app/models/cart.dart';
import 'package:mor_app/models/product.dart';
import 'package:mor_app/provider/cart_provider.dart';
import 'package:mor_app/provider/dark_theme_provider.dart';
import 'package:mor_app/screens/product_details.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CartItem extends StatefulWidget {
  final String prodId;

  const CartItem({Key key, this.prodId}) : super(key: key);
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  _AlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final cartProvider = Provider.of<CartProvider>(context);
          return Center(
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(right: 16.0),
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75),
                        bottomLeft: Radius.circular(75),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2Finfo-icon.png?alt=media',
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Hey!",
                          ),
                          SizedBox(height: 10.0),
                          Flexible(
                            child: Text("Are you sure to delete this item?"),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Text("No"),
                                  color: Colors.red,
                                  colorBrightness: Brightness.dark,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: RaisedButton(
                                  child: Text("Yes"),
                                  color: Colors.green,
                                  colorBrightness: Brightness.dark,
                                  onPressed: () {
                                    cartProvider.deleteItem(
                                      widget.prodId,
                                    );
                                    Navigator.pop(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                ),
                              ),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartAttr = Provider.of<Cart>(context);
    final subtotal = cartAttr.price * cartAttr.quantity;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetails.routeName, arguments: widget.prodId);
      },
      child: RoundedContainer(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(0),
        margin: EdgeInsets.all(10),
        height: 130,
        child: Row(
          children: <Widget>[
            Container(
              width: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(cartAttr.imageUrl),
                fit: BoxFit.contain,
              )),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            cartAttr.title,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Container(
                          width: 50,
                          child: IconButton(
                            onPressed: () {
                              _AlertDialog(context);
                            },
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            iconSize: 20,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Price: "),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cartAttr.price}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Sub Total: "),
                        SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text('${subtotal.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.orange,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Ships Free",
                          style: TextStyle(color: Colors.orange),
                        ),
                        Spacer(),
                        Row(
                          children: <Widget>[
                            (cartAttr.quantity > 1)
                                ? InkWell(
                                    onTap: () {
                                      if (cartAttr.quantity > 1) {
                                        cartProvider.reducItemInCart(
                                            widget.prodId,
                                            cartAttr.title,
                                            cartAttr.price,
                                            cartAttr.imageUrl);
                                      }
                                    },
                                    splashColor: Colors.redAccent.shade200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.redAccent,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.red[100],
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: 4,
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${cartAttr.quantity}'),
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            InkWell(
                              onTap: () {
                                cartProvider.addToCart(
                                    widget.prodId,
                                    cartAttr.title,
                                    cartAttr.price,
                                    cartAttr.imageUrl);
                              },
                              splashColor: Colors.lightBlue,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key key,
    @required this.child,
    this.height,
    this.width,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.borderRadius,
    this.alignment,
    this.elevation,
  }) : super(key: key);
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadius borderRadius;
  final AlignmentGeometry alignment;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? const EdgeInsets.all(0),
      color: color,
      elevation: elevation ?? 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(20.0),
      ),
      child: Container(
        alignment: alignment,
        height: height,
        width: width,
        padding: padding,
        child: child,
      ),
    );
  }
}
