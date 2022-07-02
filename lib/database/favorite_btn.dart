import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'favorite_db.dart';

class FavorBtn extends StatefulWidget {
  const FavorBtn({Key? key, required this.song}) : super(key: key);
  final SongModel song;
  @override
  State<FavorBtn> createState() => _FavorBtnState();
}

class _FavorBtnState extends State<FavorBtn> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {});
          if (Favorite.isfavor(widget.song)) {
            Favorite.delete(widget.song.id);
            const snackbar = SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  'Removed From Favorite',
                  style: TextStyle(color: Colors.white),
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            setState(() {});
          } else {
            Favorite.add(widget.song);
            const snackbar = SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  'Added to Favorite',
                  style: TextStyle(color: Colors.white),
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
          setState(() {});
        },
        icon: Favorite.isfavor(widget.song)
            ? const Icon(
                Icons.favorite,
                color: Colors.teal,
              )
            : const Icon(
                Icons.favorite_border,
                color: Colors.white,
              ));
  }
}
