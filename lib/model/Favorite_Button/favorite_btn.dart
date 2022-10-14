import 'package:flutter/material.dart';
import 'package:ny_tunes/controller/provider/main_functions/widgets/favorite_db_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavorBtn extends StatelessWidget {
  const FavorBtn({Key? key, required this.song}) : super(key: key);
  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteFunctionController>(
      builder: (context, value, child) {
        return IconButton(
            onPressed: () {
              if (value.isfavor(song)) {
                value.delete(song.id);
                value.notifyListeners();
                const snackbar = SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'Removed From Favorite',
                      style: TextStyle(color: Colors.white),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              } else {
                value.add(song);
                value.notifyListeners();
                const snackbar = SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'Added to Favorite',
                      style: TextStyle(color: Colors.white),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            icon: value.isfavor(song)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.teal,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ));
      },
    );
  }
}
