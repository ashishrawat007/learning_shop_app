import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
final Widget child ;
final String value ;

Badge({required this.child, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8 ,
          child: Container(
            padding:const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius : BorderRadius.circular(10),
              color: Theme.of(context).accentColor,
            ),
                constraints :const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
               fontSize: 10 ,
              )
            )
          ),

        )
      ],
    );
  }
}