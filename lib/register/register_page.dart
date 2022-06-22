import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_test/domain/image.dart';
import 'package:firebase_flutter_test/register/register_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



class RegisterPage extends StatelessWidget {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _images = _firestore.collection('images');
  final Stream<QuerySnapshot> _imagesStream = _images.snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('編集'),
        ),
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child){
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                  TextField(
                    controller: model.titleController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    onChanged: (text) {
                      model.setEmail(text);
                    },
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                
                  TextField(
                    controller: model.subtitleController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    onChanged: (text) {
                      model.setPassword(text);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      model.startLoading();
                    //追加の処理
                    try{
                      await model.singup();
                      Navigator.of(context).pop();
                    } catch(err) {
                      //エラーの出力
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(err.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } finally{
                      model.endLoading();
                    }
                  },
                  child: Text('登録する'),
                  ),
                          ],
                        ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )


              ],
            );
      }),
    ),
    
      ),
    );
  }
}

