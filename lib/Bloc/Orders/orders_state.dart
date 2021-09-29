part of 'orders_bloc.dart';

@immutable
class OrdersState {}




class LoadingOrderState extends OrdersState {}

class SuccessOrdersState extends OrdersState {}

class FailureOrdersState extends OrdersState {
  final String error;

  FailureOrdersState(this.error);
}


