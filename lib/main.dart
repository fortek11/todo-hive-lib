import 'package:dromkart_task/core/redirect.dart';
import 'package:dromkart_task/features/todo_app/presentation/screens/user_profile.dart';
import 'package:dromkart_task/features/todo_app/presentation/state/state.dart';
import 'package:dromkart_task/features/todo_app/presentation/widgets/task_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'features/todo_app/domain/entities/task_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderState(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Redirect(),
        routes: {
          Redirect.routeName:(context) => Redirect(),
          TaskDetail.routeName: (context) => TaskDetail(),
          UserProfile.routeName: (context) => UserProfile()
        },
      ),
    );
  }
}
