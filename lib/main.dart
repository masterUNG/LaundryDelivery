import 'package:flutter/material.dart';
import 'package:testdb/register.dart';
import 'package:testdb/screens/HOME.dart';
import 'package:testdb/screens/forget.dart';


void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: login_page(),
    );
  }
}


class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  late Color mycolor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

  

  @override
  Widget build(BuildContext context) {
    mycolor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: mycolor,
        image: DecorationImage(image: const AssetImage("assets/images/Login.png"),
        fit: BoxFit.cover,
        colorFilter:ColorFilter.mode(mycolor.withOpacity(0.2), BlendMode.dstATop)

        
        ),
        
      ),
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(children: [
          Positioned(top: 80,child: _buildTop()),
          Positioned(bottom: 0,child: _buildBottom(), )

        ],),
      ),
    );
  }

  Widget _buildTop(){
    return SizedBox(
      width: mediaSize.width,
      child:  const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.water_drop_sharp,
          size: 100,
          color: Color.fromARGB(255, 244, 231, 231),
          ),
          Text("",style: TextStyle(
            color: Color.fromARGB(31, 18, 1, 1),
            fontWeight: FontWeight.bold,
            fontSize: 40,
            letterSpacing: 5
          ),)

        ],
      ),
    );


  }
  Widget _buildBottom(){
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),

          )
        ),
        child:  Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );

  }
  Widget _buildForm(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ซักรีดออนไลน์",style: TextStyle(
          color: mycolor,
          fontSize: 32,
          fontWeight: FontWeight.w500
        ),
        ),
        Text("Please Login with your in fromation"),
        const SizedBox(height: 60),
        _buildGreyText("Email Address"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Password"),
        _buildInputField(passwordController,isPassword: true),
        const SizedBox(height:30 ),
        _buildRememberForget(),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }
  Widget _buildGreyText(String text){
    return Text(
      text,
      style: const TextStyle(color: Color.fromARGB(255, 44, 16, 99)),
    );
  }
  Widget _buildInputField(TextEditingController controller,{isPassword = false}){
    return TextField(
      controller: controller,
      decoration:  InputDecoration(
        suffixIcon: isPassword?Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText:  isPassword,


    );

  }
  Widget _buildRememberForget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Row(
        children: [Checkbox(value: rememberUser, onChanged: (value){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
            
          });
        


        }),
        
        _buildGreyText("สมัครสมาชิก"),


        ],
      ),
      TextButton(onPressed: (){
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Forget(),));
          
        });
      }, child: _buildGreyText("ลืมรหัสผ่าน")),
      
      
      
      
      ],
      

    );
  }
  Widget _buildLoginButton(){
    return ElevatedButton(
      onPressed: (){
        debugPrint("Email :${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
        });
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: mycolor,
        minimumSize:  const Size.fromHeight(60),
      ),

     child: 
    const Text("LOGIN"),
    );
  }
  Widget _buildOtherLogin(){
    return Center(
      child: Column(
        children: [
          _buildGreyText(""),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(
                icon:Image.asset("assets/images/Login.png"),
              )
            ],
          )
        ],
      ),
    );
  }
}
