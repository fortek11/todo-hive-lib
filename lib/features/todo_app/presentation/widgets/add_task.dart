import 'package:dromkart_task/features/todo_app/presentation/state/state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _key = GlobalKey<FormState>();
  String title = '';
  String description = '';
  bool datePicked = false;
  DateTime date = DateTime(1990);

  @override
  Widget build(BuildContext context) {
    final providerState = Provider.of<ProviderState>(context);
    void submitData() {
      final validate = _key.currentState!.validate();
      if (!validate) {
        return;
      }
      providerState.addTask(title, description, date);
    }

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Add Task',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (newValue) {
                        title = newValue ?? '';
                      },
                      validator: (value) {
                        if (value.toString().length == 0 || value == '') {
                          return 'Title Cannot be Empty';
                        }
                      },
                      onChanged: (value) {
                        title = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Title',
                          hintText: 'Title',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        description = newValue ?? '';
                      },
                      onChanged: (value) {
                        description = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Description',
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(!datePicked
                            ? 'No Date Selected'
                            : DateFormat.yMMMd().format(date)),
                        ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2024))
                                .then((value) {
                              date = value!;
                              setState(() {
                                datePicked = true;
                              });
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      color: Colors.deepPurple, width: 1.3))),
                          child: const Text('Select Date'),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        submitData();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 105, vertical: 10),
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
