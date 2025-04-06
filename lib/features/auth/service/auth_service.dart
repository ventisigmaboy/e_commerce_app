import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up Method
  Future<String?> signUp({
    required String name,
    required String password,
    required String email,
    required String role,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email.trim(),
          'role': role,
          'createdAt': DateTime.now(),
        });
        return "Success"; // Return success message
      }
      return "User creation failed"; // Return error message if user is null
    } catch (e) {
      return e.toString(); // Return Firebase error message
    }
  }

  // Login Method
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = userCredential.user;
      return user;
    } catch (e) {
      return null; // Return null if login fails
    }
  }

  Future<Map<String, dynamic>?> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();
      return userDoc.exists ? userDoc.data() as Map<String, dynamic>? : null;
    } catch (e) {
      print("Error fetching user role: $e");
      return null;
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // First delete the user document
        await _firestore.collection('users').doc(user.uid).delete();
        // Then delete the auth account
        await user.delete();
      }
    } catch (e) {
      print("Error deleting account: $e");
      rethrow;
    }
  }

  // Logout Method
  Future<void> logout() async {
    await _auth.signOut();
  }
}
