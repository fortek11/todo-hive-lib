import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dromkart_task/features/todo_app/data/repository/firebase.dart';
import 'package:dromkart_task/features/todo_app/data/db/boxes.dart';
import 'package:dromkart_task/features/todo_app/domain/entities/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderState with ChangeNotifier {
  final box = Boxes.getData();
  final cred = FirebaseAuth.instance.currentUser!.email;
  void addTask(String title, String description, DateTime date) {
    final newTask = TaskModel(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        date: date);
    box.add(newTask);

    newTask.save();
    // print(box.get(box.length - 1)!.title);
  }

  void deleteTask(int index) {
    box.deleteAt(index);
  }

  TaskModel selectedTask(int index) {
    final selectedTask = box.getAt(index);
    return selectedTask!;
  }

  Future refreshData(BuildContext context) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Updating on database...')));
    final dbData = await FirebaseFirestore.instance.collection(cred!);
    final taskList = box.values.toList();

    FirebaseRepo.deleteAllElements().then((value) async {
      if (box.length == 0) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Updated Successfuly')));
      }
      for (int i = 0; i < box.length; i++) {
        final selectedTask = taskList[i];

        await dbData.doc(selectedTask.id).set({
          'title': selectedTask.title,
          'description': selectedTask.description,
          'date': selectedTask.date
        }).then((value) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Updated Successfuly')));
        });
      }
    });
  }
}
