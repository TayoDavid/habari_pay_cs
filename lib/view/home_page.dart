import 'package:flutter/material.dart';
import 'package:habari_pay_cs/utils/widgets/app_text.dart';
import 'package:habari_pay_cs/view/history_page.dart';
import 'package:habari_pay_cs/view/initiate_payment_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => HistoryPage()));
              },
              child: AppText('View Transaction History'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => InitiatePaymentPage()));
              },
              child: AppText('Initiate New Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
