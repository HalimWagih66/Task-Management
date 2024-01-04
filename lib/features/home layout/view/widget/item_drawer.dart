import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({super.key, required this.iconData, required this.text, this.onTap});
  final IconData iconData;
  final String text;
  final Function? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap !=null?(){
            onTap!();
          }:null,
          child: Row(
            children: [
              Icon(iconData,color: Colors.white,),
              const SizedBox(width: 12,),
              Text(text,style: Theme.of(context).textTheme.displayMedium,),
            ],
          ),
        ),
        const SizedBox(height: 13)
      ],
    );
  }
}
