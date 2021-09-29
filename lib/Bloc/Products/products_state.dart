part of 'products_bloc.dart';

@immutable
class ProductsState {

  final int idCategory;
  final String? category;
  final List<XFile>? images;
  final String searchProduct;

  ProductsState({
    this.idCategory = 0, 
    this.category,
    this.images,
    this.searchProduct = ''
  });

  ProductsState copyWith({ int? idCategory, String? category, List<XFile>? images, String? searchProduct })
    => ProductsState(
      idCategory: idCategory ?? this.idCategory,
      category: category ?? this.category,
      images: images ?? this.images,
      searchProduct: searchProduct ?? this.searchProduct
    );

}


class LoadingProductsState extends ProductsState {}

class SuccessProductsState extends ProductsState {}

class FailureProductsState extends ProductsState {
  final String error;

  FailureProductsState(this.error);
}