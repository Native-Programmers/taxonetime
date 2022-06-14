// ignore_for_file: equal_keys_in_map, must_be_immutable, unused_element

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnic_scanner/cnic_scanner.dart';
import 'package:cnic_scanner/model/cnic_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:taxonetime/colors/colors.dart';

File? cnic;
String? Uri;
File? _photo;
final ImagePicker _picker = ImagePicker();

class Scanners extends StatefulWidget {
  Scanners({Key? key, required this.uid, required this.email})
      : super(key: key);
  String uid;
  String? email;

  @override
  State<Scanners> createState() => _ScannersState();
}

class _ScannersState extends State<Scanners> {
  TextEditingController nameTEController = TextEditingController(),
      cnicTEController = TextEditingController(),
      dobTEController = TextEditingController(),
      doiTEController = TextEditingController(),
      doeTEController = TextEditingController(),
      addressController = TextEditingController(),
      phoneNoController = TextEditingController();

  /// you're required to initialize this model class as method you used
  /// from this package will return a model of CnicModel type
  CnicModel _cnicModel = CnicModel();

  Future<void> scanCnic(ImageSource imageSource) async {
    /// you will need to pass one argument of "ImageSource" as shown here
    CnicModel cnicModel =
        await CnicScanner().scanImage(imageSource: imageSource);
    if (cnicModel == null) return;
    setState(() {
      _cnicModel = cnicModel;
      nameTEController.text = _cnicModel.cnicHolderName;
      cnicTEController.text = _cnicModel.cnicNumber;
      dobTEController.text = _cnicModel.cnicHolderDateOfBirth;
      doiTEController.text = _cnicModel.cnicIssueDate;
      doeTEController.text = _cnicModel.cnicExpiryDate;
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
                shadowColor: const Color(kShadowColor),
                elevation: 5,
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.email,
                        color: Color(kDarkGreenColor),
                        size: 17,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 15.0, top: 5, bottom: 3),
                            child: Text(
                              'Email Address',
                              style: TextStyle(
                                  color: Color(kDarkGreenColor),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: TextFormField(
                              enabled: false,
                              initialValue: widget.email,
                              decoration: InputDecoration(
                                hintText: widget.email as String,
                                border: InputBorder.none,
                                isDense: true,
                                hintStyle: const TextStyle(
                                    color: Color(kLightGreyColor),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(0),
                              ),
                              style: const TextStyle(
                                  color: Color(kDarkGreyColor),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            _dataField(
                text: 'User Name',
                textEditingController: nameTEController,
                isEnabled: false),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            _cnicField(textEditingController: cnicTEController),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            _dataField(
                text: 'Date of Birth',
                textEditingController: dobTEController,
                isEnabled: false),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            _dataField(
                text: 'DD/MM/YYYY',
                textEditingController: doiTEController,
                isEnabled: false),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            _dataField(
                text: 'DD/MM/YYYY',
                textEditingController: doeTEController,
                isEnabled: false),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            _dataField(
                text: 'DD/MM/YYYY',
                textEditingController: doeTEController,
                isEnabled: false),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            Card(
                shadowColor: const Color(kShadowColor),
                elevation: 5,
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.phone,
                        color: Color(kDarkGreenColor),
                        size: 17,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 5, bottom: 3),
                            child: Text(
                              "Contact".toUpperCase(),
                              style: const TextStyle(
                                  color: Color(kDarkGreenColor),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              enabled: true,
                              controller: phoneNoController,
                              decoration: const InputDecoration(
                                hintText: "Contact Number",
                                border: InputBorder.none,
                                isDense: true,
                                hintStyle: TextStyle(
                                    color: Color(kLightGreyColor),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.all(0),
                              ),
                              style: const TextStyle(
                                  color: Color(kDarkGreyColor),
                                  fontWeight: FontWeight.bold),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            const Divider(
              height: 5,
              color: Colors.transparent,
            ),
            Card(
                shadowColor: const Color(kShadowColor),
                elevation: 5,
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.location_on,
                        color: Color(kDarkGreenColor),
                        size: 17,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 5, bottom: 3),
                            child: Text(
                              "Address".toUpperCase(),
                              style: const TextStyle(
                                  color: Color(kDarkGreenColor),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 5),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              enabled: true,
                              controller: addressController,
                              decoration: const InputDecoration(
                                hintText: "User Address",
                                border: InputBorder.none,
                                isDense: true,
                                hintStyle: TextStyle(
                                    color: Color(kLightGreyColor),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.all(0),
                              ),
                              style: const TextStyle(
                                  color: Color(kDarkGreyColor),
                                  fontWeight: FontWeight.bold),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.streetAddress,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            const Divider(
              height: 18,
              color: Colors.transparent,
            ),
            _getScanCNICBtn(),
            const Divider(
              height: 10,
              color: Colors.transparent,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.all(0.0),
              ),
              onPressed: () {
                if (nameTEController.text.isEmpty ||
                    cnicTEController.text.isEmpty ||
                    dobTEController.text.isEmpty ||
                    doiTEController.text.isEmpty ||
                    phoneNoController.text.isEmpty ||
                    addressController.text.isEmpty ||
                    doeTEController.text.isEmpty) {
                  Get.snackbar(
                    'Error',
                    'Please scan before submission!',
                    borderRadius: 0,
                    backgroundColor: Colors.red,
                    margin: const EdgeInsets.all(0),
                    colorText: Colors.white,
                  );
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              content: Lottie.asset(
                                  'assets/animations/squares_loading.json'),
                            ),
                          ));
                  FirebaseFirestore.instance
                      .collection('userinfo')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .set({
                    'username': nameTEController.text,
                    'email': widget.email,
                    'cnic': cnicTEController.text,
                    'dob': dobTEController.text,
                    'doe': doeTEController.text,
                    'doi': doiTEController.text,
                    'documents': [],
                    'address': addressController.text,
                    'contact': phoneNoController.text,
                  }).then((value) {
                    Get.back();
                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Data successfully submitted. Please continue with your tour.',
                      borderRadius: 0,
                      backgroundColor: Colors.green,
                      margin: const EdgeInsets.all(0),
                      colorText: Colors.white,
                    );
                  }).onError((error, stackTrace) {
                    Get.back();
                    Get.back();
                    Get.snackbar(
                      'Error',
                      error.toString(),
                      borderRadius: 0,
                      backgroundColor: Colors.red,
                      margin: const EdgeInsets.all(0),
                      colorText: Colors.white,
                    );
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 500,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    gradient: invertedgradients),
                padding: const EdgeInsets.all(12.0),
                child: const Text('Update Information',
                    style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// these are my custom designs you can use according to your ease
  Widget _cnicField({required TextEditingController textEditingController}) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(top: 2.0, bottom: 5.0),
      child: Container(
        margin:
            const EdgeInsets.only(top: 2.0, bottom: 1.0, left: 0.0, right: 0.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 3,
                height: 45,
                margin: const EdgeInsets.only(left: 3.0, right: 7.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [
                        Color(kDeepDarkGreenColor),
                        Color(kDarkGreenColor),
                        Color(kGradientGreyColor),
                      ],
                      stops: [
                        0.0,
                        0.5,
                        1.0
                      ],
                      tileMode: TileMode.mirror,
                      end: Alignment.bottomCenter,
                      begin: Alignment.topRight),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CNIC Number',
                    style: TextStyle(
                        color: Color(kDarkGreenColor),
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    height: 5,
                    color: Colors.transparent,
                  ),
                  Row(
                    children: [
                      Image.asset("assets/images/cnic.png",
                          width: 40, height: 30),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          enabled: false,
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            hintText: '41000-0000000-0',
                            hintStyle: TextStyle(color: Color(kLightGreyColor)),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.only(left: 5.0),
                          ),
                          style: const TextStyle(
                              color: Color(kDarkGreyColor),
                              fontWeight: FontWeight.bold),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataField(
      {required String text,
      required TextEditingController textEditingController,
      required bool isEnabled}) {
    return Card(
        shadowColor: const Color(kShadowColor),
        elevation: 5,
        margin: const EdgeInsets.only(
          top: 10,
          bottom: 5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(
                (text == "Name") ? Icons.person : Icons.date_range,
                color: const Color(kDarkGreenColor),
                size: 17,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, top: 5, bottom: 3),
                    child: Text(
                      text.toUpperCase(),
                      style: const TextStyle(
                          color: Color(kDarkGreenColor),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      enabled: isEnabled,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: text,
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: const TextStyle(
                            color: Color(kLightGreyColor),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      style: const TextStyle(
                          color: Color(kDarkGreyColor),
                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.done,
                      keyboardType: (text == "Name")
                          ? TextInputType.text
                          : TextInputType.number,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _getScanCNICBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.all(0.0),
      ),
      onPressed: () {
        showOrientation();
      },
      child: Container(
        alignment: Alignment.center,
        width: 500,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(colors: <Color>[
            Color(kDeepDarkGreenColor),
            Color(kDarkGreenColor),
            Colors.green,
          ]),
        ),
        padding: const EdgeInsets.all(12.0),
        child: const Text('Scan CNIC', style: TextStyle(fontSize: 18)),
      ),
    );
  }

  Future<void> showOrientation() async {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      Future.delayed(const Duration(seconds: 5)).then((value) {
        Get.back();
        scanCnic(ImageSource.camera);
      });
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5.00),
                        child: Lottie.asset(
                            'assets/animations/portrait_mode.json')),
                    const Divider(),
                    const Text(
                      'STARTING SCANNER!!!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const Text(
                      'Scan in portrait mode!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ));
  }
}
