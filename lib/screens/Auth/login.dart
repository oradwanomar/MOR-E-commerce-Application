import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:animator/animator.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mor_app/consts/colors.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _hidePassword = true;
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
        await _auth.signInWithEmailAndPassword(
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.white, Colors.grey[200]],
                    [Colors.teal[100], Colors.teal[600]],
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
              Container(
                margin: EdgeInsets.only(top: 100),
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  //  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.flaticon.com/icons/png/128/869/869636.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Animator<double>(
                builder: (context, state, child) {
                  return FractionalTranslation(
                    translation: Offset(state.value, 0),
                    child: child,
                  );
                },
                triggerOnInit: true,
                curve: Curves.easeIn,
                tween: Tween<double>(begin: -1.5, end: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
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
                                  style: Theme.of(context).textTheme.bodyText1,
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
                                  textInputAction: TextInputAction.done,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
                                  keyboardType: TextInputType.visiblePassword,
                                  style: Theme.of(context).textTheme.bodyText1,
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
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: _submitForm,
                      child: Text('Forget your Password?',
                          style: TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 2,
                                color: Color.fromRGBO(0, 0, 0, 0.25),
                                offset: Offset(0, 4),
                              )
                            ],
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          )),
                    ),
                    SizedBox(
                      height: 40,
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
                                    'SIGN IN',
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
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: new Container(
                              margin:
                                  const EdgeInsets.only(right: 15.0, left: 10),
                              child: Divider(
                                color: Colors.white,
                                thickness: 1.5,
                                height: 36,
                              )),
                        ),
                        Text(
                          "OR",
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
                              margin:
                                  const EdgeInsets.only(left: 15.0, right: 10),
                              child: Divider(
                                color: Colors.white,
                                thickness: 1.5,
                                height: 36,
                              )),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.logo_google,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2,
                                        color: Color.fromRGBO(0, 0, 0, 0.75),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //Spacer(),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                  blurRadius: 2,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                )
                              ],
                              fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.pushReplacement(
                            //     context,
                            //     PageRouteBuilder(
                            //         transitionDuration:
                            //             const Duration(milliseconds: 150),
                            //         opaque: false,
                            //         pageBuilder: (_, animation1, __) {
                            //           return SlideTransition(
                            //               position: Tween(
                            //                       begin: Offset(1.0, 0.0),
                            //                       end: Offset(0.0, 0.0))
                            //                   .animate(animation1),
                            //               child: SignUpScreen());
                            //         }));
                          },
                          child: Text(
                            'Create one!',
                            style: TextStyle(
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2,
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
