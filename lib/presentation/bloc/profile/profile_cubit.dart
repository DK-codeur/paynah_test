import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paynah_test/data/model/paynah_user.dart';
import 'package:paynah_test/utils/utils.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileCubit() : super(ProfileInitial());

  Future<void> fetchUserData() async {
    try {
      emit(ProfileLoading());
      final user = _auth.currentUser;

      if (user != null) {
        final docSnapshot = await _firestore.collection('users').doc(user.uid).get();
        if (docSnapshot.exists) {
          final user = PaynahUser.fromJson(docSnapshot.data());
          emit(ProfileLoaded(user));
        } else {
          emit(ProfileError("Aucun information disponible"));
        }
      }
    } catch (e) {
      if(!isClosed) {
        emit(ProfileError(e.toString()));
      }
    }
  }
}
