// Responsible for the UI of the todo list
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/domain/models/todo.dart';
import 'package:tada/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // Show a dialog box to add a new todo
  void _ShowAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Enter your todo',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              todoCubit.addTodo(textController.text);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
      );  
  }

  @override
  Widget build(BuildContext context) {


    // final todoCubit = context.read<TodoCubit>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _ShowAddTodoBox(context),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.description),
                trailing: IconButton(
                  icon: Icon(todo.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
                  onPressed: () => context.read<TodoCubit>().toggleCompletion(todo),
                ),
                onLongPress: () => context.read<TodoCubit>().delete(todo),
              );
            },
          );
        },
      ),

    );
  }
}