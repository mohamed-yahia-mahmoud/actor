
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:get/get.dart';

class ImageCard extends StatefulWidget {

  final String?  url;
  final int? itemId;

    ImageCard({ this.url, this.itemId,Key? key,}) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
   late bool visible;

  @override
  void initState() {
    visible = false;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Container(
            height: 169 ,
            // width: 342,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/w500/"+widget.url!),fit: BoxFit.fill)
            ),
          ),
        ],
      ),
    );
  }

 }
