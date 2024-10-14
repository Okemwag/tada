import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tada/data/models/isar_todo.dart';
import 'package:tada/data/repository/isar_todo_repo.dart';
import 'package:tada/domain/repository/todo_repo.dart';
import 'package:tada/presentation/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);
  final isarTodoRepo  = IsarTodoRepo(isar);


  runApp(MainApp(todoRepo: isarTodoRepo,));
}

class MainApp extends StatelessWidget {
  // inject the repository into the app
  final TodoRepo todoRepo;

  const MainApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
