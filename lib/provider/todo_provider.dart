import 'package:flutter/cupertino.dart';
import 'package:todo_app/repository/todo_repository.dart';

import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  TodoRepository todoRepository = TodoRepository();
  late Todo todo;
  List<Todo> todoList = [];

  TodoProvider() {
    getList();
  }

  Future<void> getList() async {
    todoList = (await todoRepository.getList());
    notifyListeners();
  }

  Future<void> getTodo(int id) async {
    final index = todoList.indexWhere((element) => element.id == id);
    if (index >= 0) {
      todo = todoList[index];
    }

    // do I need to get data from server? hmmm
    // todo = (await todoRepository.getTodo(id));
    notifyListeners();
  }

  Future<void> addTodo(int id, String name, String description) async {
    await todoRepository.addTodo(id, name, description);
    getList();
  }

  Future<void> removeTodo(id) async {
    await todoRepository.removeTodo(id);
    getList();
  }

  Future<void> updateTodo(id, name, description, done) async {
    await todoRepository.updateTodo(id, name, description, done);
    getTodo(id);
    getList();
  }

  Future<void> doneTodo(id, done) async {
    await todoRepository.doneTodo(id, done);
    getTodo(id);
    getList();
  }
}
