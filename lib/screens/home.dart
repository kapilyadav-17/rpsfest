import 'package:flutter/material.dart';
import 'package:rpsfest/screens/profilepage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  //Home({required this.navigatorKey});

  //final GlobalKey navigatorKey;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = "Kapil yadav";
  String remainingPart = "The winner participant will get prize and remaining particiapnt will get a national authorized certificate";
  var buttonString = "Read More";
  final List<String> imgList = [
    'https://www.xda-developers.com/files/2018/12/Flutter-1.0.png',
    'https://programmer.group/images/article/d0c833764751b7276583783c75e2b5ba.jpg',
    'https://www.xda-developers.com/files/2018/12/Flutter-1.0.png'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white12,
        elevation: 0.0,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Hi $name !",
                style: GoogleFonts.lato(
                    fontStyle: FontStyle.italic,
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 12),
              child: CarouselSlider.builder(
                itemCount: imgList.length,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  height: 200,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  reverse: false,
                  aspectRatio: 5.0,
                ),
                itemBuilder: (context, i, id) {
                  //for onTap to redirect to another screen
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blue, width: 1)),
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
                    onTap: () {
                      var url = imgList[i];
                      print(url.toString());
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text("Check out our social media handles",
                  style: GoogleFonts.lato(
                      fontSize: 25.0, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 45,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "lib/images/facebook.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      width: 55,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "lib/images/youtube.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      width: 55,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "lib/images/insta.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 45,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "lib/images/twitter.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      width: 55,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "lib/images/whatsapp.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      width: 55,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "lib/images/linkedin.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "About Rpsfest -",
                style: GoogleFonts.lato(
                    fontSize: 25.0, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 8.0),
              child: Text(
                "Rpsfest is competition program in college, so students can participate in this fest and can check their ability and skill.",
                style: GoogleFonts.lato(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: TextButton(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  setState(() {
                    buttonString = remainingPart;
                  });
                },
                child: Text(
                  buttonString,
                  style: GoogleFonts.lato(fontSize: 20),
                ),
              ),
            ),
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
                    border: Border.all(color: Colors.black)),
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
              title: Text('Log out',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
              leading: Icon(Icons.logout),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
