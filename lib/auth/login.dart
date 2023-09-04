import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/auth/signUp.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/components/constants.dart';
import 'package:shopapp/cubit/loginCubit.dart';
import 'package:shopapp/layout/shopLayout.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/states/loginStates.dart';
import 'package:shopapp/style/colors.dart';
import 'package:shopapp/style/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppLoginCubit(),
        child: BlocConsumer<AppLoginCubit, AppLoginStates>(
          listener: (BuildContext context, AppLoginStates state) {
            if (state is AppLoginSuccessState) {
              if (state.loginModel.status) {
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data?.token)
                    .then((value) {
                  token = state.loginModel.data!.token;
                  navigateAndfinished(context, const ShopLayout());
                });
              } else {
                messanger(
                    context: context,
                    message: state.loginModel.massage,
                    status: false);
              }
            }
          },
          builder: (BuildContext context, AppLoginStates state) {
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
                          const Text('LOGIN',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              )),
                          Text('Login now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 80,
                          ),

                          // Email Input

                          defaultForm(
                            validate: true,
                            validationMessage: 'The Eamil is required',
                            controller: emailController,
                            label: 'Email',
                            prefixIcon: IconlyBroken.message,
                            type: TextInputType.emailAddress,
                            suffixIconPressed: () {},
                          ),

                          verticalSpacing,

                          // password Input
                          defaultForm(
                              controller: passwordController,
                              isPassword: AppLoginCubit.get(context).isPassword,
                              validationMessage: 'The password is required',
                              validate: true,
                              type: TextInputType.visiblePassword,
                              prefixIcon: IconlyBroken.lock,
                              sufixIcon: AppLoginCubit.get(context).suffixIcon,
                              label: 'Password',
                              suffixIconPressed: () =>
                                  AppLoginCubit.get(context)
                                      .changePasswordVisibility()),
                          const SizedBox(
                            height: 50,
                          ),

                          //LOGIN Button

                          ConditionalBuilder(
                              condition: state is! AppLoginLoadingState,
                              builder: (context) => defaultButton(
                                  label: 'Login',
                                  width: double.infinity,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      AppLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  }),
                              fallback: (context) {
                                return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
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
                                'Don\'t have an account ? ',
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, const SignUp());
                                  },
                                  child: const Text(
                                    'Sign Up',
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
        ));
  }
}
