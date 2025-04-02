import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habari_pay_cs/bloc/transaction/transaction_bloc.dart';
import 'package:habari_pay_cs/models/initiate_request.dart';
import 'package:habari_pay_cs/models/transaction_response.dart';
import 'package:habari_pay_cs/utils/extension.dart';
import 'package:habari_pay_cs/utils/money_input_formater.dart';
import 'package:habari_pay_cs/utils/validator.dart';
import 'package:habari_pay_cs/utils/widgets/app_loader.dart';
import 'package:habari_pay_cs/utils/widgets/app_text.dart';
import 'package:habari_pay_cs/utils/widgets/checkout_view.dart';
import 'package:habari_pay_cs/utils/widgets/text_field.dart';
import 'package:habari_pay_cs/view/history_page.dart';

class InitiatePaymentPage extends StatefulWidget {
  const InitiatePaymentPage({super.key});

  static String routeName = 'initiate';

  @override
  State<InitiatePaymentPage> createState() => _InitiatePaymentPageState();
}

class _InitiatePaymentPageState extends State<InitiatePaymentPage> {
  final amountController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  late final transBloc = context.read<TransactionBloc>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is LoadingState) {
          Loader.show(context);
        } else {
          Loader.dismiss(context);
        }

        switch (state) {
          case InitiatePaymentSuccessful():
            showWebviewModalBottomSheet();
            break;
          case FetchTransByRefSuccessful():
            updateTransactionHistory(state.newProps.lastTransaction);
            break;
          case FailedState():
            showSnackBarWith(state.errMsg);
            break;
          case HistoryUpdateSuccessful():
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HistoryPage()));
            break;
          default:
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextField(
                  hint: '0.0',
                  controller: amountController,
                  inputType: TextInputType.numberWithOptions(decimal: true),
                  inputAction: TextInputAction.next,
                  validator: Validator.isValidAmount,
                  formatters: [MoneyInputFormatter()],
                ),
                AppTextField(
                  hint: 'Enter email address',
                  inputType: TextInputType.emailAddress,
                  controller: emailController,
                  inputAction: TextInputAction.next,
                  validator: Validator.isValidEmail,
                ),
                AppTextField(
                  hint: 'Full name',
                  controller: nameController,
                  inputAction: TextInputAction.done,
                  validator: Validator.isValidInput,
                  margin: EdgeInsets.only(bottom: 24),
                ),
                FilledButton(
                  onPressed: onProceedButtonTapped,
                  style: FilledButton.styleFrom(
                    minimumSize: Size(size.width, 48),
                  ),
                  child: AppText('Proceed'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showWebviewModalBottomSheet() {
    final stateProps = context.read<TransactionBloc>().state.stateProps;
    final checkoutUrl = stateProps.lastPaymentResponse?.responseData.checkoutUrl;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: CheckoutView(
                      checkoutUrl: checkoutUrl.value,
                      onComplete: checkoutCompleted,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void onProceedButtonTapped() {
    if (formKey.currentState!.validate()) {
      final amount = amountController.text.trim();
      final email = emailController.text.trim();
      final name = nameController.text.trim();

      final body = InitiateRequest(
        amount: double.parse(amount) * 100,
        email: email,
        name: name,
      );

      transBloc.add(InitiateTransaction(request: body));
    }
  }

  void showSnackBarWith(String msg, {MessageType msgType = MessageType.error}) {
    Color color = Colors.black87;
    if (msgType == MessageType.error) {
      color = Colors.red;
    } else if (msgType == MessageType.success) {
      color = Colors.green;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AppText(msg, color: Colors.white),
      backgroundColor: color,
    ));
  }

  void checkoutCompleted() {
    Navigator.of(context).pop();

    final initiateResponse = transBloc.state.stateProps.lastPaymentResponse;
    if (initiateResponse != null) {
      transBloc.add(FetchTransactionByRef(ref: initiateResponse.responseData.transRef));
    } else {
      showSnackBarWith('Transaction Ref is null');
    }
  }

  void updateTransactionHistory(TransactionDetail? lastTransaction) {
    showSnackBarWith('Payment Successful', msgType: MessageType.success);
    if (lastTransaction != null) {
      transBloc.add(UpdateTransactionsHistory());
    }
  }
}

enum MessageType { error, success, info }
