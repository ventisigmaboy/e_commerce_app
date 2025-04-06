import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/home/service/product_service.dart';
import 'package:e_commerce_app/features/home/view/users/screen/product_detail.dart';
import 'package:e_commerce_app/features/models/product_res_model.dart';
import 'package:flutter/material.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  // Controllers and Services
  final TextEditingController _searchController = TextEditingController();
  final ProductService _productService = ProductService();

  // State Variables
  List<ProductResModel> _products = []; // All products
  List<ProductResModel> _filteredProducts = []; // Filtered results
  bool _isLoading = true; // Loading state
  bool _hasError = false; // Error state

  @override
  void initState() {
    super.initState();
    _loadProducts(); // Load products on init
    _searchController.addListener(_filterProducts); // Setup search listener
  }

  // Load products from service
  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      debugPrint('Error loading products: $e');
    }
  }

  // Filter products based on search query
  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =
          _products.where((product) {
            final title = product.title.toLowerCase();
            final category = product.category.toLowerCase();
            return title.contains(query) || category.contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary0,
      appBar: AppBar(
        backgroundColor: AppColors.primary0,
        centerTitle: true,
        title: const Text(
          'Product Search',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/notification.png', width: 25),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Field
          _buildSearchField(),

          // Results List
          Expanded(child: _buildResultsList()),
        ],
      ),
    );
  }

  // Build the search input field
  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(kDefualtPaddin),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'assets/icons/search.png',
              width: 20,
              color: AppColors.primary300,
            ),
          ),
          suffixIcon:
              _searchController.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  )
                  : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/icons/mic.png',
                      width: 20,
                      color: AppColors.primary300,
                    ),
                  ),
          hintText: 'Search for products...',
          hintStyle: TextStyle(color: AppColors.primary400),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary100),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary100),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Build the results list based on current state
  Widget _buildResultsList() {
    if (_isLoading) return _buildLoadingState();
    if (_hasError) return _buildErrorState();
    if (_filteredProducts.isEmpty) return _buildEmptyState();
    return _buildProductList();
  }

  // Loading state widget
  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  // Error state widget
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 16),
          const Text('Failed to load products'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _loadProducts, child: const Text('Retry')),
        ],
      ),
    );
  }

  // Empty results widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/search-duotone.png',
            width: 64,
            color: AppColors.primary300,
          ),
          const SizedBox(height: 16),
          Text(
            'No Products Found!',
            style: TextStyle(
              color: AppColors.primary900,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords',
            style: TextStyle(color: AppColors.primary400),
          ),
        ],
      ),
    );
  }

  // Product list widget
  Widget _buildProductList() {
    return ListView.builder(
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(product: product),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                  ),
                  title: Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary900,
                    ),
                  ),
                  subtitle: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary500,
                    ),
                  ),
                ),
              ),
              const Divider(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
