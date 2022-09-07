import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screen/Screens/home/cubit/cubit.dart';
import 'package:shop_app/screen/Screens/home/cubit/states.dart';
import 'package:shop_app/screen/Screens/login/shop_login_screen.dart';
import 'package:shop_app/widget/widget_file.dart';
class SetingScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //var model? = ShopHomeCubit.get(context).userModel;

        nameController.text = ShopHomeCubit.get(context).userModel!.data.name;
        emailController.text = ShopHomeCubit.get(context).userModel!.data.email;
        phoneController.text = ShopHomeCubit.get(context).userModel!.data.phone;

        return ConditionalBuilder(
          condition: ShopHomeCubit.get(context).userModel!= null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }

                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      }

                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }

                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        ShopHomeCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    text: 'update',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return ShopLoginScreen();
              }));
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

    var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();