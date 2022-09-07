
import 'package:shop_app/model/Login_model.dart';

abstract class ShopHomeStates {}

class ShopHomeInitialState extends ShopHomeStates {}

class ShopHomeSelectState extends ShopHomeStates{}

class ShopHomeLoadingState extends ShopHomeStates {}

class ShopHomeSuccessState extends ShopHomeStates{}

class ShopHomeErrorState extends ShopHomeStates{}

class ShopSuccessCategoriesState extends ShopHomeStates{}

class ShopErrorCategoriesState extends ShopHomeStates{}

class ShopLoadingUserDataState extends ShopHomeStates{}

class ShopSuccessUserDataState extends ShopHomeStates{
  ShopSuccessUserDataState(ShopLoginModel shopLoginModel);
 
}

class ShopErrorUserDataState extends ShopHomeStates{}

class ShopLoadingUpdateUserState extends ShopHomeStates {}

class ShopSuccessUpdateUserState extends ShopHomeStates
{
  final ShopLoginModel? loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopHomeStates {}




//class ShopChangePasswordVisibilityState extends ShopHomeStates {}
