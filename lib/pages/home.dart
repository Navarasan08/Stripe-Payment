import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stripe_example/pages/credit_card_lists.dart';
import 'package:stripe_example/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CreditCard _existingCard;
  bool _loading = false;

  showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1200),
    ));
  }

  _payWithNewCard() async{
    setState(() => _loading= true);
    StripeTransactionResponse response = await StripeService.payWithNewCard(amount: "1500", currency: "INR");
    setState(() => _loading= false);
    if(response.success) {
      if(response.success) {
        showSnackBar("Payment Success");
      }else {
        showSnackBar("Payment Failed");
      }
    }

  }

  _paymentWithExistingCard() async{
    _existingCard = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreditCardList()),
    );
    if(_existingCard != null) {
      setState(() => _loading= true);

      StripeTransactionResponse response = await StripeService.payViaExistingCard(amount: "1500", card: _existingCard, currency: "INR");

      setState(() => _loading= false);

      if(response.success) {
        showSnackBar("Payment Success");
      }else {
        showSnackBar("Payment Failed");
      }

    }else {
      showSnackBar("No Card Selected");
    }

  }

  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Payments".toUpperCase()),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.add_circle_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "Pay via new Card",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                ),
                onTap: _payWithNewCard,
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.credit_card,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text("Pay via Existing Card",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0)),
                onTap: _paymentWithExistingCard,
              ),
            ),

            SizedBox(height: 20.0),

            _loading ? Container(
              alignment: Alignment.center,
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(),
            ) : Container(height: 0.0, width: 0.0,),

          ],
        ),
      ),
    );
  }
}
