import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../domain/image.dart';


class RegisterModel extends ChangeNotifier {


  final titleController = TextEditingController();
  final subtitleController = TextEditingController();



  //値が入るまではnullだから、? でnullを許容する形にしてあげる
  String? email;
  String? password;

  bool isLoading = false;

  void startLoading(){
    isLoading = true;
    notifyListeners();
  }

  void endLoading(){
    isLoading = false;
    notifyListeners();
  }




  void setEmail(String email){
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password){
    this.password = password;
    notifyListeners();
  }


  //firebaseの変更をリッスンしている
  Future singup() async {
    this.email = titleController.text;
    this.password = subtitleController.text;


    //firebase authでユーザー登録




  //メール認証 登録
  // Future<void> createUserFromEmail() async {
  //   UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //     email: 'test@test.com',
  //     password: 'testtest'
  //   );
  //   print('Emailからユーザー作成完了');
  // }

    if(email != null && password != null){
      final UserCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = UserCredential.user;

      if (user != null) {
        final uid = user.uid;


        //firestoreのデータを変更
        final doc = FirebaseFirestore.instance.collection('users').doc(uid);
        await doc.set({
          'uid':uid,
          'email':email,
        });


      }
    }

  }
}
