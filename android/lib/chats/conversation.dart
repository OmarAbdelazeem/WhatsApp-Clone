import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/data.dart';
import '../widgets/message_widget.dart';

class Conversation extends StatefulWidget {
  final receiverId;
  var chatId;
  // final fromConversationScreen;

  Conversation(
      {this.receiverId, this.chatId,});

  @override
  _ConversationState createState() => _ConversationState();
}

Firestore fireStore = Firestore.instance;

class _ConversationState extends State<Conversation> {
  var messagesStream;
  bool userFounded = false;
  bool loaded = false;
  var myData;
  TextEditingController sendController = TextEditingController();

  final DateTime timestamp = DateTime.now();

  @override
  void initState() {
    myData = Provider.of<Data>(context, listen: false);
    DocumentReference docRefSender =
        Firestore.instance.collection('users').document(myData.senderId);
    docRefSender.get().then((value) {
      DocumentSnapshot docSender = value;
      List userChats = docSender.data['userChats'];
      for (int i = 0; i < userChats.length; i++) {
        if (userChats[i]['userId'] == widget.receiverId) {
          userFounded = true;
          widget.chatId = userChats[i]['chatId'];
          print('founded');
          print('chatId is ${widget.chatId}');
        }
      }
      if (!userFounded) widget.chatId = Uuid().v4();
      setState(() {
        loaded = true;
      });
    });

    super.initState();
  }

  void send() async {
    if (sendController.text != null) {
      // the begin of snippet for sending message to fireStore
      DocumentReference documentReference = Firestore.instance
          .collection('usersMessages')
          .document(widget.chatId)
          .collection('messages')
          .document();

      Map<String, dynamic> sentMessage = {
        'messageText': sendController.text,
        'senderId': myData.senderId,
        'messageTime': timestamp
//      'lastNum': lastNumber,
      };

      documentReference.setData(sentMessage).whenComplete(() {
        print('completed');
      });
      // the end of snippet
      if (!userFounded) {
        DocumentReference docRefReceiver =
            Firestore.instance.collection('users').document(widget.receiverId);
        DocumentSnapshot docReceiver = await docRefReceiver.get();
        String receiverName = docReceiver.data['name'];

        DocumentReference docRefSender =
            Firestore.instance.collection('users').document(myData.senderId);
        DocumentSnapshot docSender = await docRefSender.get();
        String senderName = docSender.data['name'];

        docRefReceiver.updateData({
          'userChats': FieldValue.arrayUnion([
            {
              'chatId': widget.chatId,
              'userId': myData.senderId,
              'userName': senderName
            }
          ])
        });

        docRefSender.updateData({
          'userChats': FieldValue.arrayUnion([
            {
              'chatId': widget.chatId,
              'userId': widget.receiverId,
              'userName': receiverName
            }
          ])
        });
      }
      sendController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: fireStore
                      .collection('usersMessages')
                      .document(widget.chatId)
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    snapshot.data.documents.forEach((element) {
                      print('message is ${element['messageText']}');
                    });
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return MessageWidget(
                            text: snapshot.data.documents[index]['messageText'],
                            isMe: snapshot.data.documents[index]['senderId'] ==
                                myData.senderId,
                          );
                        },
                        itemCount: snapshot.data.documents.length,
                      ),
                    );
                  },
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: sendController,
                        ),
                      ),
                      FlatButton(
                        onPressed: send,
                        child: Text(
                          'Send',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
