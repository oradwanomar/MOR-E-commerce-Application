import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:animator/animator.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:mor_app/screens/main_screen.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/lSignUp-screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _hidePassword = true;
  File _pickedImage;
  bool isLoading = false;

  void _submitForm() async {
    // final progress = ProgressHUD.of(context);
    // progress.showWithText('Loading...');
    final formInputs = _formKey.currentState.value;
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState.save();
      try {
        await _auth.createUserWithEmailAndPassword(
            email: formInputs['Email'].toString().trim(),
            password: formInputs['Password'].toString().trim());
        print(formInputs);
      } catch (error) {
        // ignore: unnecessary_statements
        (error.message
                .toString()
                .contains('The error is The email address is badly formatted'))
            ? SpinKitThreeBounce()
            : showDialog(
                context: context,
                builder: (BuildContext context) {
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
                                  Flexible(
                                    child: Text("${error.message}"),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      RaisedButton(
                                        child: Text("Ok"),
                                        color: Colors.red,
                                        colorBrightness: Brightness.dark,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
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

        print('The error is ${error.message}');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  static const Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: RotatedBox(
                quarterTurns: 2,
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Colors.orange[900], Colors.grey[200]],
                      [Colors.orange[100], Colors.orange[500]],
                    ],
                    durations: [19440, 10800],
                    heightPercentages: [0.20, 0.26],
                    blur: MaskFilter.blur(BlurStyle.solid, 11),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 4,
                  size: Size(
                    double.infinity,
                    double.infinity,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Animator<double>(
                  builder: (context, state, child) {
                    return FractionalTranslation(
                      translation: Offset(state.value, 0),
                      child: child,
                    );
                  },
                  triggerOnInit: true,
                  curve: Curves.easeIn,
                  tween: Tween<double>(begin: -1, end: 0),
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 70),
                          child: CircleAvatar(
                            backgroundColor: Colors.orange[500],
                            radius: 60,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange[50],
                              radius: 57,
                              backgroundImage: (_pickedImage == null)
                                  ? null
                                  : FileImage(_pickedImage),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 140,
                          left: 100,
                          child: RawMaterialButton(
                            elevation: 3,
                            fillColor: Colors.orange[600],
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.add_a_photo,
                            ),
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      elevation: 2,
                                      title: Text(
                                        'Choose Option',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            ListTile(
                                              onTap: _pickImageCamera,
                                              leading: Icon(
                                                Ionicons.ios_camera,
                                                color: Colors.pinkAccent,
                                                size: 25,
                                              ),
                                              title: Text(
                                                'Camera',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: _pickImageGallery,
                                              leading: Icon(
                                                Ionicons.md_images,
                                                color: Colors.blue[800],
                                              ),
                                              title: Text(
                                                'Gallery',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: _remove,
                                              leading: Icon(
                                                Ionicons
                                                    .md_remove_circle_outline,
                                                color: Colors.red[900],
                                              ),
                                              title: Text(
                                                'Remove',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        )
                      ]),

                      FormBuilder(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FormBuilderTextField(
                                    name: 'Full Name',
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.minLength(
                                          context, 6),
                                      FormBuilderValidators.required(context),
                                    ]),
                                    keyboardType: TextInputType.name,
                                    cursorColor: Colors.black,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    textInputAction: TextInputAction.next,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: Colors.black54,
                                      ),
                                      fillColor: Colors.black,
                                      hintText: 'Enter your full name',
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      labelText: 'Full name',
                                      labelStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FormBuilderTextField(
                                    name: 'Email',
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.email(context),
                                      FormBuilderValidators.required(context),
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: Colors.black,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.alternate_email_outlined,
                                        color: Colors.black54,
                                      ),
                                      fillColor: Colors.black,
                                      hintText: 'Enter your email',
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      labelText: 'E-Mail',
                                      labelStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FormBuilderTextField(
                                    name: 'Password',
                                    cursorColor: Colors.black,
                                    textInputAction: TextInputAction.next,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.match(
                                          context, pattern,
                                          errorText:
                                              'Password should contain at least one digit. \n'
                                              'Password should contain at least 6 characters. \n')
                                    ]),
                                    keyboardType: TextInputType.visiblePassword,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    obscureText: _hidePassword,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Colors.black54,
                                      ),
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          (_hidePassword)
                                              ? Icons.remove_red_eye_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Colors.black54,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _hidePassword = !_hidePassword;
                                          });
                                        },
                                      ),
                                      fillColor: Colors.black,
                                      hintText: 'Enter your Password',
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FormBuilderTextField(
                                    name: 'Phone Number',
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    autocorrect: false,
                                    enableSuggestions: false,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.numeric(context),
                                      FormBuilderValidators.minLength(
                                          context, 6)
                                    ]),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                          Ionicons.md_phone_portrait,
                                          color: Colors.black54),
                                      fillColor: Colors.black,
                                      hintText: 'Enter your Phone Number',
                                      hintStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                      labelText: 'Phone Number',
                                      labelStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: _submitForm,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: (isLoading)
                                  ? SpinKitRotatingCircle(
                                      color: Colors.orange[300],
                                      size: 25,
                                    )
                                  : Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(children: <Widget>[
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(
                                    right: 15.0, left: 10),
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1.5,
                                  height: 36,
                                )),
                          ),
                          Text(
                            "Or Sign up with",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 15.0, right: 10),
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1.5,
                                  height: 36,
                                )),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlineButton(
                            onPressed: () {},
                            shape: StadiumBorder(),
                            highlightedBorderColor: Colors.orange.shade200,
                            borderSide:
                                BorderSide(width: 2, color: Colors.orange[700]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Ionicons.logo_googleplus,
                                  color: Colors.orange[700],
                                  size: 20,
                                ),
                                Text(
                                  ' Google',
                                  style: TextStyle(
                                    color: Colors.orange[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OutlineButton(
                            onPressed: () {},
                            shape: StadiumBorder(),
                            highlightedBorderColor: Colors.blue.shade200,
                            borderSide:
                                BorderSide(width: 2, color: Colors.blue[900]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Ionicons.logo_facebook,
                                  color: Colors.blue[900],
                                  size: 20,
                                ),
                                Text(
                                  ' Facebook',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //Spacer(),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
