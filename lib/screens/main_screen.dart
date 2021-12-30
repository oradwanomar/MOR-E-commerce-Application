import 'package:mor_app/inner_screens/upload_product_form.dart';
import 'package:mor_app/screens/landing_page.dart';
import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class MainScreens extends StatelessWidget {
  static const routeName = '/mainScreen';
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
