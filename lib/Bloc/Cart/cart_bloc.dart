import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/Models/ProductCart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  CartBloc() : super(CartState()){

    on<OnIncreaseProductQuantityEvent>( _onIncreaseProductQuantity );
    on<OnDecreaseProductQuantityEvent>( _onDecreaseProductQuantity );
    on<OnResetQuantityEvent>( _onResetQuantity );
    on<OnAddProductToCartEvent>( _onAddProductToCart );
    on<OnDeleteProductToCartEvent>( _onDeleteProductToCart );
    on<OnIncreaseQuantityProductToCartEvent>( _onIncrementQuantityProductToCard );
    on<OnDecreaseProductQuantityToCartEvent>( _onDecreaseQuantityProductToCart );
    on<OnClearCartEvent>( _onClearCart );

  }

  List<ProductCart> product = [];


  Future<void> _onIncreaseProductQuantity( OnIncreaseProductQuantityEvent event, Emitter<CartState> emit ) async {

    emit( state.copyWith( quantity: state.quantity + 1 ) ); 

  }

  Future<void> _onDecreaseProductQuantity( OnDecreaseProductQuantityEvent event, Emitter<CartState> emit ) async {

    emit( state.copyWith(quantity: state.quantity - 1) ); 

  }

  Future<void> _onResetQuantity( OnResetQuantityEvent evet, Emitter<CartState> emit ) async {

    emit( state.copyWith(quantity: 1) );
  }

  Future<void> _onAddProductToCart( OnAddProductToCartEvent event, Emitter<CartState> emit ) async {

    final verify = product.where((pro) => pro.uidProduct.contains(event.productCart.uidProduct));

    if( verify.isEmpty ){

      product.add(event.productCart);

      double total= 0.00;

      product.forEach((p) => total = total + (p.price * p.quantity));

      emit( state.copyWith(
        products: product,
        quantityCart: product.length,
        total: total
      ));
    }

  }

  Future<void> _onDeleteProductToCart( OnDeleteProductToCartEvent event, Emitter<CartState> emit ) async {

    product.removeAt(event.index);

    double total = 0.00;
    product.forEach((p) => total = total + p.price );

    emit( state.copyWith(
      products: product,
      quantityCart: product.length,
      total: total
    ));

  }

  Future<void> _onIncrementQuantityProductToCard( OnIncreaseQuantityProductToCartEvent event, Emitter<CartState> emit ) async {

    product[event.plus].quantity++;

    double total = 0.00;
    product.forEach((p) => total = total + (p.price * p.quantity));

    emit( state.copyWith(
      products: product,
      quantityCart: product.length,
      total: total,
    ));

  }

  Future<void> _onDecreaseQuantityProductToCart( OnDecreaseProductQuantityToCartEvent event, Emitter<CartState> emit ) async {

    product[event.subtract].quantity--;
    
    double total = 0.00;

    product.forEach((p) => total = total - ( p.price *  p.quantity ));

    emit( state.copyWith(
      products: product,
      quantityCart: product.length,
      total: total.abs()
    ));

  }

  Future<void> _onClearCart( OnClearCartEvent event, Emitter<CartState> emit ) async {

    emit( state.copyWith(
      amount: 0,
      quantity: 0,
      products: [],
      quantityCart: 0,
      total: 0.0
    ));

  }

  
}
