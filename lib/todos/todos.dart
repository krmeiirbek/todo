import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/services/todo.dart';

import 'bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list'),
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))..add(LoadTodosEvent(username)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                children: state.tasks
                    .map((e) => ListTile(
                          title: Text(e.task),
                  trailing: Checkbox(value: e.complete, onChanged: (value) {  },),
                        ))
                    .toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
