import 'package:flutter/material.dart';
import 'package:mor_app/inner_screens/brands_rail_widget.dart';
import 'package:mor_app/models/product.dart';
import 'package:mor_app/provider/products.dart';
import 'package:mor_app/widgets/feeds_products.dart';
import 'package:mor_app/widgets/popular_products.dart';
import 'package:provider/provider.dart';

class BrandsNavigationRailScreen extends StatefulWidget {
  BrandsNavigationRailScreen({Key key});
  static const routeName = '/brands_navigation_rail';

  @override
  _BrandsNavigationRailScreenState createState() =>
      _BrandsNavigationRailScreenState();
}

class _BrandsNavigationRailScreenState
    extends State<BrandsNavigationRailScreen> {
  // ignore: unused_field
  int _selectedIndex = 0;
  final padding = 8.0;
  String routeArgs;
  String brand;

  @override
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context).settings.arguments.toString();
    _selectedIndex = int.parse(routeArgs.substring(1, 2));
    print(routeArgs.toString());
    setState(() {
      if (_selectedIndex == 0) {
        setState(() {
          brand = 'Addidas';
        });
      }
      if (_selectedIndex == 1) {
        setState(() {
          brand = 'Apple';
        });
      }
      if (_selectedIndex == 2) {
        setState(() {
          brand = 'Dell';
        });
      }
      if (_selectedIndex == 3) {
        setState(() {
          brand = 'H&M';
        });
      }
      if (_selectedIndex == 4) {
        setState(() {
          brand = 'Nike';
        });
      }
      if (_selectedIndex == 5) {
        setState(() {
          brand = 'Samsung';
        });
      }
      if (_selectedIndex == 6) {
        setState(() {
          brand = 'Huawei';
        });
      }
      if (_selectedIndex == 7) {
        setState(() {
          brand = 'All';
        });
      }
    });

    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    minWidth: 55.0,
                    groupAlignment: 1,
                    selectedIndex: _selectedIndex,
                    elevation: 1,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                        if (_selectedIndex == 0) {
                          setState(() {
                            brand = 'Addidas';
                          });
                        }
                        if (_selectedIndex == 1) {
                          setState(() {
                            brand = 'Apple';
                          });
                        }
                        if (_selectedIndex == 2) {
                          setState(() {
                            brand = 'Dell';
                          });
                        }
                        if (_selectedIndex == 3) {
                          setState(() {
                            brand = 'H&M';
                          });
                        }
                        if (_selectedIndex == 4) {
                          setState(() {
                            brand = 'Nike';
                          });
                        }
                        if (_selectedIndex == 5) {
                          setState(() {
                            brand = 'Samsung';
                          });
                        }
                        if (_selectedIndex == 6) {
                          setState(() {
                            brand = 'Huawei';
                          });
                        }
                        if (_selectedIndex == 7) {
                          setState(() {
                            brand = 'All';
                          });
                        }
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    backgroundColor: Theme.of(context).bottomAppBarColor,
                    leading: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                              'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'),
                        ),
                        SizedBox(
                          height: 90,
                        ),
                      ],
                    ),
                    selectedLabelTextStyle: TextStyle(
                      color: Colors.orange[200],
                      fontSize: 20,
                      letterSpacing: 1,
                      //decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                    unselectedLabelTextStyle: TextStyle(
                        color: Theme.of(context).textSelectionColor,
                        fontSize: 15,
                        letterSpacing: 0.8),
                    destinations: [
                      buildRotatedTextRailDestination('Adidas', padding),
                      buildRotatedTextRailDestination('Apple', padding),
                      buildRotatedTextRailDestination('Dell', padding),
                      buildRotatedTextRailDestination('H&M', padding),
                      buildRotatedTextRailDestination('Nike', padding),
                      buildRotatedTextRailDestination('Samsoung', padding),
                      buildRotatedTextRailDestination('Huawei', padding),
                      buildRotatedTextRailDestination('All', padding),
                    ],
                  ),
                ),
              ),
            );
          }),
          ContentSpace(context, brand)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  final String brand;
  ContentSpace(BuildContext context, this.brand);
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    final _brandsList = productProvider.findByBrand(brand);
    List<Product> allproducts = productProvider.products;
    return Expanded(
        child: Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 20),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: (brand == 'All')
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ChangeNotifierProvider.value(
                      value: allproducts[index], child: BrandsNavigationRail());
                },
                itemCount: allproducts.length,
              )
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ChangeNotifierProvider.value(
                      value: _brandsList[index], child: BrandsNavigationRail());
                },
                itemCount: _brandsList.length,
              ),
      ),
    ));
  }
}
