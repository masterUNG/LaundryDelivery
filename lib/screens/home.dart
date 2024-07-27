import 'package:flutter/material.dart';
import 'package:testdb/screens/register.dart';
import 'package:testdb/screens/notificationscreen.dart';
import 'package:testdb/screens/otp.dart';
import 'package:testdb/screens/profile.dart';
class Home extends StatelessWidget {

  
  List catNames = [
  "เลือกใช้รายการ",
  "ตรวจสอบราคา",
  "ประวัติการสั่งซัก",
  "ตั้งค่า",
  'ประกาศ'

];

List<Color> catColors = [

Color.fromARGB(0, 14, 236, 136),
Color.fromARGB(0, 172, 227, 7),
Color.fromARGB(0, 65, 248, 14),
Color.fromARGB(0, 4, 4, 235),
Color.fromARGB(0, 212, 239, 9),

];

List<Icon>catIcons = [
  Icon(Icons.category,color: Color.fromARGB(255, 100, 100, 232),size: 30),
  Icon(Icons.video_library,color: const Color.fromARGB(255, 129, 120, 236),size: 30),
  Icon(Icons.assignment,color: const Color.fromARGB(255, 129, 120, 236),size: 30),
  Icon(Icons.store,color: const Color.fromARGB(255, 129, 120, 236),size: 30),
  Icon(Icons.category,color: const Color.fromARGB(255, 129, 120, 236),size: 30),
];


List imgList = [
  'Login',
  'few',
  'kkk',
  'kll',
  'lkj',
];

int currentIndex =0;
  List Widgetoption = [
    (),
    Register(),
    Otp(),
    Profile(),
    
  ];

  

  @override
  int mcurrenIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView(
        children: [
          Container(
              padding: EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 50, 50, 62),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.dashboard,
                size: 30,
                color: Color.fromARGB(255, 228, 230, 228),
                ),
                Icon(
                  Icons.notifications,
                  size: 30,
                  color: Color.fromARGB(255, 245, 241, 241)
                ),

              ],
            ),
            SizedBox(
              height: 20
            ),
            Padding(padding: EdgeInsets.only(left: 3,bottom: 15),
            child: Text("HI ร้านซักรีด",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              wordSpacing: 2,
              color: Color.fromARGB(255, 238, 239, 228)
            ),
            ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5,bottom: 20),
              width: MediaQuery.of(context).size.width,
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 241, 239, 239),
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "NAME",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5)
                  ),
                  
                  prefixIcon: Icon(
                    Icons.person,
                    size: 25,
                     
                  )
                ),
              ),
            )

          ],
        ),



          ),
          Padding(
            padding: EdgeInsets.only(top: 20,right: 15,left: 15),
          child: Column(
            children: [
              GridView.builder(
                itemCount: catNames.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                ),
              
                itemBuilder: (context,index) {
                  return Column(
                    children: [
                      Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: catColors[index],
                        shape: BoxShape.circle,

                      ),
                      child: Center(
                        child: catIcons[index],
                      ),


                    ),
                    SizedBox(height: 10),
                    Text(
                      catNames[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 28, 6, 6).withOpacity(0.7),
                      ),
                    ),
                    ],
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ประกาศ",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "ดูทั้งหมด",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10),
              GridView.builder(
                itemCount: imgList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (MediaQuery.of(context).size.height-50-25)/(4*240),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen(),
                        ));
                      },
                      
                      child: Container(
                        padding:EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(180, 103, 87, 223)
                        ),
                      
                         ),
                    );
                  }

              ), 

            ],
          ),
          )
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap:(int index){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile())
          
          
          );
         
          
        
        },
        iconSize: 32,
        selectedItemColor: Color(0xff674aef),
        selectedFontSize: 18,
        unselectedItemColor: Colors.grey,
        items:const[
          
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment),label:'few '),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),label:'แจ้งเตือน'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label:'ข้อมูลส่วนตัว'),
          
       
          
    

      ],
     
     
      ),
   

    );
  }
}
