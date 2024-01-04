import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:task_management/provider/user_information_provider.dart';
import 'item_drawer.dart';

class MenuViewPage extends StatelessWidget {
  const MenuViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff617afd),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/base_images/logo_app.png",height: 260,color: Colors.white),
            Text("Task Manager",style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 35),
            ItemDrawer(iconData: Icons.person,text: "Profile",onTap: ()async{
              await Provider.of<UserInformationProvider>(context,listen: false).pageViewController(0);
              ZoomDrawer.of(context)?.close();
            }),
             ItemDrawer(iconData: Icons.task_alt, text: "All Tasks",onTap:()async{
               await Provider.of<UserInformationProvider>(context,listen: false).pageViewController(1);
               ZoomDrawer.of(context)?.close();
             }),
            const ItemDrawer(iconData: Icons.add_circle,text: "Add new task",),
            const ItemDrawer(iconData: Icons.group,text: "Create Group"),
            const ItemDrawer(iconData: Icons.settings,text: "Settings"),
            const ItemDrawer(iconData: Icons.contact_support,text: "Support"),
            const ItemDrawer(iconData: Icons.star_border,text: "Rate"),
          ],
        ),
      ),
    );
  }
}