import 'package:flutter/material.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:mor_app/provider/dark_theme_provider.dart';
import 'package:mor_app/screens/bottom_bar.dart';
import 'package:mor_app/screens/home.dart';
import 'package:mor_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

class EmptyWishlitScreen extends StatelessWidget {
  static const routeName = 'wishlist-screen';
  @override
  Widget build(BuildContext context) {
    final darkThemeFont = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 150),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/wishlist.png"),
                  fit: BoxFit.fitWidth)),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Really? No Items!',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: darkThemeFont.darkTheme
                  ? Theme.of(context).disabledColor
                  : Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 45,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.06,
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, MainScreens.routeName);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //side: BorderSide(color: Theme.of(context).textSelectionColor),
            ),
            color: Colors.pink[600],
            child: Text(
              'add a wish'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w200
                  // fontWeight: FontWeight.w600),
                  ),
            ),
          ),
        )
      ],
    ));
  }
}
