// for state management (uses Bloc)

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/domain/models/todo.dart';
import 'package:tada/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>>{
  // reference todo repository
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todos = await todoRepo.getTodos();
    emit(todos);
  }

  Future<void> addTodo(String description) async {
    final newTodo = Todo(
      id: DateTime.now().toString(),
      description: description,
    );
    await todoRepo.addTodo(newTodo);
    loadTodos();
  }
// Delete
  Future<void> delete(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();
    await todoRepo.updateTodo(updatedTodo);
    loadTodos();
  }

}