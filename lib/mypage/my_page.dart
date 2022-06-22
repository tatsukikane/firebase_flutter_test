import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_test/domain/image.dart';
import 'package:firebase_flutter_test/edit_profile/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'my_model.dart';



class MyPage extends StatelessWidget {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _images = _firestore.collection('imags');
  final Stream<QuerySnapshot> _imagesStream = _images.snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('MyPage'),
          actions: [
           Consumer<MyModel>(builder: (context, model, child){
                return IconButton(onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(model.name!, model.description!),
                      ),
                    );
                    model.fetchUser();
                },
                icon: Icon(Icons.edit));
              }
            ),
          ],
        ),
        body: Center(
          child: Consumer<MyModel>(builder: (context, model, child){
            return Stack(
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(
                        model.name ?? 'anonymous',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        
                        ),
                      Text(model.email ?? 'メールアドレスなし'),
                      Text(model.description ??'.......'),
                      TextButton(onPressed: () async{
                        //ログアウト
                        await model.logout();
                        Navigator.of(context).pop();
                      },
                      child: Text('ログアウト'),
                      )
                    ],
                ),
                  ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
      }),
    ),
    
      ),
    );
  }
}
