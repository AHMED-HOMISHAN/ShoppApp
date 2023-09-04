// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/auth/login.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/components/constants.dart';
import 'package:shopapp/cubit/signUpCubit.dart';
import 'package:shopapp/layout/shopLayout.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/states/signUpStates.dart';
import 'package:shopapp/style/colors.dart';
import 'package:shopapp/style/const.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSignUpCubit(),
      child: BlocConsumer<AppSignUpCubit, AppSignUpStates>(
        listener: (context, state) {
          if (state is AppSignUpSuccessState) {
            if (state.SignUpModel.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.SignUpModel.data?.token)
                  .then((value) {
                token = state.SignUpModel.data!.token;
                navigateAndfinished(context, const ShopLayout());
              });
            } else {
              messanger(
                  context: context,
                  message: state.SignUpModel.massage,
                  status: false);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sign Up',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                        Text('Sign Up now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 80,
                        ),

                        // Name Input

                        defaultForm(
                          validate: true,
                          validationMessage: 'The Name is required',
                          controller: nameController,
                          label: 'Personal Name',
                          prefixIcon: IconlyBroken.profile,
                          type: TextInputType.name,
                          suffixIconPressed: () {},
                        ),
                        verticalSpacing,
                        // Email Input

                        defaultForm(
                          validate: true,
                          validationMessage: 'The Eamil is required',
                          controller: emailController,
                          label: 'Email',
                          prefixIcon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          suffixIconPressed: () {},
                        ),

                        verticalSpacing,

                        // Phone Input

                        defaultForm(
                          validate: true,
                          validationMessage: 'The Phone is required',
                          controller: emailController,
                          label: 'Phone Number',
                          prefixIcon: IconlyBroken.call,
                          type: TextInputType.phone,
                          suffixIconPressed: () {},
                        ),

                        verticalSpacing,

                        // password Input
                        defaultForm(
                            controller: passwordController,
                            isPassword: AppSignUpCubit.get(context).isPassword,
                            validationMessage: 'The password is required',
                            validate: true,
                            type: TextInputType.visiblePassword,
                            prefixIcon: IconlyBroken.lock,
                            sufixIcon: AppSignUpCubit.get(context).suffixIcon,
                            label: 'Password',
                            suffixIconPressed: () => AppSignUpCubit.get(context)
                                .changePasswordVisibility()),
                        const SizedBox(
                          height: 50,
                        ),

                        //Sign UP Button

                        ConditionalBuilder(
                            condition: state is! AppSignUpLoadingState,
                            builder: (context) => defaultButton(
                                label: 'Sign Up',
                                width: double.infinity,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    AppSignUpCubit.get(context).userSignUp(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                }),
                            fallback: (context) {
                              return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    ),
                                  ));
                            }),
                        verticalSpacing,

                        //SIGN UP Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'You have an account ? ',
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, const ShopLoginScreen());
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: primaryColorAccent),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
