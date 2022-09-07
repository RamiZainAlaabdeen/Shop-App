import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/Home_model.dart';
import 'package:shop_app/model/Login_model.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/screen/Screens/home/categorie_screen.dart';
import 'package:shop_app/screen/Screens/home/cubit/states.dart';
import 'package:shop_app/screen/Screens/home/favorites_screen.dart';
import 'package:shop_app/screen/Screens/home/home_screen.dart';
import 'package:shop_app/screen/Screens/home/seting_screen.dart';



class ShopHomeCubit extends Cubit<ShopHomeStates> {
  ShopHomeCubit() : super(ShopHomeInitialState());

  static ShopHomeCubit get(context) => BlocProvider.of(context);

  List<Widget> screen=
  [
    HomeScreen(),
    CategorieScreen(),
    FavoritesScreen(),
    SetingScreen(),
  ];

  

  List<BottomNavigationBarItem>item=
  [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "category"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "favorite"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
  ];

  int index=0;
  void selectItem(value)
  {
    index=value;
    emit(ShopHomeSelectState());
  }

  HomeModel? homeModel;

  Map<int,bool> favorites={};
  

  void getHomeData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/home',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorites.addAll
        ({
          element.id:element.inFavorites,
        });


       });
     // print(homeModel!.data);
     print(value.data);  
      
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url:'https://student.valuxapps.com/api/categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print("-----------------------------------");
      print(categoriesModel);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

   ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: 'https://student.valuxapps.com/api/profile',
     // token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
     // printFullText(userModel.data.name);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url:'https://student.valuxapps.com/api/update-profile',
      //token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
     // printFullText(userModel.data.name);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

  
}
