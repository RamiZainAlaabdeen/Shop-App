import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/screen/Screens/home/cubit/cubit.dart';
import 'package:shop_app/screen/Screens/home/cubit/states.dart';
class CategorieScreen extends StatelessWidget {
  const CategorieScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(ShopHomeCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (context, index) => Divider(height: 20,color:Colors.lightBlue ,),
          itemCount: ShopHomeCubit.get(context).categoriesModel!.data.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage(model.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
  