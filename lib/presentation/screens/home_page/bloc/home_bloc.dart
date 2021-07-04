import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:littleshops/data/model/banner_model.dart';
import 'package:littleshops/data/repository/banner_repository/banner_repository.dart';

import 'package:littleshops/presentation/screens/home_page/bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository _bannerRepository = BannerRepository();
  //final ProductRepository _productRepository = AppRepository.productRepository;

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
    List<BannerModel> models = [];
    BannerModel model = new BannerModel(id: "rerfrg", imageUrl: "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Feletronics_products.png?alt=media&token=0b6c711b-45c0-4ee7-bb75-6b109807e4a4");
    BannerModel mode2 = new BannerModel(id: "trtt", imageUrl: "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Ftools_products.jpeg?alt=media&token=f9927ece-bf19-495f-bf78-9fbb70f56efd");
    BannerModel model3 = new BannerModel(id: "trt", imageUrl: "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Ffast_food.jpeg?alt=media&token=4d0079ea-95b7-4df3-8eaa-8976820c90b0");
    BannerModel model4 = new BannerModel(id: "hyhyy", imageUrl: "https://firebasestorage.googleapis.com/v0/b/littleshops-e51d8.appspot.com/o/banners%2Fbasic_products.jpeg?alt=media&token=2a9a0bfe-27ea-4c52-96fc-aa2608ab8a3b");
    models.add(model);
    models.add(mode2);
    models.add(model3);
    models.add(model4);
    try {
      HomeResponse homeResponse = HomeResponse(
        //banners: await _bannerRepository.fetchBanners(),
        banners: models,

        //categories: await _productRepository.getCategories(),
        //popularProducts: await _productRepository.fetchPopularProducts(),
        //discountProducts: await _productRepository.fetchDiscountProducts(),
      );
      yield HomeLoaded(homeResponse: homeResponse);
    } catch (e) {
      yield HomeLoadFailure(e.toString());
    }
  }
}

class HomeResponse {
  final List<BannerModel> banners;
  //final List<CategoryModel> categories;
  //final List<Product> popularProducts;
  //final List<Product> discountProducts;

  HomeResponse({
    required this.banners,
    //required this.popularProducts,
    //required this.categories,
    //required this.discountProducts,
  });
}
