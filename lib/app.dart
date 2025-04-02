import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habari_pay_cs/bloc/transaction/transaction_bloc.dart';
import 'package:habari_pay_cs/data/data_providers/payment_data_provider.dart';
import 'package:habari_pay_cs/data/repositories/payment_repository.dart';
import 'package:habari_pay_cs/view/home_page.dart';
import 'package:habari_pay_cs/network/network_client.dart';
import 'package:habari_pay_cs/utils/bloc_observer.dart';

class HabariPayApp {
  static Widget initialize({
    required String baseUrl,
    required String privateKey,
  }) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Bloc.observer = AppBlocObserver();

    final networkClient = NetworkClient(baseUrl: baseUrl, privateKey: privateKey);

    return RepositoryProvider.value(
      value: PaymentRepository(dataProvider: PaymentDataProvider(client: networkClient)),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TransactionBloc(
              repository: context.read<PaymentRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        ),
      ),
    );
  }
}
