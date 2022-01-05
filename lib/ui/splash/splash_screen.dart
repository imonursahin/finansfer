import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:finansfer/ui/home/home_page.dart';
import 'package:finansfer/ui/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      navigate();
    });
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
            child: Container(
                decoration: BoxDecoration(color: AppColors.mainColor),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage(
                            'assets/appicon.png',
                          ),
                          width: 150.0,
                          height: 150.0),
                      SizedBox(height: 12.0),
                      Text(
                        "Finansfer",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFf0b90b),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        color: Color(0xFF323c45),
                        indent: 150,
                        endIndent: 150,
                        thickness: 1.3,
                      ),
                      Text(
                        "kişisel finans yönetim uygulaması",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFf1c740),
                          fontWeight: FontWeight.w100,
                        ),
                      )
                    ]))));
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //await _initializeFirebase();
    if ((preferences.getBool("isVerified") ?? false)) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }
}
