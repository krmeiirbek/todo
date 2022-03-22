import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/services/authentication.dart';
import 'package:todo/services/todo.dart';
import 'package:todo/todos/todos.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to Todo App'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context),
        )..add(RegisterServicesEvent()),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessfulLoginState) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodosPage(username: state.username)));
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: username,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => BlocProvider.of<HomeBloc>(context)
                          .add(LoginEvent(username.text, password.text)),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
