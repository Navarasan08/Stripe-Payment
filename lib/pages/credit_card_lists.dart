

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';

class CreditCardList extends StatefulWidget {
  @override
  _CreditCardListState createState() => _CreditCardListState();
}

class _CreditCardListState extends State<CreditCardList> {

  List<CreditCard> cards = [
    CreditCard(
      name: "Navarasan",
      number: "4242424242424242",
      expMonth: 3,
      expYear: 2021,
      cvc: '332',
    ),
    CreditCard(
      name: "Navarasan 1",
      number: "4000056655665556",
      expMonth: 4,
      expYear: 2025,
      cvc: '242',
    ),
    CreditCard(
      name: "Navarasan 2",
      number: "5555555555554444",
      expMonth: 6,
      expYear: 2022,
      cvc: '235',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Credit Cards"),),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300.0,
              child: ListView.builder(
                itemCount: 3,
               scrollDirection: Axis.horizontal,
               itemBuilder: (context, index) {
                  CreditCard card = cards[index];

                 return GestureDetector(
                   child: Container(
                     width: MediaQuery.of(context).size.width - 20.0,
                     padding: EdgeInsets.symmetric(horizontal: 15.0),
                     child: CreditCardWidget(
                       cardNumber: card.number,
                       expiryDate: "${card.expMonth}/${card.expYear}",
                       cardHolderName: card.name,
                       cvvCode: card.cvc,
                       showBackView: false,
                     ),
                   ),
                   onTap: () => Navigator.pop(context, card),
                 );
               },
              ),
            )
          ],
        ),
      ),
    );
  }
}
