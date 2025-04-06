import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/auth/service/auth_service.dart';
import 'package:e_commerce_app/features/home/service/product_service.dart';
import 'package:e_commerce_app/features/models/product_res_model.dart';
import 'package:e_commerce_app/widget/build_category_list.dart';
import 'package:e_commerce_app/widget/build_search_field.dart';
import 'package:e_commerce_app/widget/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();
  late Future<List<ProductResModel>> _productsFuture; // Updated type

  @override
  void initState() {
    super.initState();
    _productsFuture = productService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary0,
      appBar: AppBar(
        backgroundColor: AppColors.primary0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/notification.png', width: 25),
            onPressed: () async {
              await authService.logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    hintText: 'Search for products...',
                    controller: _searchController,
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primary900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/icons/filter.png',
                      width: 25,
                      color: AppColors.primary0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(height: 36, child: CategoryListView()),
          const SizedBox(height: 20),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return Expanded(
      child: FutureBuilder<List<ProductResModel>>( // Updated type
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          final products = snapshot.data!;
          
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.6,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}