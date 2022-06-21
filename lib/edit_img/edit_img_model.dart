import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../domain/image.dart';


class EditImgModel extends ChangeNotifier {
  final Imagedeta image;
  EditImgModel(this.image) {
    titleController.text = image.title;
    imgurlController.text = image.imgurl;
  }


  final titleController = TextEditingController();
  final imgurlController = TextEditingController();



  //値が入るまではnullだから、? でnullを許容する形にしてあげる
  String? title;
  String? imgurl;

  void setTitle(String title){
    this.title = title;
    notifyListeners();
  }

  void setImageurl(String imgurl){
    this.imgurl = imgurl;
    notifyListeners();
  }

  bool isUpdated(){
    return title != null || imgurl != null;
  }


  //firebaseの変更をリッスンしている
  Future update() async {
    this.title = titleController.text;
    this.imgurl = imgurlController.text;


    // if (title == null) {
    //   throw 'タイトルが入力されていません。';
    // }

    // if (imgurl == null) {
    //   throw '画像URLが入力されていません。';
    // }

    //firestoreのデータを変更
    await FirebaseFirestore.instance.collection('images').doc(image.id).update({
      'title':title,
      'imgurl':imgurl,
    });
  }
}