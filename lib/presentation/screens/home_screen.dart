import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/wigets/todo_actions_widget.dart';

import '../../models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idEditingController = TextEditingController();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  void clearControllers() {
    idEditingController.clear();
    titleEditingController.clear();
    descriptionEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todoList = context.watch<TodoProvider>().todoList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 200,
        leadingWidth: 10,
        elevation: 0,
        title: const Text(
          'Todo App',
          style: TextStyle(
            fontSize: 40,
            color: Color(0xFF1C2422),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              icon: const Icon(Icons.add_circle),
              color: const Color(0xFF04A3A3),
              iconSize: 70,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    // would be better in separate widget
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
                                textAlign: TextAlign.center,
                                controller: idEditingController,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Please enter ID",
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
                                    'SUBMIT',
                                    style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF04A3A3),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<TodoProvider>().addTodo(
                                            int.parse(
                                              idEditingController.text,
                                            ),
                                            titleEditingController.text,
                                            descriptionEditingController.text,
                                          );

                                      clearControllers();
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.white,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
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
                  },
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        // padding: const EdgeInsets.only(
        //   top: 10,
        // ),
        decoration: const BoxDecoration(
          color: Color(0xff04a3a3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),

        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 30,
                right: 40,
                bottom: 10,
                left: 40,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    todoList[index].title,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  subtitle: Text(
                    todoList[index].description,
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xFF00110F)),
                  ),
                  trailing: Container(
                    child: IconButton(
                      icon: const Icon(Icons.done),
                      color: Colors.white,
                      onPressed: () {
                        context.read<TodoProvider>().doneTodo(
                              todoList[index].id,
                              !todoList[index].isDone,
                            );
                      },
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: todoList[index].isDone
                          ? const Color(0xFF0ecc57)
                          : const Color(0xFF6c807a),
                    ),
                  ),
                  onLongPress: () {
                    context.read<TodoProvider>().getTodo(
                          todoList[index].id,
                        );

                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        // should use some widget
                        return const TodoActionsWidget();
                      },
                    );
                  },
                ),
              ),
            );
          },
          itemCount: context.watch<TodoProvider>().todoList.length,
          key: UniqueKey(),
        ),
      ),
    );
  }
}
