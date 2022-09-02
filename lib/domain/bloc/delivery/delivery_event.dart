part of 'delivery_bloc.dart';

@immutable
abstract class DeliveryEvent {}


class OnSelectDeliveryEvent extends DeliveryEvent {
  final String idDelivery;
  final String notificationToken;

  OnSelectDeliveryEvent(this.idDelivery, this.notificationToken);
}

class OnUnSelectDeliveryEvent extends DeliveryEvent {}