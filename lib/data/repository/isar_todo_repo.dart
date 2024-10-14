/*
Handles the todo data operations using the Isar database, e.g., getTodos, addTodo, updateTodo, deleteTodo.
*/

import 'package:isar/isar.dart';
import 'package:tada/data/models/isar_todo.dart';
import 'package:tada/domain/models/todo.dart';
import 'package:tada/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;

  IsarTodoRepo(this.db);

  // Get all todos
  @override
  Future<List<Todo>> getTodos() async {
    final todos = await db.todoIsars.where().findAll();

    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  // Add a new todo
  @override
  Future<void> addTodo(Todo newTodo) {
    final todoIsar = TodoIsar.fromDomain(newTodo);
    return db.writeTxn(() async {
      await db.todoIsars.put(todoIsar); 
    });
  }

  // Update a todo
  @override
  Future<void> updateTodo(Todo todo) {
    final todoIsar = TodoIsar.fromDomain(todo);
    return db.writeTxn(() async {
      await db.todoIsars.put(todoIsar); 
    });
  }

  // Delete a todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    if (todo.id.isNotEmpty) {
      final todoIsar = TodoIsar.fromDomain(todo);
      await db.writeTxn(() async {
        await db.todoIsars
            .delete(todoIsar.id!); 
      });
    }
  }
}
