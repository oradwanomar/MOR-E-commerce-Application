import 'package:flutter/material.dart';
import 'package:mor_app/models/product.dart';
import 'package:provider/provider.dart';

class WishlistItem extends StatefulWidget {
  final String prodId;

  const WishlistItem({this.prodId});
  @override
  _WishlistItemState createState() => _WishlistItemState();
}

class _WishlistItemState extends State<WishlistItem> {
  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<Product>(context);
    return Dismissible(
      background: Icon(Icons.delete),
      key: ValueKey('key'),
      child: InkWell(
        key: ValueKey('key'),
        onTap: () {},
        child: RoundedContainer(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.all(0),
          margin: EdgeInsets.all(10),
          height: 130,
          child: Row(
            children: <Widget>[
              Container(
                width: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(prod.imageUrl),
                  fit: BoxFit.contain,
                )),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: Text(
                          prod.title,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "\$${prod.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.orange),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(prod.brand,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.grey))
                    ],
                  ),
                ),
              ),
            ],
          ),
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
