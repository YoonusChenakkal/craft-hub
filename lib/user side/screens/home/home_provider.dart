import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/screens/home/carousel_model.dart';
import 'package:crafti_hub/user%20side/screens/home/home_respository.dart';
import 'package:crafti_hub/user%20side/screens/home/product_banner_model.dart';
import 'package:crafti_hub/user%20side/screens/products/product_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<ProductModel> popularProducts = [];
  List<ProductModel> offerProducts = [];
  List<ProductModel> allProducts = [];
  List<ProductBannerModel> promoBanners = [];
  List<CarouselItem> carousels = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;

  List<ProductModel> get filteredProducts => allProducts
      .where((product) =>
          product.vendorName.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  set isLoading(value) {
    _isLoading = value;
  }

  set searchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  final HomeRespository _homeRepo = HomeRespository();

  //---------------- fetch Popular Products ------->

  fetchPopularProducts(BuildContext context) async {
    isLoading = true;

    try {
      final response = await _homeRepo.fetchPopularProducts();

      popularProducts = (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();

      print('Sucess popular Product Fetch');
      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Fetching popular Products Failed',
      );
      print("❌ Fetching popular Products failed: $e");
    } finally {
      isLoading = false;
    }
  }

  //---------------- fetch Offer Products ------->

  fetchOfferProducts(BuildContext context) async {
    isLoading = true;

    try {
      final response = await _homeRepo.fetchOfferProducts();

      offerProducts = (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();

      print('Sucess OfferProduct Fetch');
      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Fetching offer Products Failed',
      );
      print("❌ Fetching offer Products failed: $e");
    } finally {
      isLoading = false;
    }
  }
  //---------------- fetch All Products ------->

  fetchAllProducts(BuildContext context) async {
    isLoading = true;

    try {
      final response = await _homeRepo.fetchAllProducts();

      allProducts = (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();

      print('Sucess All Product Fetch');
      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Fetching All Products Failed',
      );
      print("❌ Fetching All Products failed: $e");
    } finally {
      isLoading = false;
    }
  }

  //---------------- fetch Promo  Banners  ------->

  fetchPromoBanners(BuildContext context) async {
    isLoading = true;

    try {
      final response = await _homeRepo.fetchPromoBanners();

      promoBanners = (response.data as List)
          .map((item) => ProductBannerModel.fromJson(item))
          .toList();

      print('Sucess Fetch Promo Banners Fetch');

      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Fetching Promo Banners  Failed',
      );
      print("❌ Fetching Promo Banners failed: $e");
    } finally {
      isLoading = false;
    }
  }

  // fetch carousel
  fetchCarousel(BuildContext context) async {
    isLoading = true;

    try {
      final response = await _homeRepo.fetchCarousel();

      carousels = (response.data as List)
          .map((item) => CarouselItem.fromJson(item))
          .toList();

      print('Sucess Fetch Carousel');
      notifyListeners();
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Fetching Carousel Failed',
      );
      print("❌ Fetching Carousel failed: $e");
    } finally {
      isLoading = false;
    }
  }
}
