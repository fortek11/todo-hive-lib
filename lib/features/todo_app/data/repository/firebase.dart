import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/task_model.dart';
import '../db/boxes.dart';

class FirebaseRepo {
  static Future deleteAllElements() async {
    final dbData = await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!);
    var snapshots = await dbData.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  static Future<void> fetchTasks() async {
    final box = Boxes.getData();
    box.clear();
    await FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .get()
        .then(
          (value) => value.docs.forEach((element) {
            Map<String, dynamic> data = element.data();

            //recently added task's at the top
            final singleTask = TaskModel(
              id: element.reference.id,
              title: data['title'],
              description: data['description'],
              date: data['date'].toDate(),
            );

            box.add(singleTask);
          }),
        )
        .onError((error, stackTrace) {})
        .then((value) {});
    print("HIVE DB : ");
    print(box.values);
  }
}
