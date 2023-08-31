import 'package:dromkart_task/features/todo_app/presentation/screens/user_profile.dart';
import 'package:dromkart_task/features/todo_app/presentation/state/state.dart';
import 'package:dromkart_task/features/todo_app/presentation/widgets/tasks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/add_task.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerState = Provider.of<ProviderState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Task'),
        actions: [
          IconButton(
              onPressed: () async {
                await providerState.refreshData(context);
              },
              icon: Icon(Icons.rotate_left_rounded)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, UserProfile.routeName);
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: TaskList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              context: context,
              builder: (_) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [AddTask()],
                    ),
                  ),
                );
              });
        },
        label: Text('Add Task'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
