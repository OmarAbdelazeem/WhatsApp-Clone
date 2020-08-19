import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapptest/services/data_base_service.dart';
import '../models/chat_item.dart';
import '../models/user.dart';

class DataBase extends ChangeNotifier{
  User defaultUser;
  User currentUser;
  ChatItem currentChat;
  File profilePhotoFile ;
  String _userName = '';
  DataBaseService _dataBaseService = DataBaseService();

  void changeCurrentChat(ChatItem chatItem){
    currentChat = chatItem;
  }

  void changeCurrentUser(User user){
    currentUser = user;
  }

  Future setUpUser({@required String phoneNumber,@required String userId}) async{
    String profilePhotoUrl;
    if (profilePhotoFile != null) {
       profilePhotoUrl = await  _dataBaseService.uploadFile(selectedFile: profilePhotoFile);
    }
    defaultUser = User(photoUrl: profilePhotoUrl,name: _userName,id: userId,);
    return _dataBaseService.setUpUser(
        userName: _userName, phoneNumber: phoneNumber, userId: userId,photoUrl: profilePhotoUrl);
  }

  void onNameChanged(String name) {
    _userName = name;
  }

  handleImage(ImageSource source) async {
    profilePhotoFile = await _dataBaseService.getImage(source);
    notifyListeners();
    print('_selectedFile is $profilePhotoFile');
  }

}