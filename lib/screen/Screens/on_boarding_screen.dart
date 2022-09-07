import 'package:flutter/material.dart';
import 'package:shop_app/screen/Screens/login/shop_login_screen.dart';
import 'package:shop_app/widget/widget_file.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

var boardController = PageController();

List<BoardingModel> boarding = [
  BoardingModel(title: "hi1", image: 'assets/images/onboard_1.jpg', body: "1"),
  BoardingModel(title: "hi2", image: 'assets/images/onboard_1.jpg', body: "1"),
  BoardingModel(title: "hi3", image: 'assets/images/onboard_1.jpg', body: "1")
];

bool isLast = false;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: (){
                Navigator.of(context).pushReplacement(
                             MaterialPageRoute(
                                builder: (BuildContext context) {
                          return ShopLoginScreen();
                        }));
              
            },
             child: Text("SKIP"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    physics: BouncingScrollPhysics(),
                    controller: boardController,
                    itemCount: boarding.length,
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarding[index])),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.deepOrange,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        Navigator.of(context).pushReplacement(
                             MaterialPageRoute(
                                builder: (BuildContext context) {
                          return ShopLoginScreen();
                        }));
                      } else {
                        boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage("${model.image}"),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
