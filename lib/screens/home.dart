

import 'package:flutter/material.dart';
import 'package:rpsfest/screens/profilepage.dart';
import 'package:carousel_slider/carousel_slider.dart';
class Home extends StatefulWidget {
  //Home({required this.navigatorKey});


  //final GlobalKey navigatorKey;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> imgList =['https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png',
                                'https://programmer.group/images/article/d0c833764751b7276583783c75e2b5ba.jpg',
                                'https://www.xda-developers.com/files/2018/12/Flutter-1.0.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProfilePage.routeName);
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [ Container(
            margin: EdgeInsets.all(15),
            child: CarouselSlider.builder(
              itemCount: imgList.length,
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 100,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,
                aspectRatio: 5.0,
              ),
              itemBuilder: (context, i, id){
                //for onTap to redirect to another screen
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black,width: 5)

                    ),
                    //ClipRRect for image border radius
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        imgList[i],
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: (){
                    var url = imgList[i];
                    print(url.toString());
                  },
                );
              },
            ),
          ),
            Text('About '),
            //Stack(),
            SizedBox(height: 10,),
            Text('Meet our Team'),
            //gridview

          ],
        ),
      ),
      drawer: Drawer(
        elevation: 20.0,
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black)

                ),
                //ClipRRect for image border radius
                child: Image(
                  image: AssetImage('lib/images/tflogo.jpeg'),
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              decoration: BoxDecoration(color: Colors.black87),
            ),

            ListTile(
              title: Text('Help and Support',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              leading: Icon(Icons.help_center),
              onTap: () {

              },
            ),

          ],
        ),
      ),
    );
  }
}
