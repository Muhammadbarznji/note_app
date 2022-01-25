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
              "Note App",
              style: Theme.of(context).textTheme.headline1,
            ),
            decoration: const BoxDecoration(
              color: Colors.amber,
///add image to header
/*              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/cover.jpg"),
              ),*/
            ),
          ),
          const ListTile(
            leading:Icon(Icons.home),
            title: Text("Home"),
          ),
          const ListTile(
            leading: Icon(Icons.star_rate),
            title: Text("Important"),
          )
        ],
      ),
    );
  }
}
