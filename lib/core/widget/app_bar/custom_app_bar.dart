import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../features/auth/sign up/view/widget/custom_leading_item.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.titleAppBar});
  final String titleAppBar;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CustomLeadingItem(
          colorIcon: Colors.white,
          onPressed: () => ZoomDrawer.of(context)?.toggle(),
        ),
        title:Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Align(
              alignment: Alignment.topCenter,
              child: Text(titleAppBar,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium)),
        ),
    );
  }
}
