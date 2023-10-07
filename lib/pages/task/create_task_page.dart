import 'package:flutter/material.dart';
import 'package:flutter_desempenho/components/inputs/text_form_field_add_task.dart';
import 'package:flutter_desempenho/components/tasks/temporary_task_list.dart';
import 'package:flutter_desempenho/constants/app_colors.dart';
import 'package:flutter_desempenho/entities/task_entity.dart';
import 'package:flutter_desempenho/functions/strings/remove_all_spaces.dart';
import 'package:flutter_desempenho/services/isar/isar_service.dart';
import 'package:flutter_desempenho/store/temporary_task_store.store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _taskBodyController = TextEditingController();
  final isar = IsarService();
  
  @override
  Widget build(BuildContext context) {
    final taskStore = Provider.of<TemporaryTaskStore>(context);
    return Scaffold(appBar:  AppBar(
      leading: IconButton(
            icon: Icon(Icons.list_sharp, color: AppColors.orangePrimary, size: 30,),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Crie Sua Tarefa',
            style: TextStyle(color: AppColors.whitePrimary),
          ),
        
        ],
      ),
          backgroundColor: AppColors.blackPrimary,
          actions: [
            IconButton(
              tooltip: 'Salvar Tarefas',
              icon: Icon(
                  Icons.save,
                  color: AppColors.orangePrimary,
                  size: 25.0),
              onPressed: (){
                isar.saveMultipleTask(taskStore.tasks);
              }
          ),
          ],), body: SingleChildScrollView(
            child: Container(
              color: AppColors.blackSecondary,
                padding: EdgeInsets.all(10),
                height: 3000,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            width: 250,
                            height: 40,
                            child: TextFormFieldAddTask(
                                taskBodyController: _taskBodyController)),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (removeAllSpaces(
                                      textString: _taskBodyController.text) !=
                                  '') {
                                taskStore.addTask(TaskEntity()..content = _taskBodyController.text);
                              }

                              _taskBodyController.text = '';
                            },
                            child: Icon(Icons.add, color: AppColors.orangePrimary,)),
                      ],
                    ),
                    Expanded(
                      child: Observer(builder: (_) {
                        return ListView.builder(
                          // shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: taskStore.tasks.length,
                          itemBuilder: (context, index) {
                            TaskEntity task_current = taskStore.tasks[index];
                            return TemporaryTaskList(
                                task_current: task_current, indexTask: index,);
                          },
                        );
                      }),
                    ),
                  ],
                ))));
  }
}