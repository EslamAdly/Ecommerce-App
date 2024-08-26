import 'package:ecommerce/components/login_register/InputTextFormField.dart';
import 'package:ecommerce/cubit/login_cubit.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/login_register/CustomButton.dart';
import '../components/login_register/CustomText.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: LoginScreenContent(),
    );
  }
}

class LoginScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
                child: Form(
                  key: context.read<LoginCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomText(
                        textTitle: "Welcome",
                        textBody: "Please Enter your data to continue",
                      ),
                      const SizedBox(height: 40),
                      // Email input field
                      InputTextFormField(
                        textController: context.read<LoginCubit>().emailController,
                        hintText: "Please enter your email",
                        errorText: "Enter valid email",
                        icons: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      // Password input field
                      InputTextFormField(
                        textController: context.read<LoginCubit>().passwordController,
                        hintText: "Password",
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
                      const SizedBox(height: 15),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                            );
                          } else if (state is LoginError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const CircularProgressIndicator();
                          } else {
                            return CustomButton(
                              text: "Login",
                              onTapAction: () {
                                if (context.read<LoginCubit>().formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().loginWithEmailAction();
                                }
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 15),
                      // Google Sign-In Button
                      ElevatedButton.icon(
                        onPressed: () => context.read<LoginCubit>().loginWithGoogle(),
                        icon: Image.asset(
                          'assets/images/img.png',
                          height: 24.0,
                          width: 24.0,
                        ),
                        label: const Text(
                          "Login with Google",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
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
