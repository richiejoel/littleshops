import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/data/model/banner_model.dart';
import 'package:littleshops/data/model/category_model.dart';
import 'package:littleshops/data/model/product_model.dart';
import 'package:littleshops/data/repository/banner_repository/banner_repository.dart';
import 'package:littleshops/data/repository/product_repository/product_repository.dart';

import 'package:littleshops/presentation/screens/home_page/bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository = BannerRepository();
  final ProductRepository _productRepository = ProductRepository();

  HomeBloc() : super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadHome) {
      yield* _mapLoadHomeToState();
    } else if (event is RefreshHome) {
      yield HomeLoading();
      yield* _mapLoadHomeToState();
    }
  }

  Stream<HomeState> _mapLoadHomeToState() async* {
    try {
      HomeResponse homeResponse = HomeResponse(
        banners: await _bannerRepository.fetchBanners(),
        categories: await _productRepository.getCategories(),
        popularProducts: await _productRepository.fetchPopularProducts(),
        discountProducts: await _productRepository.fetchDiscountProducts(),
        //banners: models
      );
      yield HomeLoaded(homeResponse: homeResponse);
    } catch (e) {
      yield HomeLoadFailure(e.toString());
    }
  }
}

List<Product> mListStatic(){
  List<Product> models = [];
  Product model = new Product(
      id: "xdf4rffrrfr",
      name: 'Martillo',
      categoryId: 'cdcdcdd',
      description: 'efrfrfrfr',
      quantity: 40,
      soldQuantity: 10,
      originalPrice: 2,
      percentOff: 2,
      rating: 3.5,
      isAvailable: true,
      images: [
        "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Feletronics_products.png?alt=media&token=0b6c711b-45c0-4ee7-bb75-6b109807e4a4",
        "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c",
        "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c",
        'https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c',
      ],
  );

  Product model1 = new Product(
    id: "xdf4rffrrfr",
    name: 'Martillo',
    categoryId: 'cdcdcdd',
    description: 'efrfrfrfr',
    quantity: 40,
    soldQuantity: 10,
    originalPrice: 2,
    percentOff: 2,
    rating: 3.5,
    isAvailable: true,
    images: [
      "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Feletronics_products.png?alt=media&token=0b6c711b-45c0-4ee7-bb75-6b109807e4a4",
      "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c",
      "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c",
      'https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c',
    ],
  );

  Product model2 = new Product(
    id: "xdf4rffrrfr",
    name: 'Martillo',
    categoryId: 'cdcdcdd',
    description: 'efrfrfrfr',
    quantity: 40,
    soldQuantity: 10,
    originalPrice: 2,
    percentOff: 2,
    rating: 3.5,
    isAvailable: true,
    images: [
      "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Feletronics_products.png?alt=media&token=0b6c711b-45c0-4ee7-bb75-6b109807e4a4",
      "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c",
      "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c",
      'https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/products%2Fmartillo_1.png?alt=media&token=eea1bba3-bf79-46a6-a871-8b7d6bd76f2c',
    ],
  );

  models.add(model);
  models.add(model1);
  models.add(model2);


  return models;



}

class HomeResponse {
  final List<BannerModel> banners;
  final List<CategoryModel> categories;
  final List<Product> popularProducts;
  final List<Product> discountProducts;

  HomeResponse({
    required this.banners,
    required this.popularProducts,
    required this.categories,
    required this.discountProducts,
  });
}
