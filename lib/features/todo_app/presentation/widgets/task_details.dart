import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../state/state.dart';

class TaskDetail extends StatelessWidget {
  static const routeName = 'taskdetail';
  @override
  Widget build(BuildContext context) {
    final providerState = Provider.of<ProviderState>(context);
    final index = ModalRoute.of(context)!.settings.arguments as int;
    final selectedTask = providerState.selectedTask(index);
    return Scaffold(
      appBar: AppBar(
        title: Text('Task ${index + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " Title: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child:
                    Text(selectedTask.title, style: TextStyle(fontSize: 18))),
            Text(
              " Description: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(selectedTask.description,
                    style: TextStyle(fontSize: 18))),
            Text(
              " Date and Time: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: Text('${DateFormat.yMMMd().format(selectedTask.date)}',
                    style: TextStyle(fontSize: 18))),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
