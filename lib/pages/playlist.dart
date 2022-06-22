import 'package:flutter/material.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({Key? key}) : super(key: key);

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
      body:  SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 15,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children:[
                     const Text('Playlist',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                    const  SizedBox(width: 140,),
                     IconButton(onPressed: (){}, icon: const Icon(Icons.add,size: 30,color: Colors.white,)),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.search,size: 30,color: Colors.white,))
                   ],
                 ),
          ],
        ),
      ))
      ),
    );
  }
}