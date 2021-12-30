// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mor_app/consts/theme_data.dart';
import 'package:mor_app/inner_screens/brands_navigation_rail.dart';
import 'package:mor_app/inner_screens/upload_product_form.dart';
import 'package:mor_app/provider/cart_provider.dart';
import 'package:mor_app/provider/dark_theme_provider.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/screens/Auth/login.dart';
import 'package:mor_app/screens/Auth/sign_up.dart';
import 'package:mor_app/screens/bottom_bar.dart';
import 'package:mor_app/screens/cart.dart';
import 'package:mor_app/screens/category_feeds.dart';
import 'package:mor_app/screens/empty_cart.dart';
import 'package:mor_app/screens/empty_wishlist.dart';
import 'package:mor_app/screens/feeds.dart';
import 'package:mor_app/screens/home.dart';
import 'package:mor_app/screens/landing_page.dart';
import 'package:mor_app/screens/main_screen.dart';
import 'package:mor_app/screens/product_details.dart';
import 'package:mor_app/screens/splash_screen.dart';
import 'package:mor_app/screens/user_info.dart';
import 'package:mor_app/screens/search.dart';
import 'package:mor_app/screens/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:mor_app/models/dark_Theme_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.preferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(create: (_) => Products()),
              ChangeNotifierProvider(create: (_) => CartProvider())
            ],
            child: Consumer<DarkThemeProvider>(
              // ignore: non_constant_identifier_names
              builder: (context, ThemeData, child) {
                return MaterialApp(
                  title: 'Mor App',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: LandingPage(),
                  // SplashScreen(route: LandingPage.routeName),
                  routes: {
                    BrandsNavigationRailScreen.routeName: (ctx) =>
                        BrandsNavigationRailScreen(),
                    EmptyWishlitScreen.routeName: (ctx) => EmptyWishlitScreen(),
                    EmptyCartScreen.routeName: (ctx) => EmptyCartScreen(),
                    CartScreen.routeName: (ctx) => CartScreen(),
                    HomeScreen.routeName: (ctx) => HomeScreen(),
                    UserInfo.routeName: (ctx) => UserInfo(),
                    FeedsScreen.routeName: (ctx) => FeedsScreen(),
                    // ignore: equal_keys_in_map
                    WishlistScreen.routeName: (ctx) => WishlistScreen(),
                    CategoryScreen.routeName: (ctx) => CategoryScreen(),
                    ProductDetails.routeName: (ctx) => ProductDetails(),
                    LogInScreen.routeName: (ctx) => LogInScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    MainScreens.routeName: (ctx) => MainScreens(),
                    LandingPage.routeName: (ctx) => LandingPage(),
                  },
                );
              },
            ),
          );
        });
  }
}
