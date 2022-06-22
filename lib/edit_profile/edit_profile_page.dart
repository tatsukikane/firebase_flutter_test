import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_test/domain/image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'edit_profile_model.dart';



class EditProfilePage extends StatelessWidget {
  EditProfilePage(this.name, this.description);
  final String name;
  final String description;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _images = _firestore.collection('images');
  final Stream<QuerySnapshot> _imagesStream = _images.snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileModel>(
      create: (_) => EditProfileModel(
        name,
        description
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('プロフィール編集'),
        ),
        body: Center(
          child: Consumer<EditProfileModel>(builder: (context, model, child){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
              TextField(
                controller: model.nameController,
                decoration: InputDecoration(
                  hintText: '名前',
                ),
                onChanged: (text) {
                  model.setname(text);
                },
              ),

              const SizedBox(
                height: 8,
              ),
            
              TextField(
                controller: model.descriptionController,
                decoration: InputDecoration(
                  hintText: '自己紹介',
                ),
                onChanged: (text) {
                  model.setdescription(text);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: model.isUpdated()
                //updateされていた場合は以下の処理を実行
                ? () async {
                //追加の処理
                try{
                  await model.update();
                  Navigator.of(context).pop();
                } catch(err) {
                  //エラーの出力
                  final snackBar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(err.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } : null,
              child: Text('更新する'),
              ),
                      ],
                    ),
            );
      }),
    ),
    
      ),
    );
  }
}