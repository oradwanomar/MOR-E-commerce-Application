import 'package:flutter/material.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:mor_app/provider/dark_theme_provider.dart';
import 'package:mor_app/screens/bottom_bar.dart';
import 'package:mor_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

class EmptyCartScreen extends StatelessWidget {
  static const routeName = 'Empty-cart-screen';

  @override
  Widget build(BuildContext context) {
    final darkThemeFont = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 100),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/1.png"), fit: BoxFit.fill)),
        ),
        Text(
          'Your Cart Is Empty',
          style: TextStyle(
              // ignore: deprecated_member_use
              color: Theme.of(context).textSelectionColor,
              fontSize: 36,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Looks Like You didn\'t \n add anything to your cart yet',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: darkThemeFont.darkTheme
                  ? Theme.of(context).disabledColor
                  : Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w100),
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
            color: Colors.orange[500],
            child: Text(
              'shop now'.toUpperCase(),
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
