import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habari_pay_cs/utils/app_logger.dart';

class AppBlocObserver extends BlocObserver with AppLogger {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log.i(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.e(error);
    super.onError(bloc, error, stackTrace);
  }
}
