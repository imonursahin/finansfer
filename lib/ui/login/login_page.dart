import 'package:finansfer/core/network/di/database.dart';
import 'package:finansfer/core/network/models/request/user_req.dart';
import 'package:finansfer/core/util/mail_service.dart';
import 'package:finansfer/core/util/theme/app_colors.dart';
import 'package:finansfer/core/util/verification_service.dart';
import 'package:finansfer/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? auCodeController;

  MailService? _mailService;
  VerificationService? _verificationService;

  String? emailErrorText;
  String? auErrorText;
  String? randomNumber;

  @override
  void initState() {
    super.initState();

    emailController = new TextEditingController();
    auCodeController = new TextEditingController();
    _mailService = new MailService();
    _verificationService = new VerificationService();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(color: AppColors.mainColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              "Giriş yapmak için mail adresinizi yazın.",
              style: TextStyle(
                fontSize: 20,
                color: AppColors.brightOrange,
                fontWeight: FontWeight.w100,
              ),
            ),
            SizedBox(height: 75.0),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: emailController,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    errorText: emailErrorText,
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    labelText: 'Mail Adresiniz',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(height: 75.0),
            MaterialButton(
              height: 40.0,
              minWidth: 150.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () {
                if (emailController!.text == "") {
                  setState(() {
                    emailErrorText = "Email boş olamaz.";
                  });
                  return;
                }
                if (!isEmail(emailController!.text)) {
                  setState(() {
                    emailErrorText = "Geçerli bir email giriniz.";
                  });
                  return;
                }
                randomNumber = _verificationService!.get6DigitNumber();
                _mailService!
                    .sendMail(emailController!.text, randomNumber ?? "");
                showVerificationDialog();
                setState(() {});
              },
              padding: EdgeInsets.all(12),
              color: AppColors.btnOrange,
              child: Text('Giriş Yap', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void showVerificationDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            backgroundColor: Color(0xFF29313c),
            elevation: 25,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            actions: <Widget>[
              Container(
                width: 180.0,
                child: TextField(
                  autofocus: true,
                  controller: auCodeController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      counterStyle: TextStyle(
                        height: double.minPositive,
                      ),
                      errorText: auErrorText,
                      counterText: "",
                      labelText: 'Doğrulama Kodu',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      )),
                ),
              ),
              SizedBox(height: 20.0),
              MaterialButton(
                height: 40.0,
                minWidth: 100.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  if (auCodeController!.text == "") {
                    setState(() {
                      auErrorText = "Lütfen doğrulama kodunu giriniz.";
                    });
                    return;
                  }
                  verifyCode();
                },
                padding: EdgeInsets.all(12),
                color: AppColors.btnOrange,
                child: Text('Doğrula', style: TextStyle(color: Colors.white)),
              ),
            ]);
      },
    );
  }

  verifyCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (auCodeController?.text == randomNumber) {
      var isUserExist =
          await Database.isUserExist(UserReq(email: emailController?.text));
      if (!isUserExist) {
        await Database.addUser(UserReq(email: emailController?.text));
      }
      preferences.setBool("isVerified", true);
      preferences.setString("userEmail", emailController!.text);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      return;
    }
  }
}
