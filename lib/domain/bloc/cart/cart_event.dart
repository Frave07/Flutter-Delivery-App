part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnIncreaseProductQuantityEvent extends CartEvent {}

class OnDecreaseProductQuantityEvent extends CartEvent {}

class OnResetQuantityEvent extends CartEvent {}

class OnAddProductToCartEvent extends CartEvent {
  final ProductCart productCart;

  OnAddProductToCartEvent(this.productCart);
}

class OnDeleteProductToCartEvent extends CartEvent {
  final int index;

  OnDeleteProductToCartEvent(this.index);
}

class OnIncreaseQuantityProductToCartEvent extends CartEvent {
  final int plus;

  OnIncreaseQuantityProductToCartEvent(this.plus);
}

class OnDecreaseProductQuantityToCartEvent extends CartEvent {
  final int subtract;

  OnDecreaseProductQuantityToCartEvent(this.subtract);
}


class OnClearCartEvent extends CartEvent {}
