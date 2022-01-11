import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todo_provider.dart';
import 'package:todo_app/wigets/todo_actions_widget.dart';
import 'package:todo_app/wigets/todo_add_widget.dart';

import '../../models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _formKey = GlobalKey<FormState>();
  // TextEditingController idEditingController = TextEditingController();
  // TextEditingController titleEditingController = TextEditingController();
  // TextEditingController descriptionEditingController = TextEditingController();
  // void clearControllers() {
  //   idEditingController.clear();
  //   titleEditingController.clear();
  //   descriptionEditingController.clear();
  // }

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
                    return const TodoAddnWidget();
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
