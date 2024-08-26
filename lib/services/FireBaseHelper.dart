import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseHelper{
  FirebaseAuth auth =FirebaseAuth.instance;
  Future<dynamic>signUp(String email,String password,String name)async{
      try {
        UserCredential user=await auth.createUserWithEmailAndPassword(email: email, password: password);
        await auth.currentUser!.updateDisplayName(name);
        await auth.currentUser!.reload();
        if(user.user != null){
          return user.user;
        }
      }on FirebaseAuthException catch(e){
        if(e.code=='email-already-in-use'){
          return "email already used";
        }
        else if(e.code=='weak-password'){
          return "password is too weak";
        }
      }
  }
  Future<dynamic>signIn(String email,String password)async{
    try{
      UserCredential user=await auth.signInWithEmailAndPassword(email: email, password: password);
      if(user.user!=null){
        return user.user;
      }
    }on FirebaseAuthException catch(e){
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
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      UserCredential userCredential = await auth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}