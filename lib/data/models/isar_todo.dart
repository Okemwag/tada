/*
ISAR TO-DO models

The IsarTodo model is a representation of the Todo model in the Isar database. It is a simple class that contains the same fields as the Todo model. The IsarTodo model is used to interact with the Isar database and perform CRUD operations on the Todo model.

*/

import 'package:isar/isar.dart';
import 'package:tada/domain/models/todo.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id? id; 
  late String description;
  late bool isCompleted;

  // Convert IsarTodo to Todo
  Todo toDomain() {
    return Todo(
      id: id?.toString() ?? '', 
      description: description,
      isCompleted: isCompleted,
    );
  }

  static TodoIsar fromDomain(Todo todo) {
    final todoIsar = TodoIsar()
      ..description = todo.description
      ..isCompleted = todo.isCompleted;

    if (todo.id.isNotEmpty) {
      todoIsar.id =
          int.tryParse(todo.id); 
    }

    return todoIsar;
  }
}
