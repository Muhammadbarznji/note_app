import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          DrawerHeader(
            child: Text(
              "",
              style: Theme.of(context).textTheme.headline1,
            ),
            decoration: const BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/navigator_cover.jpg"),
              ),
            ),
          ),
           ListTile(
            leading:const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              print("Home");
            },
          ),
           ListTile(
            leading:const Icon(Icons.star_rate),
            title:const Text("Important"),
             onTap: () {
              print("Important");
             },
          )
        ],
      ),
    );
  }
}
