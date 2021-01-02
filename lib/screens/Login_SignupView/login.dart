import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:foodtruck/Services/Network.dart';
import 'package:foodtruck/screens/Login_SignupView/SIGNUP.dart';
import 'package:foodtruck/screens/VendorView/MAp_vendor.dart';
import 'package:foodtruck/Services/admob.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  var email;
  var password;
  final form_key = GlobalKey<FormState>();
  final form_key1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Container(
              color: Colors.white,
              height: 105,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 55,
                    color: Colors.white,
                    child: TabBar(
                      tabs: <Widget>[
                        Tab(
                          icon: Icon(
                            Icons.person_pin,
                            color: Colors.blue.shade400,
                          ),
                          child: Text(
                            'Login as User',
                            style: TextStyle(
                              color: Colors.blue.shade400,
                            ),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.fastfood,
                            color: Colors.blue.shade400,
                          ),
                          child: Text(
                            'Login as Vendor',
                            style: TextStyle(
                              color: Colors.blue.shade400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      color: Colors.white,
                      child: AdmobBanner(
                        adUnitId:
                            Provider.of<AdmobService>(context, listen: false)
                                .getBannerAdUnitId(),
                        adSize: AdmobBannerSize.BANNER,
                        listener:
                            (AdmobAdEvent event, Map<String, dynamic> args) {},
                      ))
                ],
              ),
            )),
        appBar: AppBar(
          actions: <Widget>[
            Image.asset(
              'assets/images/truckIcon.png',
              width: 100,
            ),
            SizedBox(
              width: 8,
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'LOGIN',
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
        backgroundColor: const Color(0xffffffff),
        body: TabBarView(
          children: [
            UserLogin(email, password, context, form_key1),
            VendorLogin(email, password, context, form_key)
          ],
        ),
      ),
    );
  }
}

Widget UserLogin(email, password, context, form_key) {
  return Form(
    key: form_key,
    child: SingleChildScrollView(
      child: Flexible(
        flex: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 50, bottom: 20),
              child: FractionallySizedBox(
                widthFactor: 0.85,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email Required';
                    } else {
                      email = value;
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        color: Colors.blue),
                    suffixIcon: Icon(Icons.email),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 50, bottom: 20),
              child: FractionallySizedBox(
                widthFactor: 0.85,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password Required';
                    } else {
                      password = value;
                      return null;
                    }
                  },

                  /// t button style
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.0,
                        color: Colors.blue),
                    suffixIcon: Icon(Icons.vpn_key),
                  ),

                  ///
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Consumer<WebServices>(
              builder: (context, webservices_consumer, child) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: webservices_consumer.login_state == false
                      ? RaisedButton(
                          onPressed: () {
                            if (form_key.currentState.validate()) {
                              webservices_consumer.Login_SetState();
                              webservices_consumer.Login_UserApi(
                                      email: email,
                                      password: password,
                                      context: context)
                                  .then((value) => webservices_consumer
                                      .get_current_user_location()
                                      .then((value) => Timer.periodic(
                                              Duration(seconds: 5), (timer) {
                                            webservices_consumer
                                                .Update_User_Location(
                                              id: value[0].id,
                                              context: context,
                                            );
                                          })));
                            }
                          },
                          color: Color(0xFF67b9fb),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff67b9fb),
                                    Color(0xff8acbff)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 150.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                // style: TextStyle(color: Colors.white),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        )
                      : CircularProgressIndicator()),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width / 7, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Need an account?',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 11,
                        color: Colors.blue,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SIGNUP();
                        }));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(Icons.person_add),
                          Text(
                            'Sign up!',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}

Widget VendorLogin(email, password, context, form_key) {
  return Form(
      key: form_key,
      child: SingleChildScrollView(
          child: Flexible(
              flex: 20,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: 20),
                      child: FractionallySizedBox(
                        // width: 300,
                        widthFactor: 0.85,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Username Required';
                            } else {
                              email = value;
                              return null;
                            }
                          },

                          /// t buttonstyle
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                color: Colors.blue),
                            suffixIcon: Icon(Icons.email),
                          ),

                          ///
                          ///
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: 20),
                      child: FractionallySizedBox(
                        // width: 300,
                        widthFactor: 0.85,
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password Required';
                            } else {
                              password = value;
                              return null;
                            }
                          },

                          /// t button style
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                color: Colors.blue),
                            suffixIcon: Icon(Icons.vpn_key),
                          ),

                          ///
                          ///
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Consumer<WebServices>(
                      builder: (context, webservices_consumer, child) =>
                          Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            webservices_consumer.login_state == false
                                ? RaisedButton(
                                    onPressed: () {
                                      if (form_key.currentState.validate()) {
                                        webservices_consumer.Login_SetState();
                                        webservices_consumer.Login_VendorApi(
                                                email: email,
                                                password: password,
                                                context: context)
                                            .then((value) => webservices_consumer
                                                .get_current_vendor_location()
                                                .then((value) => Timer.periodic(
                                                        Duration(minutes: 10),
                                                        (timer) {
                                                      webservices_consumer
                                                          .Update_Vendor_Location(
                                                        id: value[0].id,
                                                        context: context,
                                                      );
                                                    })));
                                        ;
                                      }
                                    },
                                    color: Color(0xFF67b9fb),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff67b9fb),
                                              Color(0xff8acbff)
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: 150.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Login",
                                          textAlign: TextAlign.center,
                                          // style: TextStyle(color: Colors.white),
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 7,
                            bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Need an account?',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 11,
                                color: Colors.blue,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SIGNUP();
                                }));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(Icons.vpn_key),
                                  Text(
                                    'Sign up!',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 14,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ]))));
}
