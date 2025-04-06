// lib/widgets/product_card.dart
import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/home/service/favorites_service.dart';
import 'package:e_commerce_app/features/home/view/users/screen/product_detail.dart';
import 'package:e_commerce_app/features/models/product_res_model.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductResModel product;
  const ProductCard({super.key, required this.product});

  final bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    final favoritesService = Provider.of<FavoritesService>(context);
    final isFavorite = favoritesService.isFavorite(product);
    return GestureDetector(
      onTap: () {
        // Navigate to product details
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetail(product: product)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Container with Favorite Button
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          Center(child: Icon(Icons.error, color: Colors.grey)),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: // Replace your existing GestureDetector with this:
                    Container(
                  // padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(10),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: LikeButton(
                    size: 35,
                    isLiked: context.watch<FavoritesService>().isFavorite(
                      product,
                    ),
                    onTap: (isLiked) async {
                      if (isFavorite) {
                        context.read<FavoritesService>().removeFromFavorites(
                          product,
                        );
                      } else {
                        context.read<FavoritesService>().addToFavorites(
                          product,
                        );
                      }
                      return !isLiked;
                    },
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : AppColors.primary500,
                        size: 20,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          // Product Details
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: AppColors.primary900,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 8),

                // Price and Discount
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.primary500,
                      ),
                    ),
                    if (product.price > 100) // Example condition
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          '\$${(product.price * 1.52).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
