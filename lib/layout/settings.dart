import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/components/constants.dart';
import 'package:shopapp/cubit/homeCubit.dart';
import 'package:shopapp/states/homeStates.dart';
import 'package:shopapp/style/colors.dart';
import 'package:shopapp/style/const.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var userPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel;
        if (model != null) {
          userNameController.text = model.data!.name;
          userEmailController.text = model.data!.email;
          userPhoneController.text = model.data!.phone;
        }
        return ConditionalBuilder(
          condition: HomeCubit.get(context).userModel != null,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultForm(
                        controller: userNameController,
                        type: TextInputType.name,
                        prefixIcon: IconlyBroken.profile,
                        label: 'Personal Name',
                        validationMessage: 'The Personal Name is required',
                        validate: true,
                        suffixIconPressed: () {}),
                    verticalSpacing,
                    defaultForm(
                        controller: userEmailController,
                        type: TextInputType.emailAddress,
                        prefixIcon: IconlyBroken.message,
                        label: 'Email Address',
                        validationMessage: 'The Email Address is required',
                        validate: true,
                        suffixIconPressed: () {}),
                    verticalSpacing,
                    defaultForm(
                        controller: userPhoneController,
                        type: TextInputType.phone,
                        prefixIcon: IconlyBroken.call,
                        label: 'Phone Number',
                        validate: true,
                        validationMessage: 'The Phone Number is required',
                        suffixIconPressed: () {}),
                    verticalSpacing,
                    verticalSpacing,
                    ConditionalBuilder(
                      condition: state is! UpdateProfileLoadingState,
                      builder: (BuildContext context) => defaultButton(
                          width: double.infinity,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              HomeCubit.get(context).updateProfile(
                                  name: userNameController.text,
                                  email: userEmailController.text,
                                  phone: userPhoneController.text,
                                  context: context);
                            }
                          },
                          label: 'Update'),
                      fallback: (BuildContext context) {
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
                      },
                    ),
                    verticalSpacing,
                    verticalSpacing,
                    defaultButton(
                        width: double.infinity,
                        function: () {
                          signOut(context);
                        },
                        label: 'LOGOUT',
                        buttonColor: Colors.redAccent)
                  ],
                ),
              ),
            ),
          ),
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ),
        );
      },
    ));
  }
}
