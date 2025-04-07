import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final List<Map<String, dynamic>> items = [
      {
        'icon': 'assets/icons/statisctics.png',
        'label': 'Dashboard',
        'route': DashboardScreen(),
      },
      {
        'icon': 'assets/icons/box.png',
        'label': 'Products',
        'route': ProductsScreen(),
      },
      {
        'icon': 'assets/icons/users.png',
        'label': 'Customers',
        'route': CustomersScreen(),
      },
      {
        'icon': 'assets/icons/cart.png',
        'label': 'Orders',
        'badge': 3,
        'route': OrdersScreen(),
      },
    ];

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admin',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefualtPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children:
                    items.map((item) {
                      return buildDashboardItem(item, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => item['route']),
                        );
                      });
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardItem(Map<String, dynamic> item, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary200,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Image.asset(item['icon'], width: 40),
                  SizedBox(height: 5),
                  Text(
                    item['label'],
                    style: TextStyle(
                      color: AppColors.primary900,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (item.containsKey('badge'))
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${item['badge']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(child: Text("Dashboard Screen")),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: Center(child: Text("Products Screen")),
    );
  }
}

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customers")),
      body: Center(child: Text("Customers Screen")),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: Center(child: Text("Orders Screen")),
    );
  }
}
