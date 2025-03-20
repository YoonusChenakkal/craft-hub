import 'dart:io';
import 'package:crafti_hub/Vandor%20side/common/flush_bar.dart';
import 'package:crafti_hub/local_storage.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/category_model.dart';
import 'package:crafti_hub/user%20side/screens/products/product_model.dart';
import 'package:crafti_hub/Vandor%20side/screens/products/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:image_picker/image_picker.dart';

class VendorProductProvider extends ChangeNotifier {
  List<ProductModel> products = [];
  List<CategoryModel> categories = [
    CategoryModel(
        id: 1,
        name: 'Frames',
        image: "assets/image1/frames.jpeg",
        subCategories: [
          SubCategoryModel(
              id: 1,
              image: "assets/image1/spot1 (1).jpeg",
              name: 'Spotify Frames'),
          SubCategoryModel(
              id: 2, image: "assets/image1/hoopp.jpeg", name: 'Hoop Frames'),
          SubCategoryModel(
              id: 3, image: "assets/image1/number.jpeg", name: 'Number Frames'),
          SubCategoryModel(
              id: 4, image: "assets/image1/boxxx (1).jpeg", name: 'Box Frames'),
          SubCategoryModel(
              id: 5, image: "assets/image1/beeds.jpeg", name: 'Beed Frames'),
          SubCategoryModel(
              id: 6,
              image: "assets/image1/polaroid.jpeg",
              name: 'Polaroid Frames'),
        ]),
    CategoryModel(
        id: 2,
        name: 'Gift Hampers',
        image: "assets/image1/gifthamper.jpeg",
        subCategories: [
          SubCategoryModel(
              id: 1,
              image: "assets/image1/shirt hamper.jpeg",
              name: 'Shirt Hamper'),
          SubCategoryModel(
              id: 2, image: "assets/image1/giftham.jpeg", name: 'Gift Hamper'),
        ]),
    CategoryModel(
        id: 3,
        name: 'Bouquets',
        image: "assets/image1/bouquets.jpeg",
        subCategories: [
          SubCategoryModel(
              id: 1,
              image: "assets/image1/bride.jpeg",
              name: 'Bridal Bouquets'),
          SubCategoryModel(
              id: 2,
              image: "assets/image1/flower.jpeg",
              name: 'Flower Bouquets'),
          SubCategoryModel(
              id: 3, image: "assets/image1/candy.jpeg", name: 'Candy Bouquets'),
        ]),
    CategoryModel(
        id: 4,
        name: 'Resins',
        image: "assets/image1/resin.jpeg",
        subCategories: [
          SubCategoryModel(
              id: 1,
              image: "assets/image1/clock1 (5).jpeg",
              name: 'Clock Resins'),
          SubCategoryModel(
              id: 2,
              image: "assets/image1/Rframe1 (5).jpeg",
              name: 'Frame Resins'),
          SubCategoryModel(
              id: 3,
              image: "assets/image1/jewe1 (5).jpeg",
              name: 'Jewellery Resins'),
          SubCategoryModel(
              id: 4, image: "assets/image1/key1 (5).jpeg", name: 'Key Chain'),
          SubCategoryModel(
              id: 5, image: "assets/image1/pres1 (5).jpeg", name: 'Preserved '),
          SubCategoryModel(
              id: 6, image: "assets/image1/wall1 (5).jpeg", name: 'Decore'),
          SubCategoryModel(
              id: 7, image: "assets/image1/other1 (5).jpeg", name: 'Others')
        ]),
  ];
  List<File> _selectedImages = [];
  CategoryModel? _selectedCategory;
  SubCategoryModel? _selectedSubCategory;
  double _discountedPrice = 0.0;
  String _searchQuery = '';

  // Controllers for form fields
  TextEditingController tcProductName = TextEditingController();
  TextEditingController tcProductDescription = TextEditingController();
  TextEditingController tcPrice = TextEditingController();
  TextEditingController tcDiscount = TextEditingController();

  bool _isPopular = false;

  bool _isNewArrival = false;

  bool _isTrending = false;

  bool _isOfferProduct = false;

  bool _isLoading = false;

  get isLoading => _isLoading;

  get isPopular => _isPopular;

  get isNewArrival => _isNewArrival;

  get isTrending => _isTrending;
  get isOfferProduct => _isOfferProduct;
  get discountedPrice => _discountedPrice;
  List<File> get selectedImages => _selectedImages;
  CategoryModel? get selectedCategory => _selectedCategory;
  SubCategoryModel? get selectedSubCategory => _selectedSubCategory;

