import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(AuthInitial()) {
    _checkUserAuthentication();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<void> _checkUserAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    if (token != null && _firebaseAuth.currentUser != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signUp(String email, String password, {String? lName, String? fName}) async {
    try {
      emit(AuthLoading());
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _saveToken(userCredential.user);
      await _saveUserData(userCredential.user, email: email, lName: lName, fName: fName);
      emit(AuthAuthenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Une erreur technique s\'est produite'));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await _saveToken(userCredential.user);
      emit(AuthAuthenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Une erreur technique s\'est produite'));
    }
  }

  Future<void> _saveUserData(User? user, {String? lName, String? fName, String? email}) async {
    if (user != null) {
      // await _firestore.collection('users').add({
      //   'uuid': user.uid,
      //   'l_name': lName,
      //   'f_name': fName,
      //   'email': email
      // });
      _firestore.collection("users")
        .doc(user.uid)
        .set({
        'uuid': user.uid,
        'l_name': lName,
        'f_name': fName,
        'email': email
      });
    }
  }

  Future<void> _saveToken(User? user) async {
    if (user != null) {
      final token = await user.getIdToken(); 
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', "$token");
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    emit(AuthUnauthenticated());
  }
}
