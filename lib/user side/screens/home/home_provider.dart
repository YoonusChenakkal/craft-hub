import 'package:crafti_hub/user%20side/common/flush_bar.dart';
import 'package:crafti_hub/user%20side/screens/home/carousel_model.dart';
import 'package:crafti_hub/user%20side/screens/home/home_respository.dart';
import 'package:crafti_hub/user%20side/screens/home/product_banner_model.dart';
import 'package:crafti_hub/user%20side/screens/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<ProductModel> popularProducts = [];
  List<ProductModel> offerProducts = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> ProductsByCategory = [];
  int _selectedSubCategoryIndex = 0;
  List<ProductBannerModel> promoBanners = [];
  List<CarouselItem> carousels = [];
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  int get selectedSubCategoryIndex => _selectedSubCategoryIndex;
  set selectedSubCategoryIndex(value) {
    _selectedSubCategoryIndex = value;
    notifyListeners();
  }

  List<ProductModel> get filteredProducts => allProducts
      .where((product) =>
          product.vendorName.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  // Inside HomeProvider
  void getProductsofSubcategory(String? categoryName, String? subCategoryname) {
    print(categoryName);
    print(subCategoryname);

    ProductsByCategory = allProducts
        .where((product) =>
            product.displaycategoryname == categoryName &&
            product.subcategory == subCategoryname)
        .toList();
    notifyListeners(); // Trigger UI update
  }

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
    SVProgressHUD.show();

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
      SVProgressHUD.dismiss();
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

  // Add review to product
  addReviewToProduct(
      BuildContext context, int productId, String review, int rating) async {
    isLoading = true;
    SVProgressHUD.show();
    notifyListeners(); // Notify listeners to show loading state

    try {
      final response =
          await _homeRepo.addReviewToProduct(productId, review, rating);

      // Parse the response
      final newReview = Review(
        id: response['id'],
        user: response['user_name'], // Use 'user_name' from the response
        product: response['product'],
        rating: double.parse(response['rating']),
        review: response['review'],
        createdAt: DateTime.parse(response['created_at']),
      );

      // Find the product in the allProducts list
      final productIndex =
          allProducts.indexWhere((product) => product.id == productId);

      if (productIndex != -1) {
        // Add the new review to the product's reviews list
        allProducts[productIndex].reviews.add(newReview);

        // Notify listeners to update the UI
        notifyListeners();

        // Show success message
        showFlushbar(
          context: context,
          color: Colors.green,
          icon: Icons.check,
          message: 'Review added successfully!',
        );
      } else {
        // Handle case where the product is not found
        showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.error,
          message: 'Product not found',
        );
      }
    } on Exception catch (e) {
      // Display the parsed error message
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Adding Review Failed',
      );
      print("❌ Adding Review failed: $e");
    } finally {
      isLoading = false;
      SVProgressHUD.dismiss();
      notifyListeners(); // Notify listeners to hide loading state
    }
  }
}
