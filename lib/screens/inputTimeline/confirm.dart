import 'package:flutter/material.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Column(children: [
        const Text('Please approve'),
        const Text(
            "By pressing the button below, you're authorizing Tax One Time to use the data provided by the user. Please confirm if so, if not please logout. (No data is saved before approval.)"),
        ElevatedButton(onPressed: () {
          
        }, child: const Text('Approve & Use')),
      ]),
    );
  }
}
