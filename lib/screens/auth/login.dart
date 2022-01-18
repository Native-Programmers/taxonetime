import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sign_button/sign_button.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

const url = 'https://sites.google.com/view/tax-one-time';
bool hidden = true;
String cnic = '';

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late VideoPlayerController _controller;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/videos/coin.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.setLooping(true);
    _controller.play();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _password.dispose();
    _email.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            VideoPlayer(_controller),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Divider(
                        height: 75,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                          width: 200,
                          child: Image.asset('assets/icons/logo.png')),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'By logging in, you are accepting our',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const Divider(
                          height: 5,
                          color: Colors.transparent,
                        ),
                        InkWell(
                            onTap: () async {
                              try {
                                if (await canLaunch(url)) {
                                  await launch(url,
                                      enableJavaScript: true,
                                      forceWebView: true);
                                } else {
                                  Get.snackbar('Unable open',
                                      'Please check your internet connection');
                                }
                              } catch (e) {
                                Get.snackbar('Error',
                                    'Unable to establish a stable connection');
                              }
                            },
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: SignInButton(
                              buttonType: ButtonType.mail,
                              width: 265,
                              onPressed: () {
                                emailLogin();
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: SignInButton(
                              buttonType: ButtonType.facebook,
                              width: 265,
                              onPressed: () {
                                AuthController.authInstance
                                    .signInWithFacebook();
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: SignInButton(
                              buttonType: ButtonType.googleDark,
                              width: 265,
                              onPressed: () {
                                AuthController.authInstance.handleSignIn();
                              }),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: SignInButton(
                              buttonType: ButtonType.apple,
                              width: 265,
                              onPressed: null,
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color: Colors.transparent),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  children: const [
                                    Icon(Icons.app_registration),
                                    VerticalDivider(
                                      color: Colors.transparent,
                                      width: 10,
                                    ),
                                    Text('New Registration')
                                  ],
                                ),
                              ),
                              onPressed: () {
                                newUser();
                              },
                            )),
                        const Divider(
                          height: 25,
                          color: Colors.transparent,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future<void> newUser() async {
    showDialog(
        context: context,
        builder: (_) {
          bool isPasswordhidden = true;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('New User'),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: decorations(hint: 'Enter Email'),
                        validator: (value) => EmailValidator.validate(value!)
                            ? null
                            : "Please enter a valid email",
                        controller: _email,
                      ),
                      const Divider(
                        height: 15,
                        color: Colors.transparent,
                      ),

                      const Divider(
                        height: 15,
                        color: Colors.transparent,
                      ),
                      TextFormField(
                          obscureText: isPasswordhidden,
                          controller: _password,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: "Please enter password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordhidden = !isPasswordhidden;
                                  });
                                },
                                icon: isPasswordhidden
                                    ? const FaIcon(FontAwesomeIcons.eye)
                                    : const FaIcon(FontAwesomeIcons.solidEye)),
                          )),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      FlutterPwValidator(
                        controller: _password,
                        minLength: 8,
                        specialCharCount: 1,
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        width: 400,
                        height: 150,
                        onSuccess: () {},
                      ),
                      const Divider(
                        height: 15,
                        color: Colors.transparent,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      content: SpinKitWave(
                                        color: Colors.amber,
                                      ))).then((value) =>
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: _email.text,
                                          password: _password.text)
                                      .then((value) {
                                    Get.back();
                                    Get.back();
                                    FirebaseAuth.instance.signOut();
                                  }).onError((error, stackTrace) {
                                    Get.back();
                                    Get.back();
                                    Get.snackbar(
                                        'Error', "User already registered");
                                  }));
                            } else {
                              Get.snackbar(
                                  'Error', 'Please fill all the fields');
                            }
                          },
                          child: const Text('REGISTER'))
                      // TextFormField(
                      //   decoration: decorations,
                      //   enabled: false,
                      // ),
                      // TextFormField(
                      //   decoration: decorations,
                      //   enabled: false,
                      // ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'))
              ],
            );
          });
        });
  }

  Future<void> emailLogin() async {
    showDialog(
      context: context,
      builder: (context) {
        bool isPasswordhidden = true;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Please login to your account"),
              content: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _email,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Please enter a valid email",
                        ),
                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        TextFormField(
                            obscureText: isPasswordhidden,
                            controller: _password,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: "Please enter password",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordhidden = !isPasswordhidden;
                                    });
                                  },
                                  icon: isPasswordhidden
                                      ? const FaIcon(FontAwesomeIcons.eye)
                                      : const FaIcon(
                                          FontAwesomeIcons.solidEye)),
                            )),
                        const Divider(
                          height: 15,
                          color: Colors.transparent,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      content: SpinKitWave(
                                        color: Colors.amber,
                                      ))).then((value) =>
                                  AuthController.authInstance
                                      .login(
                                          email: _email.text,
                                          password: _password.text)
                                      .then((value) {
                                    Get.back();
                                    Get.back();
                                  }).onError((error, stackTrace) {
                                    Get.back();
                                    Get.back();
                                    Get.snackbar('Error', 'Unable to login');
                                  }));
                            } else {
                              Get.snackbar(
                                  'Error', 'Please fill all the fields');
                            }
                          },
                          child: const Text("Login"),
                        )
                      ],
                    ),
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  InputDecoration decorations({required String hint}) {
    return InputDecoration(
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintText: hint,
    );
  }
}
