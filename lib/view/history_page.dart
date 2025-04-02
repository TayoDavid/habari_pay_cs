import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habari_pay_cs/bloc/transaction/transaction_bloc.dart';
import 'package:habari_pay_cs/utils/extension.dart';
import 'package:habari_pay_cs/utils/widgets/app_loader.dart';
import 'package:habari_pay_cs/utils/widgets/app_text.dart';
import 'package:habari_pay_cs/view/transaction_detail_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  static String routeName = 'history';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    final transBloc = context.read<TransactionBloc>();
    transBloc.add(FetchTransactionHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          'Transaction History',
          size: 17,
          spacing: 1.1,
          weight: FontWeight.w500,
        ),
      ),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is LoadingState) {
            Loader.show(context);
          } else {
            Loader.dismiss(context);
          }
        },
        builder: (context, state) {
          final transactions = state.stateProps.transactions;

          if (transactions.isEmpty) {
            return Center(
              child: AppText('No transactions found'),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final amount = '${transaction.transactionAmount / 100}';
              final amountStr = '${transaction.currencyId}${amount.moneyFormat}';
              return ListTile(
                title: AppText(transaction.transRef, size: 14, weight: FontWeight.w500),
                subtitle: AppText(transaction.createdAt?.formated() ?? '', size: 12),
                contentPadding: EdgeInsets.zero,
                trailing: FittedBox(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppText(amountStr, size: 14, weight: FontWeight.bold),
                          AppText(transaction.status, size: 14),
                        ],
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TransactionDetailPage(transaction: transaction),
                  ));
                },
              );
            },
            separatorBuilder: (context, index) => Divider(height: 1.5, thickness: 1),
            itemCount: transactions.length,
          );
        },
      ),
    );
  }
}
