import 'package:dromkart_task/features/todo_app/data/db/boxes.dart';
import 'package:dromkart_task/features/todo_app/domain/entities/task_model.dart';
import 'package:dromkart_task/features/todo_app/presentation/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TaskModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<TaskModel>();
          return box.length == 0
              ? const Center(
                  child: Text(
                  'No Tasks',
                  style: TextStyle(fontSize: 18),
                ))
              : ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return TaskTile(data[index].id, data[index].title,
                        data[index].description, data[index].date, index);
                  });
        });
  }
}
