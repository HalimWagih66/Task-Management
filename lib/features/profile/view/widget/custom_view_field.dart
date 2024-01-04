import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/provider/user_information_provider.dart';

class CustomViewField extends StatelessWidget {
  const CustomViewField({super.key, required this.text, required this.label});
  final String text;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,overflow:TextOverflow.clip ,style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).primaryColor,),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,style: Theme.of(context).textTheme.titleMedium,overflow: TextOverflow.clip,),
              IconButton(onPressed: (){
                Provider.of<UserInformationProvider>(context,listen: false).pageViewController(2,speed: 100);
              }, icon: const Icon(Icons.edit)),
            ],
          ),
          const SizedBox(height: 7),
          const Divider(height: 2,color: Colors.grey,),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
