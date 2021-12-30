import 'package:badges/badges.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:mor_app/consts/my_icons.dart';
import 'package:mor_app/provider/cart_provider.dart';
import 'package:mor_app/provider/dark_theme_provider.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/screens/cart.dart';
import 'package:mor_app/screens/empty_wishlist.dart';
import 'package:mor_app/screens/wishlist.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  static const routeName = 'User-screen';
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  ScrollController _scrollController;
  var top = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final _darkTheme = Provider.of<DarkThemeProvider>(context);
    final wishlistItems = Provider.of<Products>(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                stretch: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.orange[400],
                            Colors.white,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      centerTitle: true,
                      title: Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 300),
                            opacity: top <= 110.0 ? 1.0 : 0,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: kToolbarHeight / 1.8,
                                  width: kToolbarHeight / 1.8,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  // 'top.toString()',
                                  'Guest',
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      background: Image(
                        image: NetworkImage(
                            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Bag')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 150),
                                    opaque: false,
                                    pageBuilder: (_, animation1, __) {
                                      return SlideTransition(
                                          position: Tween(
                                                  begin: Offset(1.0, 0.0),
                                                  end: Offset(0.0, 0.0))
                                              .animate(animation1),
                                          child: WishlistScreen());
                                    }));
                          },
                          leading: Badge(
                            animationType: BadgeAnimationType.scale,
                            animationDuration: Duration(milliseconds: 600),
                            position: BadgePosition.topEnd(top: 0, end: 0),
                            elevation: 10,
                            toAnimate: true,
                            shape: BadgeShape.circle,
                            badgeColor: Colors.red[100],
                            badgeContent: Text(
                                '${wishlistItems.getWishlist.length}',
                                style: TextStyle(color: Colors.white)),
                            child: IconButton(
                              icon: Icon(
                                Ionicons.md_heart,
                                color: Colors.red[900],
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(WishlistScreen.routeName);
                              },
                            ),
                          ),
                          title: Text(
                            'Wishlist',
                            style: TextStyle(color: Colors.red[900]),
                          ),
                          trailing: Icon(Icons.chevron_right_rounded),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 150),
                                    opaque: false,
                                    pageBuilder: (_, animation1, __) {
                                      return SlideTransition(
                                          position: Tween(
                                                  begin: Offset(1.0, 0.0),
                                                  end: Offset(0.0, 0.0))
                                              .animate(animation1),
                                          child: CartScreen());
                                    }));
                          },
                          leading: Badge(
                            animationType: BadgeAnimationType.slide,
                            position: BadgePosition.topEnd(top: 0, end: 0),
                            animationDuration: Duration(milliseconds: 600),
                            elevation: 10,
                            toAnimate: true,
                            shape: BadgeShape.circle,
                            badgeColor: Colors.purple[100],
                            badgeContent: Text(
                                '${cartProvider.getCartItems.length}',
                                style: TextStyle(color: Colors.white)),
                            child: IconButton(
                              icon: Icon(
                                MyAppIcons.cart,
                                color: ColorsConsts.cartColor,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(CartScreen.routeName);
                              },
                            ),
                          ),
                          title: Text(
                            'Cart',
                            style: TextStyle(color: Colors.purple),
                          ),
                          trailing: Icon(Icons.chevron_right_rounded),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Information')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('Email', 'Email sub', 0, context),
                    userListTile('Phone number', '4555', 1, context),
                    userListTile('Shipping address', '', 2, context),
                    userListTile('joined date', 'date', 3, context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle('User settings'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: _darkTheme.darkTheme,
                      leading: Icon(Ionicons.md_moon),
                      onChanged: (value) {
                        setState(() {
                          _darkTheme.darkTheme = value;
                        });
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.orange[400],
                      title: Text('Dark theme'),
                    ),
                    userListTile('Logout', '', 4, context),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              )
            ],
          ),
          _buildFab()
        ],
      ),
    );
  }

  Widget _buildFab() {
    //starting fab position
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.orange[400],
          splashColor: Colors.white,
          tooltip: 'Change image',
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.email_outlined,
    Icons.phone_android_outlined,
    Icons.local_shipping_outlined,
    Icons.watch_later_outlined,
    Icons.exit_to_app_rounded
  ];

  Widget userListTile(
      String title, String subTitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.purple,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(_userTileIcons[index]),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
