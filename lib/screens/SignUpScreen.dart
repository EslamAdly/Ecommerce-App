import 'package:ecommerce/screens/LoginScreen.dart';
import 'package:ecommerce/screens/OnBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/login_register/CustomButton.dart';
import '../components/login_register/CustomText.dart';
import '../components/login_register/InputTextFormField.dart';
import '../cubit/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: SignUpScreenContent(),
    );
  }
}

class SignUpScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                child: Form(
                  key: context.read<SignUpCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        textTitle: "Sign Up",
                        textBody: "Please enter data to create account",
                      ),
                      const SizedBox(height: 20),
                      InputTextFormField(
                        textController:
                            context.read<SignUpCubit>().userNameController,
                        hintText: "username",
                        errorText: "Please enter your name",
                        icons: Icons.person_outlined,
                      ),
                      InputTextFormField(
                        textController:
                            context.read<SignUpCubit>().emailController,
                        hintText: "email",
                        errorText: "Please enter your email",
                        icons: Icons.mail_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      InputTextFormField(
                        textController:
                            context.read<SignUpCubit>().passwordController,
                        hintText: "password",
                        errorText: "Please enter your password",
                        icons: Icons.lock_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<SignUpCubit, SignUpState>(
                        listener: (context, state) {
                          if (state is SignUpSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Onboarding_screen(),
                              ),
                            );
                          } else if (state is SignUpError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is SignUpLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return CustomButton(
                              text: "Sign Up",
                              onTapAction: () {
                                if (context
                                    .read<SignUpCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  context.read<SignUpCubit>().signUpAction();
                                }
                              },
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
