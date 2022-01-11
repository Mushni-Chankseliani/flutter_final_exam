import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';

import '../provider/todo_provider.dart';

class TodoUpdatenWidget extends StatefulWidget {
  const TodoUpdatenWidget({Key? key}) : super(key: key);

  @override
  State<TodoUpdatenWidget> createState() => _TodoUpdatenWidget();
}

class _TodoUpdatenWidget extends State<TodoUpdatenWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idEditingController = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  void clearControllers() {
    idEditingController.clear();
    titleEditingController.clear();
    descriptionEditingController.clear();
  }

  void setControllers(Todo item) {
    idEditingController.text = item.id.toString();
    titleEditingController.text = item.title;
    descriptionEditingController.text = item.description;
  }

  @override
  Widget build(BuildContext context) {
    Todo todo = context.watch<TodoProvider>().todo;
    setControllers(todo);

    return Container(
      color: const Color(0xFF6CB4B1),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          right: 40.0,
          bottom: 20,
          left: 40,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // user can't update item id
                enabled: false,
                textAlign: TextAlign.center,
                controller: idEditingController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: "Please enter ID",
                  hintStyle: TextStyle(
                    color: Color(0xFFDBFFF4),
                    fontSize: 22,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter Valid Value';
                  } else if (double.tryParse(val) == null) {
                    return 'ID should be number';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: titleEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: "Please enter title",
                  hintStyle: TextStyle(
                    color: Color(0xFFDBFFF4),
                    fontSize: 22,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter Valid Value';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: descriptionEditingController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: "Please enter Description",
                  hintStyle: TextStyle(
                    color: Color(0xFFDBFFF4),
                    fontSize: 22,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null) {
                    return 'Enter Valid Value';
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                child: TextButton(
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      letterSpacing: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF04A3A3),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<TodoProvider>().updateTodo(
                            int.parse(
                              idEditingController.text,
                            ),
                            titleEditingController.text,
                            descriptionEditingController.text,
                            todo.isDone,
                          );

                      clearControllers();
                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          13.0,
                        ),
                        // side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
