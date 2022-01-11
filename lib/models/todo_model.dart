class Todo {
  int id;
  String title;
  String description;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> jsonData) {
    return Todo(
      id: jsonData['id'],
      title: jsonData['todo'],
      description: jsonData['description'],
      isDone: jsonData['isDone'] ?? false,
    );
  }

  Map<String, dynamic> intoJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['id'] = id;
    jsonData['todo'] = title;
    jsonData['description'] = description;
    jsonData['isisDone'] = isDone;
    return jsonData;
  }
}
