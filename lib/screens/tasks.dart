import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/models/task_model.dart';
import 'package:todo_task/provider/setting_provider.dart';
import 'package:todo_task/screens/widgets/task_item.dart';

import '../firebase/firebase_function.dart';
import 'log_in.dart';


class TasksTap extends StatefulWidget {
  const TasksTap({Key? key}) : super(key: key);

  @override
  State<TasksTap> createState() => _TasksTapState();
}

class _TasksTapState extends State<TasksTap> {
  DateTime select = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<SettingProvid>(context);
    return Scaffold(
      appBar:AppBar(
          title: pro.language == 'en'
      ? Text(
        "HI ${pro.myUser?.name}",
        style: GoogleFonts.novaSquare(),
      )
          : Text("أهلا  ${pro.myUser!.name}"
      ,
      style: GoogleFonts.cairo(),
    ),
          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    )
    ),
          actions: [
      Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
          onTap: () {
           // FirebaseAuth.instance.signOut();
            pro.logOut();
            Navigator.pushReplacementNamed(context, LogIn.routName);
          },
          child: Icon(Icons.logout)),
    )
    ],

    toolbarHeight: 50.h),
      body:Column(
        children: [
          DatePicker(
            DateTime.now(),
            height: 100,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            onDateChange: (date) {
              // New date selected
              setState(() {
                select = date;
              });
            },
          ),
          StreamBuilder(
            stream: FirebaseFunctions.getTasksFromFireStore(select),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return Center(
                  child: Column(
                    children: [
                      pro.language=="en"
                          ? Text("Something went wrong",
                          style: GoogleFonts.novaSquare())
                          : Text("عذرً, حدث خطأ", style: GoogleFonts.cairo()),
                      ElevatedButton(
                          onPressed: () {},
                          child: pro.language == "en"
                              ? Text(
                            "Try again",
                            style: GoogleFonts.novaSquare(),
                          )
                              : Text("حاول مجددًا", style: GoogleFonts.cairo()))
                    ],
                  ),
                );
              }

              // List<TaskModel>tasks=snapshot.data?.docs.map((doc) => doc.data()).toList()??[];
              List<TaskModel> tasks = snapshot.data?.docs
                  .map((docs) => docs.data(),)
             //.where((task) => !task.status)
              .toList() ??
                  [];
              if (tasks.isEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    pro.language == "en"
                        ? Text(
                      "No Tasks Yet",
                      style: GoogleFonts.novaSquare(fontSize: 30.sp),
                    )
                        : Text(
                      "لا يوجد مهام بعد",
                      style: GoogleFonts.cairo(fontSize: 30.sp),
                    ),
                    Icon(Icons.list, size: 70)
                  ],
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return TaskItem(tasks[index]);
                  },
                  itemCount: tasks.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 8.h,
                    );
                  },
                ),
              );
            },)
        ],
      ) ,
    );
  }
}
