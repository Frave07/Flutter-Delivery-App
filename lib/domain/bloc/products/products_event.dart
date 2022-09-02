part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class OnAddNewCategoryEvent extends ProductsEvent {
  final String nameCategory;
  final String descriptionCategory;

  OnAddNewCategoryEvent(this.nameCategory, this.descriptionCategory);
}


class OnSelectCategoryEvent extends ProductsEvent {
  final int idCategory;
  final String category;

  OnSelectCategoryEvent(this.idCategory, this.category);
}

class OnUnSelectCategoryEvent extends ProductsEvent {}

class OnSelectMultipleImagesEvent extends ProductsEvent {
  final List<XFile> images;

  OnSelectMultipleImagesEvent(this.images);
}

class OnUnSelectMultipleImagesEvent extends ProductsEvent {}

class OnAddNewProductEvent extends ProductsEvent {
  final String name;
  final String description;
  final String price;
  final List<XFile> images;
  final String category;

  OnAddNewProductEvent(this.name, this.description, this.price, this.images, this.category);
}

class OnUpdateStatusProductEvent extends ProductsEvent {
  final String idProduct;
  final String status;

  OnUpdateStatusProductEvent(this.idProduct, this.status);
}

class OnDeleteProductEvent extends ProductsEvent {
  final String idProduct;

  OnDeleteProductEvent(this.idProduct);
}

class OnSearchProductEvent extends ProductsEvent {
  final String searchProduct;

  OnSearchProductEvent(this.searchProduct);
}
