import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/product_model.dart';
import '../../../services/product_service.dart';
import '../../../services/cart_service.dart';

class HomeViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();
  final CartService _cartService = locator<CartService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Product> _products = [];
  List<Product> get products => _products;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  int get cartItemCount => _cartService.totalItems;

  HomeViewModel() {
    _cartService.cartItems.addListener(_onCartUpdated);
  }

  void _onCartUpdated() {
    notifyListeners();
  }

  @override
  void dispose() {
    _cartService.cartItems.removeListener(_onCartUpdated);
    super.dispose();
  }

  List<String> get categories {
    final Set<String> uniqueCategories = {'All'};
    for (var product in _products) {
      if (product.category.isNotEmpty) {
        uniqueCategories.add(product.category);
      }
    }
    return uniqueCategories.toList();
  }

  Future<void> fetchProducts() async {
    setBusy(true);
    _products = await _productService.getProducts();
    setBusy(false);
  }

  List<Product> get filteredProducts {
    if (_selectedCategory == 'All') {
      return _products;
    }
    return _products.where((p) => p.category.toLowerCase() == _selectedCategory.toLowerCase()).toList();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void addToCart(Product product) {
    _cartService.addToCart(product);
  }
}

