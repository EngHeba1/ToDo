import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/models/task_model.dart';

import '../firebase/firebase_function.dart';
import '../provider/setting_provider.dart';
import '../styles/app_colors.dart';

class EditTask extends StatefulWidget {
  //const EditTask({super.key});
  static const String rouitName="Edit Task";

  @override
  State<EditTask> createState() => _EditTaskState();

}

class _EditTaskState extends State<EditTask> {
  var formKey= GlobalKey<FormState>();

  var tasktitelController=TextEditingController();

  var taskDescibtionController=TextEditingController();

   DateTime selected=DateUtils.dateOnly(DateTime.now());
  late TaskModel task;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       task=ModalRoute.of(context)?.settings.arguments as TaskModel;
      tasktitelController.text=task.title;
      taskDescibtionController.text=task.description;
      selected=DateTime.fromMillisecondsSinceEpoch(task.date);
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<SettingProvid>(context);
    var screenSize=MediaQuery.of(context);



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title:Text("To Do List",style: TextStyle(fontSize:25 ,fontWeight: FontWeight.bold)),
          elevation: 0),
    body: Column(children: [
      Stack(children: [
        Container(color:  AppCloros.lightColor,height:screenSize.size.height*.1 ,),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: screenSize.size.height*.04),
            height: screenSize.size.height*.7,width: screenSize.size.width*.9,
            decoration: BoxDecoration( color: Colors.white,
          borderRadius: BorderRadius.circular(20),
            ),child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(pro.language=="en"?
                    "Edit Task":"التعديل في المهمه",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                  TextFormField(
                      controller:tasktitelController ,
                      validator: (value) {
                        if (value == null) {
                          return "Please Enter Text";
                        } else if (value.length < 10) {
                          return "at leatse 10 character";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next, //هيخلص وينقل عليالي بعده
                      decoration: InputDecoration(
                          label: Text("Task Titel"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)))),
                  SizedBox(height: 15),
                  TextFormField(
                      controller:taskDescibtionController ,
                      maxLines: 3,
                      decoration: InputDecoration(
                          label: Text("Task Describtion"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)))),
                  SizedBox(height: 15),
                  Container(
                      width: double.infinity,
                      child: Text(
                        "Select Date",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.start,
                      )),
                  InkWell(
                    onTap: () {
                      showsDate();
                    },
                    child: Text(
                      selected.toString().substring(1,10),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color:  AppCloros.lightColor),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // يعني مفيشvalidation error هيكمل
                          task.title=tasktitelController.text;
                          task.description=taskDescibtionController.text;
                          task.date= selected.millisecondsSinceEpoch ;
                          FirebaseFunctions.updateTask(task);
                          FirebaseFunctions.getTasksFromFireStore(selected);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Save changes"))
                ],
              ),
            ),
          )),
        )
      ],)
    ])
    );
  }

  Future<void>showsDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: selected, //التاريخ أول ما يفتح dialog
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 360)));
    if (selectedDate != null) {
      selected = selectedDate;
      setState(() {});
    }
  }
}
