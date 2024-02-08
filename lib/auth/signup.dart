import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixfyapp/component/custombutton.dart';
import 'package:pixfyapp/component/customlogoauth.dart';
import 'package:pixfyapp/component/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController con_password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool abc = true;
  bool abcd = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                  ),
                  CustomLogo(),
                  Container(
                    height: 20,
                  ),
                  Text(
                    "SignUp",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Lato'),
                  ),
                  Container(
                    height: 5,
                  ),
                  Text(
                    "Enter your personal information",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                        fontSize: 17),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    "User Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  CustomTextForm(
                    hinttext: "Enter your username",
                    mycontroller: username,
                    validator: (val) {
                      if (val == "") {
                        return "Please fill the fields";
                      }
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    height: 6,
                  ),
                  CustomTextForm(
                    hinttext: "Enter your email",
                    mycontroller: email,
                    validator: (val) {
                      if (val == "") {
                        return "Please fill the fields";
                      }
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    height: 6,
                  ),
                  TextFormField(
                    obscureText: abc,
                    validator: (val) {
                      if (val == "") {
                        return "Please fill the fields";
                      }
                    },
                    controller: password,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              abc = !abc;
                            });
                          },
                          child: Icon(
                              abc ? Icons.visibility : Icons.visibility_off),
                        ),
                        hintText: "Enter your password",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        filled: true,
                        fillColor: Color(0xFFededed),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFc3cbcd))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFc3cbcd)))),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Confirm password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Container(
                    height: 6,
                  ),
                  TextFormField(
                    obscureText: abcd,
                    validator: (val) {
                      if (password.text != con_password.text) {
                        return "Password don't match";
                      }
                    },
                    controller: con_password,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              abcd = !abcd;
                            });
                          },
                          child: Icon(
                              abc ? Icons.visibility : Icons.visibility_off),
                        ),
                        hintText: "Enter Confirm password",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        filled: true,
                        fillColor: Color(0xFFededed),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFc3cbcd))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Color(0xFFc3cbcd)))),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
            ),
            CustomButton(
                hinttext: "SignUp",
                onPressed: () async {
                  if (formstate.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      await FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Warning',
                        desc: 'Please Verify Your Account in Gmail',
                        btnOkOnPress: () {
                          Navigator.of(context).pushReplacementNamed("login");
                        },
                      ).show();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The password provided is too weak',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                        print(
                            '=============The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'The account already exists for that email',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {},
                        ).show();
                        print(
                            '==================The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                }),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("login");
              },
              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Have An Account ? ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(
                          color: Color(0xFF0462ff),
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Lato',
                          fontSize: 16)),
                ])),
              ),
            )
          ],
        ),
      ),
    );
  }
}
