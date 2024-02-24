import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {

    super.initState();
    controller = AnimationController(duration:
    const Duration(seconds:3),vsync: this, upperBound: 1.0);

   animation =ColorTween(begin: Colors.amberAccent, end: Colors.cyanAccent).animate(controller);

    //   animation = CurvedAnimation(
    //   parent: controller,
    //   curve: Curves.decelerate,
    //   reverseCurve: Curves.easeOut,
    // );

    controller.forward();
    controller.addListener(() {
      setState(() {

      });print(animation.value);});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                    animatedTexts:
                    [TypewriterAnimatedText(
                   'Flash Chat',textStyle: const TextStyle(fontSize: 45.0,fontWeight: FontWeight.w900) ),
                       ],),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(color: Colors.lightBlueAccent, title: "Log In", onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
            },),
            RoundedButton(color: Colors.blueAccent, title: "Register", onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen(),),);
            },),
          ],
        ),
      ),
    );
  }
}
