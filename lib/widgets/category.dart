import 'package:flutter/material.dart';
import 'package:mor_app/screens/category_feeds.dart';
import 'package:mor_app/screens/feeds.dart';

class Categorywidget extends StatefulWidget {
  final int index;
  Categorywidget({this.index, Key key}) : super(key: key);

  @override
  _CategorywidgetState createState() => _CategorywidgetState();
}

class _CategorywidgetState extends State<Categorywidget> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Phones',
      'categoryImagesPath': 'assets/images/CatPhones.png'
    },
    {
      'categoryName': 'Clothes',
      'categoryImagesPath': 'assets/images/CatClothes.jpg'
    },
    {
      'categoryName': 'Labtops',
      'categoryImagesPath': 'assets/images/CatLaptops.png'
    },
    {
      'categoryName': 'Shoes',
      'categoryImagesPath': 'assets/images/CatShoes.jpg'
    },
    {
      'categoryName': 'Watches',
      'categoryImagesPath': 'assets/images/CatWatches.jpg'
    },
    {
      'categoryName': 'Furniture',
      'categoryImagesPath': 'assets/images/CatFurniture.jpg'
    },
    {
      'categoryName': 'Beauty&Health',
      'categoryImagesPath': 'assets/images/CatBeauty.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CategoryScreen.routeName,
                arguments: '${categories[widget.index]['categoryName']}');
            // print('${categories[widget.index]['categoryName']}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10)),
              image: DecorationImage(
                  image: AssetImage(
                    categories[widget.index]['categoryImagesPath'],
                  ),
                  fit: BoxFit.cover),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).backgroundColor,
            child: Text(categories[widget.index]['categoryName']),
          ),
          bottom: 2,
          left: 10,
          right: 10,
        )
      ],
    );
  }
}
