import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/pages/about_page.dart';
import 'package:todolist/pages/home_page.dart';
import 'package:todolist/widget/change_theme_button_widget.dart';
import 'package:todolist/provider/menu_item_provider.dart';

class NavigationDrawers extends StatelessWidget { //Widget custom untuk tampilan menu dan dan pengguna 
  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 0.7, // lebar 70%
        child: AnimatedSwitcher( //Animasi ketika mengganti tema
          duration: const Duration(milliseconds: 700),
          child: Drawer( // ada beberapa elemen, foto profil pengguna, nama pengguna, menu item, dan tombol untuk mengganti tema
              key: Key(Theme.of(context).brightness.toString()),
              backgroundColor: Theme.of(context).primaryColor,
              child: ListView(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15)),
                  Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage("assets/foto.jpg"),
                          radius: 40,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text('Firmansyah Sutan Wahyu Prakosa',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 28,
                                    fontFamily: 'Archivo'))),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  buildMenuItems(context), //Daftar menu
                  Padding(
                      padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.35)),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.light_mode_outlined),
                        ChangeThemeButtonWidget(),
                        const Icon(Icons.dark_mode_outlined),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Consumer<MenuItemProvider>( //menu task dan about
        builder: (context, status, _) => Container(
          padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06),
          child: Wrap(
            children: [
              ListTile(
                tileColor: status.newStatus == 'task' ? Theme.of(context).iconTheme.color : null,
                horizontalTitleGap: -5,
                leading: const Icon(
                  Icons.event_note_outlined,
                  color: Color.fromARGB(255, 118, 218, 231),
                ),
                title: const Text(
                  'Task',
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: -10, horizontal: 10),
                onTap: () {
                  Provider.of<MenuItemProvider>(context, listen: false).changeStatus('task');
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const HomePage()),
                    (Route<dynamic> route) => false);
                },
              ),
              ListTile(
                tileColor: status.newStatus == 'about' ? Theme.of(context).iconTheme.color : null,
                leading: const Icon(
                  Icons.info_outline,
                  color: Color.fromARGB(255, 118, 218, 231),
                ),
                horizontalTitleGap: -5,
                title: const Text(
                  'About',
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: -10, horizontal: 10),
                onTap: () {
                  Provider.of<MenuItemProvider>(context, listen: false).changeStatus('about');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const AboutPage()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      );
}
