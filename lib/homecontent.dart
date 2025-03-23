import 'package:carbon_footprint_tracker_by_teamtech_mads/Carousal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black, // Set background color to black
        body: HomeContent1(),
      ),
    );
  }
}


class HomeContent1 extends StatelessWidget {
  HomeContent1({super.key});
  List<String> names = ['1.AK', '2.MURALI', '3.TOKYO', '4.BERLIN', '5.SAKTHI'];
  List<String> avatars = ['assets/ava1.jpeg', 'assets/ava2.jpeg', 'assets/ava2.png', 'assets/ava4.jpeg', 'assets/ava5.jpg'];

  List<Map<String, String>> users = [
    {'name': 'Charlie', 'image': 'assets/people1.jpg'},
    {'name': 'David', 'image': 'assets/people2.jpg'},
    {'name': 'Alice', 'image': 'assets/people3.jpg'},
    {'name': 'Bob', 'image': 'assets/people4.jpg'},
    {'name': 'Emma', 'image': 'assets/people5.jpg'},
    {'name': 'Kennet', 'image': 'assets/people6.webp'},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: (screenWidth/2)-25,
                        height: 300,
                        padding: EdgeInsets.all(10),
                        alignment: Alignment(10, 10),
                        decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(25)),
                        child: SingleChildScrollView(
                          child:

                          Column(

                            children: List.generate(names.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(

                                  children: [
                                    CircleAvatar(radius: 30, backgroundImage: AssetImage(avatars[index])),
                                    SizedBox(width: 10),
                                    Text(
                                      names[index],
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  ],
                                ),
                              );
                            }),

                          ),
                        )
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildImageSlider(['assets/1.png', 'assets/2.png', 'assets/3.png']),
                        SizedBox(height: 20,),
                         buildImageSlider(['assets/11.jpg', 'assets/12.jpg', 'assets/14.jpg']),
                      ],
                    )
                  ]
              ),

              SizedBox(height: 20),

              // Progress Section
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(25)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: 20,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: CircularProgressIndicator(
                              value: 0.88,
                              color: Colors.white,
                              backgroundColor: Colors.black,
                              strokeWidth:15,
                            ),
                          ),
                          Text(
                            "88%",
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: Text(
                        "PROGRESS!!!!\nTHERE IS NO TOMORROW!!\nONLY TODAY",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold,fontStyle: FontStyle.normal,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              CarouselScreen(),
              SizedBox(height: 20,),
              Container(child: Text("\t\t \t \t \t PEOPLES YOU REFERRED",style: TextStyle(color: Colors.orange,fontSize: 23,fontWeight: FontWeight.bold),),
                width: 400,height: 60,color: Colors.black,),
              SizedBox(height: 0,),

              Container(
                width: double.infinity,
                height:250,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(25)),
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.8, // Adjust for better spacing
                  ),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(users[index]['image']!),
                        ),
                        SizedBox(height: 8),
                        Text(
                          users[index]['name']!,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.orange),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height:220,
                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(25),
                image:DecorationImage(image: AssetImage("assets/reduction_tech2.jpg")) ),

              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height:379,
                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(25),
                    image:DecorationImage(image: AssetImage("assets/reduction_tech.jpg")) ),

              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height:301,
                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(25),
                    image:DecorationImage(image: AssetImage("assets/graph.png")) ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageSlider(List<String> images) {
    final PageController _pageController = PageController();
    // final List<String> images = ['assets/1.png', 'assets/2.png', 'assets/3.png'];

    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 180,
              height: 140,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: PageView(
                  controller: _pageController,
                  children: images.map((imagePath) {
                    return Image.asset(imagePath, width: 210, height: 130, fit: BoxFit.cover);
                  }).toList(),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(width: 175, height: 120,),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: images.length,
                  effect: ExpandingDotsEffect(dotHeight: 8, dotWidth: 8, activeDotColor: Colors.white, dotColor: Colors.grey),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}