import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/home/provider/cart_provider.dart';
import 'package:e_commerce_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primary0,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/notification.png', width: 25),
            onPressed: () async {},
          ),
        ],
        backgroundColor: AppColors.primary0,
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary100),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          leading: Image.network(
                            item.product.image,
                            width: 50,
                            errorBuilder: (_, __, ___) => 
                                const Icon(Icons.error),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.product.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    wordSpacing: -1,
                                    color: AppColors.primary900,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => cart.removeFromCart(index),
                                child: Image.asset(
                                  'assets/icons/trash.png',
                                  width: 15,
                                  color: AppColors.red,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Size: ${item.selectedSize}',
                                style: TextStyle(
                                  color: AppColors.primary500,
                                  fontSize: 13,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$${item.product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: AppColors.primary900,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => cart.decrementQty(index),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.primary100,
                                            ),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                          child: const Icon(Icons.remove),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                        child: Text('${item.quantity}'),
                                      ),
                                      GestureDetector(
                                        onTap: () => cart.incrementQty(index),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.primary100,
                                            ),
                                            borderRadius: BorderRadius.circular(3),
                                          ),
                                          child: const Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 1, color: AppColors.primary100),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      _summaryRow(
                        'Sub-total',
                        cart.subTotal.toStringAsFixed(2),
                      ),
                      _summaryRow('VAT (%)', '0.00'),
                      _summaryRow('Shipping fee', '10.00'),
                      const Divider(height: 20),
                      _summaryRow(
                        'Total',
                        (cart.subTotal + 10).toStringAsFixed(2),
                        isTotal: true,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        rightIcon: const Icon(Icons.arrow_forward),
                        text: 'Go to Checkout',
                        textColor: AppColors.primary0,
                        onPressed: () {},
                        color: AppColors.primary900,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? Colors.black : Colors.grey[600],
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Text(
            '\$$value',
            style: TextStyle(
              color: isTotal ? Colors.black : Colors.black,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}