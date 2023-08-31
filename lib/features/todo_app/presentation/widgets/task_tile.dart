import 'package:dromkart_task/features/todo_app/presentation/state/state.dart';
import 'package:dromkart_task/features/todo_app/presentation/widgets/task_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final String id;
  final int index;

  TaskTile(
    this.id,
    this.title,
    this.description,
    this.date,
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    final providerState = Provider.of<ProviderState>(context);
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(TaskDetail.routeName, arguments: index);
        },
        child: ListTile(
          title: Text(title),
          subtitle: Text(
            'Date: ${DateFormat.yMMMd().format(date)}',
          ),
          leading: Text('${index + 1}. '),
          trailing: IconButton(
              onPressed: () {
                providerState.deleteTask(index);
              },
              icon: Icon(Icons.delete)),
        ),
      ),
    );
  }
}
