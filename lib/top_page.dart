import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'img_list/img_list_page.dart';


class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/564x/82/c0/70/82c0703007702b271086868d69e03ca0.jpg'),
            fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 176),
                child: Text(
                  'Epic Three Hog',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fascinate(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[300]
                    ),
                  ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(56),
                ),
                onPressed: (){
                  //ボタンを押したときの挙動
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ImgListPage()),
                    (_) => false
                  );
                },
                child: const Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  
                  ),
               ),
            ],
          ),
          ),
      ),
    );
  }
}