  List<ProductModel> get filteredProducts => products
      .where((product) =>
          product.vendorName.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  set isPopular(value) {
    _isPopular = value;
    notifyListeners();
  }

  set isNewArrival(value) {
    _isNewArrival = value;
    notifyListeners();
  }

  set isTrending(value) {
    _isTrending = value;
    notifyListeners();
  }

  set isOfferProduct(value) {
    _isOfferProduct = value;
    notifyListeners();
  }

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  set selectedCategory(value) {
    _selectedCategory = value;
    notifyListeners();
  }

  set selectedSubCategory(value) {
    _selectedSubCategory = value;
    notifyListeners();
  }

  set discountedPrice(value) {
    _discountedPrice = value;
    notifyListeners();
  }

  Future<void> pickImages() async {
    try {
      final ImagePicker _picker = ImagePicker();

      final List<XFile>? pickedFiles = await _picker.pickMultiImage(
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFiles != null) {
        _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
        notifyListeners();
      }
    } catch (e) {
      print("❌ Error picking images: $e");
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < _selectedImages.length) {
      _selectedImages.removeAt(index);
      notifyListeners();
    }
  }

  void clearImages() {
    _selectedImages.clear();
    notifyListeners();
  }

  ProductRepository _productRepo = ProductRepository();

  fetchProducts(BuildContext context) async {
    SVProgressHUD.show();
    final userId = await LocalStorage.getUser();

    try {
      final response = await _productRepo.fetchProducts(userId);

      products = (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();

      print('Sucess Product Fetch');
      notifyListeners();
    } catch (e) {
      // Display the parsed error message

      print("❌ Fetching Products failed: $e");
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  Future<void> addProduct(BuildContext context) async {
    SVProgressHUD.show();

    try {
      int? userId = await LocalStorage.getUser();
      if (userId == null) {
        showFlushbar(
          context: context,
          color: Colors.red,
          icon: Icons.error,
          message: 'Please log in again.',
        );
        isLoading = false;
        notifyListeners();
        return;
      }
      // Call API to add product

      await _productRepo.addProduct(
        userId: userId,
        productName: tcProductName.text,
        productDescription: tcProductDescription.text,
        price: tcPrice.text,
        discount: tcDiscount.text,
        categoryname: selectedCategory!.name,
        subcategoryname: selectedSubCategory!.name,
        images: selectedImages,
        isOfferProduct: isOfferProduct,
        isNewArrival: isNewArrival,
        isPopularProduct: isPopular,
        isTrendingProduct: isTrending,
      );

      print('✅ Product added successfully');
      Navigator.pop(context);

      await showFlushbar(
        context: context,
        color: Colors.green,
        icon: Icons.check_circle,
        message: 'Product added successfully!',
      );

      // Clear form after success
      reset();
    } catch (e) {
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Adding Product Failed', // Clear error message
      );
      print("❌ Product addition failed: $e");
    } finally {
      SVProgressHUD.dismiss();
    }
  }

  Future<void> updateProduct(int productId, BuildContext context) async {
    SVProgressHUD.show();
    isLoading = true;
    notifyListeners();

    try {
      // Call API to add product

      await _productRepo.updateProduct(
        productId: productId,
        productName: tcProductName.text,
        productDescription: tcProductDescription.text,
        price: tcPrice.text,
        discount: tcDiscount.text,
        categoryname: selectedCategory?.name,
        subcategoryname: selectedSubCategory?.name,
        isOfferProduct: isOfferProduct,
        isNewArrival: isNewArrival,
        isPopularProduct: isPopular,
        isTrendingProduct: isTrending,
      );

      print('✅ Product Updated successfully');
      fetchProducts(context);
      notifyListeners();
      Navigator.pop(context);
      await showFlushbar(
        context: context,
        color: Colors.brown,
        icon: Icons.check_circle,
        message: 'Product Updated successfully!',
      );

      // Clear form after success
      reset();
    } catch (e) {
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Updating Product Failed', // Clear error message
      );
      print("❌ Product Updating failed: $e");
    } finally {
      isLoading = false;
      SVProgressHUD.dismiss();
      notifyListeners();
    }
  }

  // delete product

  Future<void> deleteProduct(int productId, BuildContext context) async {
    print('Deleting Product: $productId');
    isLoading = true;
    SVProgressHUD.show();
    notifyListeners();

    try {
      // Call API to delete product
      await _productRepo.deleteProduct(productId);

      print('✅ Product Deleted successfully');
      await showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.check_circle,
        message: 'Product Deleted successfully!',
      );
      fetchProducts(context);
      // Clear form after success
      reset();
    } catch (e) {
      showFlushbar(
        context: context,
        color: Colors.red,
        icon: Icons.error,
        message: 'Deleting Product Failed', // Clear error message
      );
      print("❌ Product Deleting failed: $e");
    } finally {
      isLoading = false;
      SVProgressHUD.dismiss();
      notifyListeners();
    }
  }

  reset() {
    tcProductName.clear();
    tcProductDescription.clear();
    tcPrice.clear();
    tcDiscount.clear();
    selectedImages.clear();
    selectedCategory = null;

    notifyListeners();
  }
}
