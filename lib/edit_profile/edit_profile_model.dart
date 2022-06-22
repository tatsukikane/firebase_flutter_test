import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../domain/image.dart';


class EditProfileModel extends ChangeNotifier {
  EditProfileModel(this.name, this.description){
    nameController.text = name!;
    descriptionController.text = description!;
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();



  //値が入るまではnullだから、? でnullを許容する形にしてあげる
  String? name;
  String? description;

  void setname(String name){
    this.name = name;
    notifyListeners();
  }

  void setdescription(String description){
    this.description = description;
    notifyListeners();
  }

  bool isUpdated(){
    return name != null || description != null;
  }


  //firebaseの変更をリッスンしている
  Future update() async {
    this.name = nameController.text;
    this.description = descriptionController.text;


    //firestoreのデータを変更
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name':name,
      'description':description,
    });
  }
}