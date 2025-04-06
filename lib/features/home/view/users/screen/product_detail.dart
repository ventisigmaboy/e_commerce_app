import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/home/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final dynamic product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String _selectedSize = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary0,
      appBar: AppBar(
        backgroundColor: AppColors.primary0,
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/notification.png', width: 25),
            onPressed: () async {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(kDefualtPaddin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    // padding: EdgeInsets.all(20),
                    child: Image.network(
                      widget.product['image'],
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) => Center(
                            child: Icon(Icons.error, color: Colors.grey),
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Product Title and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product['title'],
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary900,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.product['rating']['rate']}/5',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary900,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text(
                        ' (${widget.product['rating']['count']} reviews)',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Product Description
                  Text(
                    widget.product['description'],
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primary700,
                      height: 1.5,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  // Size Selection
                  Text(
                    'Choose size',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children:
                        ['S', 'M', 'L'].map((size) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                width: 1,
                                color: AppColors.primary100,
                              ),
                              showCheckmark: false,
                              label: Text(size),
                              selected: _selectedSize == size,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedSize = size; // Update selected size
                                });
                              },
                              selectedColor: AppColors.primary900,
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color:
                                    _selectedSize == size
                                        ? Colors.white
                                        : AppColors.primary900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefualtPaddin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary500,
                      ),
                    ),
                    Text(
                      '\$${widget.product['price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).addToCart(widget.product, _selectedSize);

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Added to cart')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary900,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/bag.png',
                          width: 20,
                          color: AppColors.primary0,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primary0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
