import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pay/pay.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxonetime/constant/constant.dart';
import 'package:taxonetime/controller/authController.dart';
import 'package:taxonetime/models/service.dart';
import 'package:taxonetime/widgets/notification.dart';

String ref = 'gs://t-o-t-5ec61.appspot.com/userDocuments';
List docUri = [];
List<String> docAddress = [];
final storageRef = FirebaseStorage.instance.refFromURL(ref);

class ServiceDetails extends StatefulWidget {
  ServiceDetails({Key? key, required this.services}) : super(key: key);
  Services services;

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    final _paymentItems = [
      PaymentItem(
        label: widget.services.serviceName,
        amount: widget.services.servicePrice.toString(),
        status: PaymentItemStatus.final_price,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded)),
        title: Text(
          widget.services.category.toUpperCase(),
          style: const TextStyle(fontSize: 18),
        ),
        centerTitle: false,
        backgroundColor: const Color(0xFF41729F),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: Colors.black,
                  ),
                  height: 50,
                  width: 50,
                  child: ClipOval(
                    child: Image.network(
                      widget.services.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  )),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Flexible(
                  child: Text(widget.services.serviceName,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            divider,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Description',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.description)
              ],
            ),
            divider,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(widget.services.desc,
                  style: const TextStyle(fontSize: 14)),
            ),
            divider,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Requirements',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Icon(Icons.document_scanner)
              ],
            ),
            divider,
            (widget.services.requirements.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.services.requirements.length,
                    itemBuilder: (context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.5, vertical: 5),
                        child: Text(
                            '${index + 1}. ${widget.services.requirements[index]}',
                            style: const TextStyle(fontSize: 14)),
                      );
                    },
                  )
                : const Text('Only account data required!')),
            divider,
            Row(
              children: [
                const Text('PRICE: ', style: TextStyle(fontSize: 18)),
                Text('PKR ${widget.services.servicePrice.toString()}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            divider,
            Row(
              children: const [
                Text('ETD: ', style: TextStyle(fontSize: 18)),
                Text('1 day',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            divider,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  getFile();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                child: const Text('Upload Documents'),
              ),
            ),
            divider,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (docUri.length == widget.services.requirements.length) {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GooglePayButton(
                                  height: 70,
                                  width: 200,
                                  
                                  paymentConfigurationAsset: 'gpay.json',
                                  paymentItems: _paymentItems,
                                  style: GooglePayButtonStyle.black,
                                  type: GooglePayButtonType.buy,
                                  onPaymentResult: onGooglePayResult,
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    showSnackBar(
                        error: 'Error',
                        message: 'Please add required documents',
                        type: 'e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                child: const Text('Acquire Service'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getFile() async {
    final results = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.any);
    if (results == null) {
      showSnackBar(error: 'Error', message: 'No file selected', type: 'e');
      return;
    } else {
      final path = results.files.single.path!;
      final name = results.files.single.name;
      uploadFile(name, path);
    }
  }

  void onGooglePayResult(paymentResult) {
    print(paymentResult);
    FirebaseFirestore.instance.collection('cases').doc().set({
      'serviceId': widget.services.id,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'userEmail': AuthController.authInstance.userData.value.email,
      'userAddress': AuthController.authInstance.userData.value.address,
      'userName': AuthController.authInstance.userData.value.name,
      'userCnic': AuthController.authInstance.userData.value.cnic,
      'userDocUrl': docUri,
      'userDocAddress': docAddress,
      'paymentToken': paymentResult.toString(),
    });
  }

  Future<void> uploadFile(String name, String path) async {
    File file = File(path);
    try {
      storageRef.child(name).putFile(file).then((p0) {
        print(p0);
        storageRef.child(name).getDownloadURL().then((value) {
          setState(() {
            docUri.add(value);
            docAddress.add('$ref/$name');
          });
        }).onError((error, stackTrace) {
          showSnackBar(
              error: 'Error',
              message: 'Something happened while fetching Url',
              type: 'e');
        });
      });
    } on FirebaseException catch (e) {
      print('Error while uploading ${e.toString()}');
    }
  }
}
