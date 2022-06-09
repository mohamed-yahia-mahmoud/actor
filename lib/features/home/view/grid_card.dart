
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:get/get.dart';

class GridCard extends StatefulWidget {

  final String?  url;
  final int? itemId;

    GridCard({ this.url, this.itemId,Key? key,}) : super(key: key);

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {

  @override
  void initState() {
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: widget.url!=null?NetworkImage("https://image.tmdb.org/t/p/w500/"+widget.url!):
             const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScPr_e8yD_adDE0sUA6xJykV7Vuwyc0xQoun4XfAANTKGYdq2m99kHFf-Hc_XpY0YVnug&usqp=CAU')
                  ,fit: BoxFit.fill)
            ),
          ),
        ],
      ),
    );
  }

 }
