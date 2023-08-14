import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../firebase/firebase_function.dart';
import '../../models/task_model.dart';
import '../../styles/app_colors.dart';




class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  //const AddTaskBottomSheet({Key? key}) : super(key: key);
  DateTime selected = DateUtils.dateOnly(DateTime.now());
  var tasktitelController=TextEditingController();
  var taskDescibtionController=TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add New Task",
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
                    TaskModel task=TaskModel(id: FirebaseAuth.instance.currentUser!.uid,
                        title: tasktitelController.text,
                        description:taskDescibtionController.text ,
                        date: selected.millisecondsSinceEpoch,
                        status: false, userID:FirebaseAuth.instance.currentUser!.uid,
                    dateOfTime: DateTime.now().millisecondsSinceEpoch);
                    FirebaseFunctions.addTaskToFirestore(task).then((value) => Navigator.pop(context));
                 }
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  Future<void>showsDate() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //التاريخ أول ما يفتح dialog
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 360)));
    if (selectedDate != null) {
      selected = selectedDate;
      setState(() {});
    }
  }
}
