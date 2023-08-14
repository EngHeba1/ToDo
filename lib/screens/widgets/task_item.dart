
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/models/task_model.dart';

import '../../firebase/firebase_function.dart';
import '../../styles/app_colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../edit_task.dart';
import '../updat_task.dart';


class TaskItem extends StatelessWidget {
  TaskModel task;
  TaskItem( this.task);


  // const TaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  FirebaseFunctions.deleteTask(task.id);
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(12.r),
              ),
            ],
          ),
          endActionPane: //task.status
          true ? ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.4,
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                 Navigator.pushNamed(context, EditTask.rouitName,arguments: task);
                },
                backgroundColor: AppCloros.lightColor,
                icon: Icons.edit,
                label: 'Edit',
                borderRadius: BorderRadius.circular(12.r),
              ),
            ],
          ) : null,
        child: Card(
          elevation: 12,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.transparent)),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 100,
                width: 5,
                margin: EdgeInsets.only(bottom: 6, top: 6, left: 12),
                color:  task.status?AppCloros.greenColor:AppCloros.lightColor,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .03,
              ),
              Column(
                children: [
                  Text(
                    task.title,
                    style:Theme.of(context).
              textTheme.bodyLarge?.copyWith(color:task.status?AppCloros.greenColor:AppCloros.lightColor),
                  ),
                  Text(
                   task.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Spacer(),
              task.status?Text("Done!",style: Theme.of(context).
              textTheme.bodyLarge?.copyWith(color: AppCloros.greenColor),):
              InkWell(
                onTap: () {
                  task.status=true;    //task is done
                  FirebaseFunctions.updateTask( task);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                    decoration: BoxDecoration(
                        color: AppCloros.lightColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 30,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}


