import 'package:ecommerce/services/FireBaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
   SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey=GlobalKey<FormState>();
  Future<void> signUpAction() async {
    emit(SignUpLoading());
    if (formKey.currentState!.validate()) {
      await FireBaseHelper()
          .signUp(emailController.text, passwordController.text, userNameController.text)
          .then((value) {
        if (value is User) {
          emit(SignUpSuccess());
          emailController.clear();
          passwordController.clear();
          userNameController.clear();
        } else {
          emit(SignUpError(value.toString()));
        }
      }).catchError((error) {
        emit(SignUpError(state.toString()));
      });
    }
  }
}
