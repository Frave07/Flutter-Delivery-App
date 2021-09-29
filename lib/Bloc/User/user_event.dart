part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class OnGetUserEvent extends UserEvent {
  final User user;

  OnGetUserEvent(this.user);
}


class OnSelectPictureEvent extends UserEvent {
  final String pictureProfilePath;

  OnSelectPictureEvent(this.pictureProfilePath);
}


class OnClearPicturePathEvent extends UserEvent {}


class OnChangeImageProfileEvent extends UserEvent {
  final String image;

  OnChangeImageProfileEvent(this.image);
}


class OnEditUserEvent extends UserEvent {
  final String name;
  final String lastname;
  final String phone;

  OnEditUserEvent(this.name, this.lastname, this.phone);
}


class OnChangePasswordEvent extends UserEvent {
  final String currentPassword;
  final String newPassword;

  OnChangePasswordEvent(this.currentPassword, this.newPassword);
}


class OnRegisterDeliveryEvent extends UserEvent {
  final String name;
  final String lastname;
  final String phone;
  final String email;
  final String password;
  final String image; 

  OnRegisterDeliveryEvent(this.name, this.lastname, this.phone, this.email, this.password, this.image);
}


class OnRegisterClientEvent extends UserEvent {
  final String name;
  final String lastname;
  final String phone;
  final String email;
  final String password;
  final String image;

  OnRegisterClientEvent(this.name, this.lastname, this.phone, this.email, this.password, this.image);

}


class OnDeleteStreetAddressEvent extends UserEvent {
  final int uid;

  OnDeleteStreetAddressEvent(this.uid);
}


class OnAddNewAddressEvent extends UserEvent {
  final String street;
  final String reference;
  final LatLng location;

  OnAddNewAddressEvent(this.street, this.reference, this.location);
}


class OnSelectAddressButtonEvent extends UserEvent {
  final int uidAddress;
  final String addressName;

  OnSelectAddressButtonEvent(this.uidAddress, this.addressName);
}


class OnUpdateDeliveryToClientEvent extends UserEvent {
  final String idPerson;

  OnUpdateDeliveryToClientEvent(this.idPerson);
}