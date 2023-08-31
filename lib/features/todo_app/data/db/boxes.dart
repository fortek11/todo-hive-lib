import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dromkart_task/features/todo_app/domain/entities/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<TaskModel> getData() {
    return Hive.box<TaskModel>('tasks');
  }

  static Future fetchData() async {
    final box = getData();
    box.clear();
    final dbData = await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!);
    var snapshots = await dbData.get();

    dbData.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.id);
        final newTask = TaskModel(
            id: doc.id,
            title: doc['title'],
            description: doc['description'],
            date: doc['date']);
        getData().add(newTask);
      });
    });

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  static Future<List<DocumentSnapshot>> fetchTasks() async {
    final result = await FirebaseFirestore.instance.collection('users').get();
    return result.docs;
  }
}
