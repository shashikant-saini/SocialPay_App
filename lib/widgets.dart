import 'package:social_pay/constants.dart';
import 'package:flutter/material.dart';

class payUPI extends StatelessWidget {
  const payUPI(this.text, this.visibilityOb,{this.onPressed});
  final text;
  final visibilityOb;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibilityOb,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
            width: MediaQuery.of(context).size.width - 40.0,
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 13.0),
              child: Text(
                '$text',
                style:
                kDrawerTS.copyWith(fontSize: 18.0, letterSpacing: 1.5),
              ),
            ),
            decoration: kBoxDecor),
      ),
    );
  }
}

class payCash extends StatelessWidget {
  const payCash(this.text, this.visibilityOb,{this.onPressed});
  final text;
  final visibilityOb;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibilityOb,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
            width: MediaQuery.of(context).size.width - 40.0,
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$text',
                    style:
                    kDrawerTS.copyWith(fontSize: 18.0, letterSpacing: 1.5),
                  ),
                  OutlineButton(
                    splashColor: Colors.white,
                    onPressed: onPressed,
                    hoverColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 5.0,
                    borderSide: BorderSide(color: Colors.white),
                    child: Text(
                      'Pay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            decoration: kBoxDecor),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    this.onPressed,
    this.name,
  });

  final String name;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.white,
      onPressed: onPressed,
      hoverColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 5.0,
      borderSide: BorderSide(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          name,
          style: kDrawerTS.copyWith(fontSize: 20.0),
        ),
      ),
    );
  }
}

class dialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 5.0,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) =>
      Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/success.gif',
              height: 135.0,
              width: 140.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                'Your Payment will be Verified by Admin',
                style: kDrawerTS,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton(
              textColor: Colors.white,
              color: Colors.teal,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Text("OK", style: TextStyle(
                  fontSize: 20.0
                ),),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          ],
        ),
      );
}

class drawerTile extends StatelessWidget {
  const drawerTile({this.text, this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black45,
          fontSize: 20.0,
        ),
      ),
      leading: Icon(
        icon,
        size: 30.0,
      ),
    );
  }
}
