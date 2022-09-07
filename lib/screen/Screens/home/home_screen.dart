
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/Home_model.dart';
import 'package:shop_app/screen/Screens/home/cubit/cubit.dart';
import 'package:shop_app/screen/Screens/home/cubit/states.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      listener: (context, state) {
        //print(ShopHomeCubit.get(context).homeModel!.data.products);
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition:ShopHomeCubit.get(context).homeModel!=null,
          builder: (context) =>builderWidget(ShopHomeCubit.get(context).homeModel!),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget builderWidget(
          HomeModel ?model) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.70,
              children: 
              List.generate(model.data.products.length, (index)=>buildGridProduct(model.data.products[index])))
          ],
        ),
      );

  Widget buildGridProduct(Product model) => 
       Container(
         child: Column(
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.fill,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
                          style: TextStyle(
                            fontSize: 12.0,
                           //color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice.round()}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                           print(model.id);
                          },
                          icon: CircleAvatar(
//backgroundColor: Colors.black,
                            radius: 15.0,
                            child: Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
       );

