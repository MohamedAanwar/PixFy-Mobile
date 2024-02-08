import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixfyapp/component/custombutton.dart';
import 'package:pixfyapp/component/customlogoauth.dart';
import 'package:pixfyapp/component/textformfield.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool abc = true;
  bool isloading = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    isloading = true;
    setState(() {});
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    isloading = false;
    setState(() {});
    Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

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
                    "Login",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Lato'),
                  ),
                  Container(
                    height: 5,
                  ),
                  Text(
                    "Login to continue using PixFy",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                        fontSize: 17),
                  ),
                  Container(
                    height: 20,
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
                    mycontroller: _email,
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
                    controller: _password,
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
                  InkWell(
                    onTap: () async {
                      if (_email.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Please enter email to reset password',
                          btnOkOnPress: () {},
                        ).show();
                      } else {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: _email.text);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Warning',
                            desc: 'Please check your gmail to reset password',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        } catch (e) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Please enter valid email',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 5,
            ),
            isloading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: Color(0xFF0462ff),
                    ),
                  )
                : CustomButton(
                    hinttext: "Login",
                    onPressed: () async {
                      if (formstate.currentState!.validate()) {
                        try {
                          isloading = true;
                          setState(() {});
                          // ignore: unused_local_variable
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email.text.trim(),
                                  password: _password.text.trim());
                          isloading = false;
                          setState(() {});

                          if (credential.user!.emailVerified) {
                            Navigator.of(context).pushReplacementNamed("home");
                          } else {
                            isloading = false;
                            setState(() {});
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Please Verfiy Your Email',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            isloading = false;
                            setState(() {});
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'No user found for that email.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          } else if (e.code == 'wrong-password') {
                            isloading = false;
                            setState(() {});
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Error',
                              desc: 'Wrong password provided for that user.',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            ).show();
                          }
                        }
                      } else {
                        print("================Nonfwdsd");
                      }
                    },
                  ),
            Container(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "-Or login with-",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Pacifico'),
              ),
            ),
            Container(
              height: 17,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Color(0xFF0462ff),
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10)
                          ]),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/google.png",
                        width: 35,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Color(0xFF0462ff),
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      signInWithFacebook();
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10)
                          ]),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/facebook.jpeg",
                        width: 50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Color(0xFF0462ff),
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Warning',
                        desc: 'Sorry, only registering with a Google works!',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      ).show();
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10)
                          ]),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/twitter.jpeg",
                        width: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            Container(
              height: 25,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signup");
              },
              child: Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Don't Have An Account ? ",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  TextSpan(
                      text: "SignUp",
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
