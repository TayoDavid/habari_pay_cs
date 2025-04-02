import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habari_pay_cs/data/repositories/payment_repository.dart';
import 'package:habari_pay_cs/models/initiate_request.dart';
import 'package:habari_pay_cs/models/initiate_response.dart';
import 'package:habari_pay_cs/models/transaction_response.dart';
import 'package:habari_pay_cs/utils/extension.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final PaymentRepository repository;

  TransactionBloc({required this.repository}) : super(InitialTransactionState()) {
    on<TransactionEvent>((event, emit) => event.handle(this, emit));
  }
}
