import 'package:flutter/material.dart';
import 'package:flutter_desempenho/entities/task_entity.dart';
import 'package:flutter_desempenho/models/task_model.dart';

// ignore: must_be_immutable
class TemporaryTaskList extends StatelessWidget {
  TaskEntity task_current;
  TemporaryTaskList({super.key, required this.task_current});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 108, 47, 199),
      elevation: 2, // Sombra do card
      margin: EdgeInsets.only(top: 10), // Margem ao redor do card
      child: Padding(
        padding: EdgeInsets.all(16), // Preenchimento interno do card
        child: Text(
          task_current.content,
          style: TextStyle(
            color: Colors.white, // Cor do texto
            fontSize: 16, // Tamanho da fonte
          ),
        ),
      ),
    );
  }
}
