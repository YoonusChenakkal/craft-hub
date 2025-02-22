import 'package:flutter/material.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 129, 63, 42),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: Text('UPI/BHIM',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ),
        Container(
          color: const Color.fromARGB(255, 240, 235, 235),
          width: 500,
          height: 90,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(Icons.add),
            ),
            SizedBox(width: 10),
            Text('ADD NEW UPI ID'),
            Center(
              child: Row(
                children: [
                  Image.asset("assets/nogp11.png"),
                  Image.asset("assets/nobggpay (2).png"),
                ],
              ),
            ),
          ]),
        ),
        Container(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: Text(
            "CREDIT AND DEBIT CARDS",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        )),
        Container(
          color: const Color.fromARGB(255, 240, 235, 235),
          width: 600,
          height: 90,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(Icons.add),
            ),
            SizedBox(width: 10),
            Text('ADD NEW CARD'),
            Center(
              child: Row(
                children: [
                  Image.asset("assets/prre (1).png"),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
          ]),
        ),
        Container(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: Text(
            "CASH ON DELIVERY",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        )),
        Container(
          color: const Color.fromARGB(255, 240, 235, 235),
          width: 600,
          height: 90,
          child: Row(children: [
            SizedBox(width: 10),
            Image.asset("assets/image1/cash (1).png"),
            Center(
              child: Row(
                children: [
                  Text('Pay amount on delivery'),
                  SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
