import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:taxonetime/constant/constant.dart';
import 'package:taxonetime/widgets/notification.dart';

class UserCard extends StatefulWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    getData().then((value) {
      setState(() {
        cardNumber = value['number'];
        expiryDate = value['expiry'];
        cardHolderName = value['name'];
        cvvCode = value['cvv'];
      });
    });
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/bg.png'),
              fit: BoxFit.fill,
            ),
            color: Colors.black,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                CreditCardWidget(
                  glassmorphismConfig: Glassmorphism.defaultConfig(),
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Colors.red,
                  backgroundImage: 'assets/images/card_bg.png',
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/images/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.white,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                primary: const Color(0xff1b447b),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(12),
                                child: const Text(
                                  'Save Information',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'halter',
                                    fontSize: 14,
                                    package: 'flutter_credit_card',
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (_) => WillPopScope(
                                      onWillPop: () async {
                                        return false;
                                      },
                                      child: const AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        content: SpinKitDancingSquare(
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  );
                                  await storage
                                      .write(key: 'name', value: cardHolderName)
                                      .then((value) {
                                    storage
                                        .write(key: 'number', value: cardNumber)
                                        .then((value) {
                                      storage
                                          .write(
                                              key: 'expiry', value: expiryDate)
                                          .then((value) {
                                        storage
                                            .write(key: 'cvv', value: cvvCode)
                                            .then((value) {
                                          Get.back();
                                          showSnackBar(
                                              error: 'Success',
                                              message:
                                                  'Information saved successfully',
                                              type: 's');
                                        }).onError((error, stackTrace) {
                                          print('Error: $error');
                                        });
                                      }).onError((error, stackTrace) {
                                        print('Error: $error');
                                      });
                                    }).onError((error, stackTrace) {
                                      print('Error: $error');
                                    });
                                  }).onError((error, stackTrace) {
                                    print('Error: $error');
                                  });
                                } else {
                                  showSnackBar(
                                      error: 'Error',
                                      message: 'Please fill all fields',
                                      type: 'e');
                                }
                              },
                            ),
                            divider,
                            const SizedBox(
                              width: 300,
                              child: Text(
                                'For safety purposes. Card information will be stored locally.',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getData() async {
    cardNumber = await storage.read(key: 'number') ?? '';
    expiryDate = await storage.read(key: 'expiry') ?? '';
    cardHolderName = await storage.read(key: 'name') ?? '';
    cvvCode = await storage.read(key: 'cvv') ?? '';
    Map<String, dynamic> data = ({
      'number': cardNumber,
      'name': cardHolderName,
      'cvv': cvvCode,
      'expiry': expiryDate,
    });
    print(data);
    return data;
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
