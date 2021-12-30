import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/rendering.dart';
import 'package:mor_app/inner_screens/brands_navigation_rail.dart';
import 'package:mor_app/models/product.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/screens/feeds.dart';
import 'package:mor_app/widgets/backlayer.dart';
import 'package:mor_app/widgets/category.dart';
import 'package:mor_app/widgets/popular_products.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:like_button/like_button.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'Home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _carouselImages = [
    'assets/images/carousel1.png',
    'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/8587de106749917.5f973b252148d.jpg',
    'https://s3.envato.com/files/221883514/Preview/019%20Slider.jpg',
    'assets/images/carousel4.png',
    'https://res.cloudinary.com/djtpiagbk/image/upload/v1622331736/Canvas/White_Simple_We_Are_Open_Instagram_Post_aqgcur.png',
    'https://media.istockphoto.com/photos/online-shopping-and-payment-man-using-tablet-with-shopping-cart-icon-picture-id1206800961?k=20&m=1206800961&s=612x612&w=0&h=hcPoUKhWtzHXR3PIAHVgPVZDZaO7R8yZ1wNPkUSsgwU='
  ];

  List _brands = [
    'assets/images/adidas.jpeg',
    'assets/images/apple.jpg',
    'assets/images/dell.jpeg',
    'assets/images/HM.png',
    'assets/images/nike1.jpeg',
    'assets/images/samsung.jpeg',
    'assets/images/hhh.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context, listen: false);
    List<Product> popularProducts = productProvider.findPopular();
    return Scaffold(
        body: Center(
      child: BackdropScaffold(
          frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          headerHeight: MediaQuery.of(context).size.height * 0.25,
          appBar: BackdropAppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.orange[400],
                Colors.orange[100],
                Colors.white
              ])),
            ),
            title: const Text("Home"),
            leading: BackdropToggleButton(
              icon: AnimatedIcons.list_view,
            ),
            actions: <Widget>[
              IconButton(
                padding: EdgeInsets.all(10),
                icon: const CircleAvatar(
                  // ignore: deprecated_member_use
                  backgroundColor: Colors.white,
                  radius: 15,
                  child: const CircleAvatar(
                    radius: 13,
                    backgroundImage: const NetworkImage(
                        'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                  ),
                ),
                onPressed: () {},
                iconSize: 15,
              )
            ],
          ),
          backLayer: BackLayerMenu(),
          frontLayer: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 190.0,
                  width: double.infinity,
                  child: Carousel(
                    onImageTap: (index) {},
                    indicatorBgPadding: 5,
                    boxFit: BoxFit.fill,
                    dotBgColor: Colors.black.withOpacity(0.2),
                    animationCurve: Curves.fastOutSlowIn,
                    dotSize: 5.0,
                    dotColor: Colors.black,
                    animationDuration: Duration(milliseconds: 1000),
                    noRadiusForIndicator: true,
                    showIndicator: true,
                    images: [
                      Image.network(_carouselImages[2]),
                      ExactAssetImage(_carouselImages[0]),
                      Image.network(_carouselImages[1]),
                      Image.network(_carouselImages[4]),
                      ExactAssetImage(_carouselImages[3]),
                    ],
                  ),
                ),
                // FadeInImage.assetNetwork(
                //   placeholder: 'assets/images/c2.gif',
                //   fadeOutDuration: Duration(milliseconds: 100),
                //   image: _carouselImages[1],
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Categorywidget(
                        index: index,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Popular Brands',
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Spacer(),
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              BrandsNavigationRailScreen.routeName,
                              arguments: {7});
                        },
                        child: Text(
                          'View all >>',
                          style: TextStyle(
                              color: Colors.pinkAccent[100],
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 210,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Swiper(
                      // control: new SwiperControl(),
                      viewportFraction: 0.8,
                      scale: 0.9,
                      autoplay: true,
                      onTap: (index) {
                        Navigator.of(context).pushNamed(
                            BrandsNavigationRailScreen.routeName,
                            arguments: {index});
                      },
                      itemCount: _brands.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          child: Image.asset(
                            _brands[index],
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Popular Products',
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Spacer(),
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(FeedsScreen.routeName,
                              arguments: 'popular');
                        },
                        child: Text(
                          'View all >>',
                          style: TextStyle(
                              color: Colors.pinkAccent[100],
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                          value: popularProducts[index],
                          child: PopularProduct());
                    },
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
              ],
            ),
          )),
    ));
  }
}
