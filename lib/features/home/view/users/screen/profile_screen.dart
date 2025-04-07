import 'package:e_commerce_app/config/constants.dart';
import 'package:e_commerce_app/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary100,
      appBar: AppBar(
        backgroundColor: AppColors.primary0,
        centerTitle: true,
        title: const Text(
          'Account',
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
          Container(
            color: AppColors.primary0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(color: AppColors.primary100),
                ),
                _buildListTile(
                  divier: false,
                  title: "My Orders",
                  image: 'assets/icons/box.png',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: AppColors.primary0,
            child: Column(
              children: [
                SizedBox(height: 8),
                _buildListTile(
                  title: "My Details",
                  image: 'assets/icons/details.png',
                  divier: true,
                ),
                _buildListTile(
                  title: "Address Book",
                  image: 'assets/icons/address.png',
                  divier: true,
                ),
                _buildListTile(
                  title: "Payment Methods",
                  image: 'assets/icons/card.png',
                  divier: true,
                ),
                _buildListTile(
                  title: "Notifications",
                  image: 'assets/icons/notification.png',
                  divier: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: AppColors.primary0,
            child: Column(
              children: [
                const SizedBox(height: 8),
                _buildListTile(
                  divier: true,
                  title: 'FAQs',
                  image: 'assets/icons/question.png',
                ),
                _buildListTile(
                  divier: false,
                  title: 'Help Center',
                  image: 'assets/icons/headphones.png',
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              color: AppColors.primary0,
              child: _buildListTile(
                divier: false,
                title: 'Log out',
                color: AppColors.red,
                image: 'assets/icons/logout.png',
                iconColor: AppColors.red,
                trailing: false,
                onTap: () async {
                  await authService.logout();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildListTile({
  required bool divier,
  required String title,
  required String image,
  Color? color,
  Color? iconColor,
  bool trailing = true,
  void Function()? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: kDefualtPaddin - 5),
    child: Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Row(
            children: [
              Image.asset(image, width: 20, color: iconColor),
              SizedBox(width: 8),
              Text(title, style: TextStyle(color: color)),
            ],
          ),
          trailing:
              trailing
                  ? Icon(Icons.arrow_forward_ios_rounded, size: 20)
                  : SizedBox(),
        ),
        divier ? Divider(color: AppColors.primary100) : SizedBox(height: 8),
      ],
    ),
  );
}
