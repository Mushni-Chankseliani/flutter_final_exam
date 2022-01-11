import 'package:dio/dio.dart';

import '../models/todo_model.dart';

class TodoRepository {
  Dio dio = Dio();
  List<Todo> todoList = [];
  static const baseUrl = 'http://10.0.2.2:8080/';

  Future<List<Todo>> getList() async {
    final response = await dio.get(baseUrl + 'todos');
    if (response.statusCode == 200) {
      todoList.clear();
      response.data.forEach((item) {
        Todo todo = Todo.fromJson(item);
        todoList.add(todo);
      });
    }

    return todoList;
  }

  Future<Todo> getTodo(id) async {
    final response = await dio.get(baseUrl + id);
    late Todo todo;
    if (response.statusCode == 200) {
      todo = Todo.fromJson(response.data);
    }

    return todo;
  }

  Future<void> addTodo(id, title, description) async {
    Todo todo = Todo(
      id: id,
      title: title,
      description: description,
      isDone: false,
    );

    final response = await dio.post(
      baseUrl + 'add-todo',
      data: todo.intoJson(),
    );

    if (response.statusCode == 200) {
      todoList.add(Todo.fromJson(response.data));
    }
  }

  Future<void> removeTodo(id) async {
    await dio.delete(baseUrl + 'delete-todo/' + id.toString());
  }

  Future<void> updateTodo(id, title, description, isDone) async {
    Todo data = Todo(
      id: id,
      title: title,
      description: description,
      isDone: isDone,
    );

    final response = await dio.put(
      baseUrl + 'update-todo',
      data: data.intoJson(),
    );

    if (response.statusCode == 200) {
      var elementIndex = todoList.indexWhere((item) => item.id == id);
      todoList[elementIndex] = data;
    }
  }

  Future<void> doneTodo(id, isDone) async {
    final response = await dio.patch(
      baseUrl + 'todo-done/' + id.toString(),
      data: {'isDone': isDone},
    );

    if (response.statusCode == 200) {
      var elementIndex = todoList.indexWhere((item) => item.id == id);
      todoList[elementIndex].isDone = isDone;
    }
  }
}
