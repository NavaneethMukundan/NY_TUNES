import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromARGB(255, 1, 105, 94),
                Colors.black,
                Colors.black,
              ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children:const [
              SizedBox(
                height: 15,
              ),
               Text('Liked Songs',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      )
      ),
    );
  }
}