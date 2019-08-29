import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './models/Todo.dart';
import 'scoped-models/todos.dart';

class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodosModel>(
      builder: (BuildContext context, Widget child, TodosModel model) {
        print(child.toString());
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            Todo todo = model.todos[index];

            return Dismissible(
              key: Key(todo.id),
              direction: DismissDirection.startToEnd,
              child: ListTile(
                title: Text(todo.title),
                leading: Icon(Icons.check),
              ),
              background: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10.0),
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (DismissDirection direction) =>
                  _onDismissed(direction, index, model),
            );
          },
          itemCount: model.todos.length,
        );
      },
    );
  }

  void _onDismissed(
      DismissDirection direction, int todoIndex, TodosModel model) {
    if (direction == DismissDirection.startToEnd) {
      model.remove(todoIndex);
    }
  }
}
