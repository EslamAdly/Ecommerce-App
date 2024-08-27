import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseHelper {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<dynamic> signUp(String email, String password, String name) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser!.updateDisplayName(name);
      await auth.currentUser!.reload();
      if (user.user != null) {
        return user.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "email already used";
      } else if (e.code == 'weak-password') {
        return "password is too weak";
      }
    }
  }

  Future<dynamic> signIn(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user.user != null) {
        return user.user;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /* Future<dynamic>SignInWithGoogle()async{
    try {
      final googleUser=await GoogleSignIn().signIn();
      final googleAuth=await googleUser?.authentication;
      final user =GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,accessToken: googleAuth?.accessToken
      );
      return await auth.signInWithCredential(user);
    }on FirebaseAuthException catch(e){
      print(e.toString());
    }
    return null;
  }
  Future<dynamic>signOut()async{
    await auth.signOut();
  }
*/
  Future<dynamic> SignInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return "Sign-in aborted by user";
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> addFavoriteProduct(
      String productId, Map<String, dynamic> productDetails) async {
    final String userId = auth.currentUser!.uid;
    final DocumentReference userFavoritesRef =
        firestore.collection('Users').doc(userId);

    try {
      await userFavoritesRef.set({
        'products': {productId: productDetails},
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error adding favorite product: $e');
    }
  }

  Future<Map<String, Map<String, dynamic>>> getFavoriteProducts() async {
    final String userId = auth.currentUser!.uid;
    final DocumentReference userFavoritesRef =
        firestore.collection('Users').doc(userId);

    try {
      final DocumentSnapshot docSnapshot = await userFavoritesRef.get();
      if (docSnapshot.exists) {
        return Map<String, Map<String, dynamic>>.from(
            docSnapshot.get('products') ?? {});
      }
    } catch (e) {
      print('Error retrieving favorite products: $e');
    }
    return {};
  }
  Future<void> deleteFavoriteProduct(String productId) async {
    try {
      String userId = auth.currentUser!.uid;
      final DocumentReference userFavoritesRef =
      firestore.collection('Users').doc(userId);

      await userFavoritesRef.update({
        'products.$productId': FieldValue.delete(),
      });
    } catch (e) {
      print("Failed to delete favorite product: $e");
    }
  }

}
