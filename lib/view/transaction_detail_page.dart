import 'package:flutter/material.dart';
import 'package:habari_pay_cs/models/transaction_response.dart';
import 'package:habari_pay_cs/utils/extension.dart';
import 'package:habari_pay_cs/utils/widgets/app_text.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key, required this.transaction});

  final TransactionDetail transaction;

  @override
  Widget build(BuildContext context) {
    final currency = transaction.currencyId;
    final amount = '${transaction.transactionAmount / 100}';
    final amountStr = '$currency${amount.moneyFormat}';
    final successful = transaction.status.toLowerCase() == 'success';
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          'Transaction Detail',
          size: 17,
          spacing: 1.1,
          weight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.wallet, size: 40),
            AppText(amountStr, size: 18, weight: FontWeight.bold),
            AppText(
              transaction.createdAt?.fullWordedDate() ?? '',
              size: 12,
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: AppText('Transaction Status:', size: 13, weight: FontWeight.w500)),
                if (successful) ...[
                  Icon(Icons.check_circle, size: 16, color: Colors.green)
                ] else ...[
                  Icon(Icons.cancel, size: 16, color: Colors.red)
                ],
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: AppText(transaction.status, size: 14),
                ),
              ],
            ),
            RowItem(title: 'Transaction Ref.', value: transaction.transRef),
            RowItem(title: 'Gateway Ref.', value: transaction.gatewayTransRef),
            RowItem(title: 'Transaction Type.', value: transaction.transactionType.toUpperCase()),
            RowItem(title: 'Merchant Name.', value: transaction.merchantName),
            RowItem(title: 'Merchant Email', value: transaction.merchantEmail),
            RowItem(title: 'Merchant Amount', value: '$currency${'${transaction.merchantAmount}'.moneyFormat}'),
            RowItem(title: 'Transaction Fee', value: '$currency${'${transaction.fee}'.moneyFormat}'),
          ],
        ),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Expanded(child: AppText('$title:', size: 13, weight: FontWeight.w500)),
          AppText(value, size: 14),
        ],
      ),
    );
  }
}
