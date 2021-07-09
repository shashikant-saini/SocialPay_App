import 'package:social_pay/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';
import 'package:social_pay/widgets.dart';
import 'package:gsheets/gsheets.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> with TickerProviderStateMixin {
  AnimationController controller;
  String widgetString, approved;
  bool visibilityOb = true;
  String em1 = '..';

  Animation animation;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  Future<UpiResponse> _transaction;
  UpiIndia _upiIndia = UpiIndia();
  int x = 0;
  static var gsheets, ss, sheet1;
  double amount;
  String name = '...', total, cafe, socialFund;

  List<UpiApp> apps;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    _upiIndia.getAllUpiApps().then((value) {
      setState(() {
        apps = value;
        for (int i = 0; i < apps.length; i++) {
          if (apps[i].name != 'Google Pay' &&
              apps[i].name != 'PhonePe' &&
              apps[i].name != 'Paytm') {
            apps.removeAt(i);
          }
        }
      });
    });
  }

  void getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    x = prefs.getInt('x');
    name = prefs.getString('user');
    em1 = name[0].toUpperCase();
    gsheets = GSheets(credentials);
    ss = await gsheets.spreadsheet(spreadsheetId);
    sheet1 = ss.worksheetByTitle("February");
    String app = await sheet1.values.value(column: 6, row: x);
    if (app != '1') {
      String sf = await sheet1.values.value(column: 2, row: x);
      String t = await sheet1.values.value(column: 4, row: x);
      String c = await sheet1.values.value(column: 3, row: x);
      double a = double.parse(t);
      setState(() {
        socialFund = sf;
        cafe = c;
        total = t;
        amount = a;
        approved = app;
      });
    } else {
      setState(() {
        approved = app;
        visibilityOb = false;
      });
    }
  }

  Widget putText() {
    setState(() {
      if (approved == '1') {
        widgetString = '''
        
Payment Dues Cleared 
        for this Month.
''';
      } else {
        widgetString = '''
              
Payment Due of Rs. $total
       Social Fund: $socialFund
          Cafeteria: $cafe 
                ''';
      }
    });
    if (approved == null) {
      return CircularProgressIndicator();
    } else {
      return Text(
        widgetString,
        style: kDrawerTS.copyWith(fontSize: 22.0),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(controller != null) {
      controller.dispose();
    }
  }

  Future<UpiResponse> initiateTransaction(String app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: 'poonamsaini1903@oksbi',
      receiverName: 'Poonam Saini',
      transactionRefId: 'PaymentForSocialFund',
      transactionNote: 'Payment for the month',
      amount: amount,
    );
  }

  Future refreshing() async {
    String app = await sheet1.values.value(column: 6, row: x);
    setState(() {
      getUserDetails();
      approved = app;
      if(approved == '1'){
        visibilityOb = false;
      }
      else{
        visibilityOb = true;
      }
    });
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps.length == 0)
      return Center(child: Text("No apps found to handle transaction."));
    else
      return Visibility(
        visible: visibilityOb,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: Wrap(
              children: apps.map<Widget>((UpiApp app) {
                return GestureDetector(
                  onTap: () {
                    _transaction = initiateTransaction(app.app);
                    setState(() {});
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 7,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Image.memory(
                              app.icon,
                              height: 55,
                              width: 55,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawerEdgeDragWidth: 0,
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  '$name',
                  style: kDrawerTS.copyWith(fontSize: 25.0),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: Center(
                    child: Text(
                      '$em1',
                      style: kDrawerTS.copyWith(
                          fontWeight: FontWeight.w800, fontSize: 40.0),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/p1.jpeg'),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    FlutterOpenWhatsapp.sendSingleMessage("917204289504", "");
                  },
                  child: drawerTile(
                    text: 'Contact Admin',
                    icon: MdiIcons.whatsapp,
                  )),
              GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('user');
                    prefs.remove('x');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'welcome', (Route<dynamic> route) => false);
                  },
                  child: drawerTile(
                    text: 'Log Out',
                    icon: Icons.power_settings_new,
                  )),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreshing,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, right: 20.0, left: 30.0, bottom: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      iconSize: 35.0,
                      icon: Icon(Icons.short_text),
                      onPressed: () {
                        _drawerKey.currentState.openDrawer();
                      },
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40.0,
                  height: 180.0,
                  child: Center(
                    child: putText(),
                  ),
                  decoration: kBoxDecor,
                ),
                payCash('Paid via Cash', visibilityOb,onPressed: () {
                  DialogHelper.exit(context);
                  sheet1.values.insertValue('Cash', column: 5, row: x);
                  sheet1.values.insertValue(0, column: 6, row: x);
                },),
                payUPI('Pay via UPI', visibilityOb,),
                displayUpiApps(),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: FutureBuilder(
                    future: _transaction,
                    builder: (BuildContext context,
                        AsyncSnapshot<UpiResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('An Unknown error has occured'));
                        }
                        UpiResponse _upiResponse;
                        _upiResponse = snapshot.data;
                        if (_upiResponse.error != null) {
                          String text = '';
                          switch (snapshot.data.error) {
                            case UpiError.APP_NOT_INSTALLED:
                              text = "Requested app not installed on device";
                              break;
                            case UpiError.INVALID_PARAMETERS:
                              text =
                                  "Requested app cannot handle the transaction";
                              break;
                            case UpiError.NULL_RESPONSE:
                              text =
                                  "requested app didn't returned any response";
                              break;
                            case UpiError.USER_CANCELLED:
                              text = "You cancelled the transaction";
                              break;
                          }
                          return Center(
                            child: Text(text),
                          );
                        }
                        String txnId = _upiResponse.transactionId;
                        //String resCode = _upiResponse.responseCode;
                        //String txnRef = _upiResponse.transactionRefId;
                        //String approvalRef = _upiResponse.approvalRefNo;
                        String status = _upiResponse.status;
                        if (UpiPaymentStatus.SUCCESS == status) {
                          sheet1.values.insertValue('UPI', column: 5, row: x);
                          sheet1.values.insertValue(1, column: 6, row: x);
                          controller = AnimationController(
                            duration: Duration(seconds: 7),
                            vsync: this,
                          );
                          animation = Tween(
                            begin: 5.0,
                            end: 0.0,
                          ).animate(controller);
                          controller.forward();
                          return FadeTransition(
                            opacity: animation,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'images/success.gif',
                                  height: 70.0,
                                  width: 70.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Payment Successful',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'ID: $txnId',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          controller = AnimationController(
                            duration: Duration(seconds: 7),
                            vsync: this,
                          );
                          animation = Tween(
                            begin: 5.0,
                            end: 0.0,
                          ).animate(controller);
                          controller.forward();
                          return FadeTransition(
                            opacity: animation,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'images/Error.gif',
                                  height: 70.0,
                                  width: 70.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Payment Failed!',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      } else
                        return Text(' ');
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
