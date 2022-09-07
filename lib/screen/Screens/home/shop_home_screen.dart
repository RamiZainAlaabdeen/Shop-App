import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screen/Screens/home/cubit/cubit.dart';
import 'package:shop_app/screen/Screens/home/cubit/states.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopHomeCubit()..getHomeData()..getCategories(),
      child: BlocConsumer<ShopHomeCubit, ShopHomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Shop App"),
              actions: [],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: ShopHomeCubit.get(context).item,
              currentIndex:ShopHomeCubit.get(context).index ,
              onTap: (index){
                ShopHomeCubit.get(context).selectItem(index);
              },
              
            ),
            body:ShopHomeCubit.get(context).screen[ShopHomeCubit.get(context).index],
          );
        },
      ),
    );
  }
}
