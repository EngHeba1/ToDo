import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_task/screens/log_in.dart';


import '../screens/settings.dart';
import '../screens/tasks.dart';
import '../screens/widgets/add_task_bottom_sheet.dart';


class HomeLayout extends StatefulWidget {
  // const HomeLayout({Key? key}) : super(key: key);
  static const String routName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  List<Widget> Tabs = [TasksTap(), SettingsTap()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
          ],
        ),
      ),
      body: Tabs[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //علشان  أحطه تحت بين الitems
      floatingActionButton: FloatingActionButton(
          shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 3)),
          onPressed: () {
            addBottomSheet();
          },
          child: Icon(Icons.add)),
    );
  }

  void addBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddTaskBottomSheet()));
  }
}
