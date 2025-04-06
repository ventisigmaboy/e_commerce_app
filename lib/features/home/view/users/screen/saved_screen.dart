import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/home/service/favorites_service.dart';
import 'package:e_commerce_app/features/models/product_res_model.dart';
import 'package:e_commerce_app/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductResModel> favorites =
        Provider.of<FavoritesService>(context).favorites;

    return Scaffold(
      backgroundColor: AppColors.primary0,
      appBar: AppBar(
        backgroundColor: AppColors.primary0,
        centerTitle: true,
        title: const Text(
          'Saved Items',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/notification.png', width: 25),
            onPressed: () {},
          ),
        ],
      ),
      body:
          favorites.isEmpty
              ? _buildEmptyState()
              : _buildFavoritesGrid(favorites),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 60, color: AppColors.primary300),
          const SizedBox(height: 16),
          Text(
            'No saved items yet!',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.primary900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'You don\'t have any saved items.\nGo to home and add some.',
            style: TextStyle(fontSize: 15, color: AppColors.primary500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid(List<ProductResModel> favorites) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return ProductCard(product: favorites[index]);
      },
    );
  }
}
