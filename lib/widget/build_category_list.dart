import 'package:e_commerce_app/config/constants.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  int _selectedIndex = 0;

  final List<String> categories = [
    'All',
    'Tshirts',
    'Jeans',
    'Shoes',
    'Hoodie',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? kDefualtPaddin : 10,
            right: index == categories.length - 1 ? kDefualtPaddin : 0,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              // Add your category selection logic here
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              decoration: BoxDecoration(
                color:
                    _selectedIndex == index
                        ? AppColors.primary900
                        : Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(10),
                border:
                    _selectedIndex == index
                        ? null
                        : Border.all(color: AppColors.primary100),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color:
                        _selectedIndex == index
                            ? AppColors.primary0
                            : AppColors.primary900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
