// Provides cubit to the UI
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/domain/repository/todo_repo.dart';
import 'todo_view.dart';
import 'package:tada/presentation/todo_cubit.dart';

class TodoPage extends StatelessWidget {
 final TodoRepo todoRepo;

 const TodoPage({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => TodoCubit(todoRepo),
      child: const TodoView(),
    );
  }
}