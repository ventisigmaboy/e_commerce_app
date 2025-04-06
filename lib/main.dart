import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/screen/login_screen.dart';
import 'package:e_commerce_app/features/auth/screen/signup_screen.dart';
import 'package:e_commerce_app/features/home/provider/cart_provider.dart';
import 'package:e_commerce_app/features/home/service/favorites_service.dart';
import 'package:e_commerce_app/features/home/view/admin/screen/admin_screen.dart';
import 'package:e_commerce_app/features/home/view/users/main_screen.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesService()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: ECommerceApp(),
    ),
  );
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthStateHandle(),
      theme: ThemeData(fontFamily: 'GeneralSans'),
    );
  }
}

class AuthStateHandle extends StatefulWidget {
  const AuthStateHandle({super.key});

  @override
  State<AuthStateHandle> createState() => _AuthStateHandleState();
}

class _AuthStateHandleState extends State<AuthStateHandle> {
  User? _currentUser;
  String? _userRole;
  bool _isCheckingUser = true; // Add this flag to track initial check

  @override
  void initState() {
    _initialzeAuthState();
    super.initState();
  }

  void _initialzeAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (!mounted) return;

      setState(() {
        _currentUser = user;
        _isCheckingUser = true; // Start checking user
      });

      if (user != null) {
        try {
          final userDoc =
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(user.uid)
                  .get();

          if (!mounted) return;

          setState(() {
            _userRole = userDoc.exists ? userDoc['role'] : null;
            _isCheckingUser = false; // Finished checking
          });
        } catch (e) {
          if (!mounted) return;
          setState(() {
            _userRole = null;
            _isCheckingUser = false; // Finished checking even if error
          });
        }
      } else {
        setState(() {
          _isCheckingUser = false; // No user, finished checking
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // If we're still checking the initial auth state, show loading
    if (_isCheckingUser) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // If no user is logged in, show login screen
    if (_currentUser == null) {
      return SignupScreen();
    }

    // If user exists but no role (document might be deleted), treat as new user
    if (_userRole == null) {
      return LoginScreen();
    }

    // Otherwise show appropriate screen based on role
    return _userRole == 'Admin' ? AdminScreen() : MainScreen();
  }
}
