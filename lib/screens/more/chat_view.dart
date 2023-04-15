import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';
import '../../widgets/text.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  final TextEditingController _chat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Chat with us',
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                child: Obx(
              () => icon.chatlist.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/no_msg.png'),
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          Txt(
                            text: 'You have’nt have any quries yet.',
                            fsize: 12,
                            color: Colors.grey[500]!,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: icon.chatlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatBubble(
                          text: icon.chatlist[index]['message'],
                          isCurrentUser:
                              icon.chatlist[index]['sender'] == 'user'
                                  ? true
                                  : false,
                        );
                      },
                    ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(0.0.sp),
                  child: TextField(
                    controller: _chat,
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          if (_chat.text.isNotEmpty) {
                            icon.chatlist.add({
                              'message': _chat.text,
                              'sender': 'user',
                              'createdOn': 'just now',
                              'status': 'sent'
                            });
                            icon.addChat(_chat.text);
                            _chat.clear();
                          }
                        },
                        child: Icon(
                          Icons.send,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Type a message',
                      contentPadding: EdgeInsets.all(13),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.isCurrentUser,
  }) : super(key: key);
  final String text;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          // asymmetric padding
          padding: EdgeInsets.fromLTRB(
            isCurrentUser ? 64.0 : 16.0,
            4,
            isCurrentUser ? 16.0 : 64.0,
            4,
          ),
          child: Align(
            // align the child within the container
            alignment:
                isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
            child: DecoratedBox(
              // chat bubble decoration
              decoration: BoxDecoration(
                color: isCurrentUser ? Color(0xFF1D8054) : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isCurrentUser ? 10 : 0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(isCurrentUser ? 0 : 10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: isCurrentUser ? Colors.white : Colors.black87),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
