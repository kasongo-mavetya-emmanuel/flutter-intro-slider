import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class IntroSlider extends StatefulWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  PageController _controller=PageController();

  bool isLastPage=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: PageView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index){
                  setState(() {
                    //2 is our last page starting from 0
                    isLastPage=index==2;
                  });
                },
                children: [
                  //One page layout
                  BuildIntroPage(
                    img: 'assets/img_1.jpg',
                    title: 'Page One', 
                    description: 'After peeling the strawberries, '
                        'soak lettuce, pumpkin seeds and '
                        'worcestershire sauce with it in a soup pot The justice of '
                        'yearning powers is prime..',
                  ),

                  BuildIntroPage(
                    img: 'assets/img_2.jpg',
                    title: 'Page Two',
                    description: 'After peeling the strawberries, '
                        'soak lettuce, pumpkin seeds and '
                        'worcestershire sauce with it in a soup pot The justice of '
                        'yearning powers is prime..',
                  ),

                  BuildIntroPage(
                    img: 'assets/img_2.jpg',
                    title: 'Page Three',
                    description: 'After peeling the strawberries, '
                        'soak lettuce, pumpkin seeds and '
                        'worcestershire sauce with it in a soup pot The justice of '
                        'yearning powers is prime..',
                  ),
                ],
              )),
          SizedBox(height: 15,),
          Center(
              child: SmoothPageIndicator(
                  controller: _controller, count: 3,
                onDotClicked: (index){
                   _controller.animateToPage(index,
                       duration: Duration(milliseconds: 500),
                       curve: Curves.easeIn);
                },
                effect: ExpandingDotsEffect(
                  activeDotColor: Theme.of(context).primaryColor,
                  dotHeight: 7.0,
                  dotWidth: 7.0,
                  dotColor: Colors.black12
                ),
              ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),

              ),
                onPressed: isLastPage?(){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Scaffold(
                    body: Center(
                      child: Text('Home Page'),
                    ),
                  );
                }));
                }:(){
                  _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                },
                child:Text(isLastPage?'Done':'Next',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
          ),
          TextButton(
              onPressed: (){
                _controller.jumpToPage(2);
              },
              child: Text('Skip',style: TextStyle(fontSize: 18,color: Colors.black),)),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
}

class BuildIntroPage extends StatelessWidget {
  String title;
  String img;
  String description;
   BuildIntroPage({
    super.key,
     required this.title,
     required this.description,
     required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                image: DecorationImage(
                    image: AssetImage(img),
                  fit: BoxFit.cover,
                ),
              ),
            )),
        SizedBox(
          height: 40,
        ),
        Text(title,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36),),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16,color: Colors.black87),),
        ),
        SizedBox(height: 20,),
        
      ],
    );
  }
}
