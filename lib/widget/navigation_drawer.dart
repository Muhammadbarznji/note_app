import 'package:flutter/material.dart';
import 'package:note_app_database/sceeen/home_screen.dart';
import 'package:note_app_database/sceeen/important_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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
            leading: const Icon(
              Icons.home,
              color: Colors.black,
              size: 40,
            ),
            title: const Text("Home"),
            onTap: () async {
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.star_rate,
              color: Colors.amber,
              size: 40,
            ),
            title: const Text("Important"),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ImportantScreen()));
            },
          ),
        ],
      ),
    );
  }
}
