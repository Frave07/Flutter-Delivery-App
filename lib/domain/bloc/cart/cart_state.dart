part of 'cart_bloc.dart';

@immutable
class CartState {

  final List<ProductCart>? products;
  final double total;
  final int amount;
  final int quantity;
  final int quantityCart;

  CartState({
    this.products,
    this.total = 0.00, 
    this.amount = 0,
    this.quantity = 1,
    this.quantityCart = 0
  });

  CartState copyWith({List<ProductCart>? products, double? total, int? amount, int? quantity, int? quantityCart })
    => CartState(
      products: products ?? this.products,
      total: total ?? this.total,
      amount: amount ?? this.amount,
      quantity: quantity ?? this.quantity,
      quantityCart: quantityCart ?? this.quantityCart
    );
}

