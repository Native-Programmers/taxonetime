import 'package:bubble/bubble.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taxonetime/screens/chat/chatbody.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:dialogflow_flutter/message.dart';

TextEditingController _chat = TextEditingController();
List<Map> messages = [];

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  // late DialogFlowtter dialogFlowtter;
  // List<Map<String, dynamic>> messages = [];

  Future<void> response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: 'assets/dialog_flow_auth.json').build();
    DialogFlow dialogFlow =
        DialogFlow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogFlow.detectIntent(query);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "messages":
            aiResponse.getListMessage()![0]["text"]["text"][0].toString()
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CHATBOT'),
          actions: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.solidHeart),
              onPressed: () {},
            )
          ],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(85),
                    borderRadius: BorderRadius.circular(25)),
                child: Text(
                  "Today ${DateFormat("Hm").format(DateTime.now())}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Flexible(
                  child: ListView.builder(
                      reverse: true,
                      itemBuilder: (context, int index) => chat(
                          messages[index]['message'].toString(),
                          messages[index]['data']),
                      itemCount: 0)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: ListTile(
                  trailing: CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            messages
                                .insert(0, {"data": 1, "message": _chat.text});
                          });
                          response(_chat.text);
                          _chat.clear();
                        }
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                    ),
                  ),
                  title: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(50),
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                      maxLines: 5,
                      minLines: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          Get.snackbar(
                              'Error', 'Please type something before sending',
                              backgroundColor: Colors.red);
                          return null;
                        }
                        return null;
                      },
                      controller: _chat,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        fillColor: Colors.grey,
                        border: InputBorder.none,
                        hintText: 'Enter Message Here',
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget chat(String message, int data) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/robot.png")),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Bubble(
              radius: Radius.circular(15),
              color: data == 0
                  ? const Color.fromRGBO(23, 157, 139, 1)
                  : Colors.orangeAccent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const VerticalDivider(
                    width: 10,
                    color: Colors.transparent,
                  ),
                  Flexible(
                      child: Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
          data == 1
              ? const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.png")),
                )
              : Container()
        ],
      ),
    );
  }
}
