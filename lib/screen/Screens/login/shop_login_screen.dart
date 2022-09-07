import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screen/Screens/home/shop_home_screen.dart';
import 'package:shop_app/screen/Screens/login/cubit/states.dart';
import 'package:shop_app/screen/Screens/shop_register_screen.dart';
import 'package:shop_app/widget/widget_file.dart';

import 'cubit/cubit.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return ShopHomeScreen();
              }));
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 10,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            

          }
/*
          else
            {
               Fluttertoast.showToast(
                  msg: "incroct user name or password",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
*/
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField2(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          ShopLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'password is too short';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                        condition: state is! ShopLoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(context, ShopRegisterScreen());
                            },
                            text: 'register',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
