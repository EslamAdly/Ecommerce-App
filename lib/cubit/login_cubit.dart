import 'package:ecommerce/services/FireBaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final formKey=GlobalKey<FormState>();


  loginWithEmailAction()async{
    emit(LoginLoading());
    if(formKey.currentState!.validate()){
      await FireBaseHelper()
          .signIn(emailController.text,passwordController.text).
      then((value)=>{
        if(value is User)
          {
            emit(LoginSuccess()),
            emailController.clear(),
            passwordController.clear()
          }
        else{
          emit(LoginError(value.toString()))
        }
      });
    }
  }


  loginWithGoogle()async{
    emit(LoginLoading());
    try {
      final user = await FireBaseHelper().SignInWithGoogle();
      if (user is User) {
        emit(LoginSuccess());
      } else {
        emit(LoginError("Google sign-in failed"));
      }
    } catch (error) {
      emit(LoginError(error.toString()));
    }  }
}

