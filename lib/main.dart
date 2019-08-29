import 'package:flutter/material.dart';
import 'package:scopedmodeldemo/scoped-models/todos.dart';
import 'package:scoped_model/scoped_model.dart';
import './todos_page.dart';
import './scoped-models/users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final TodosModel model = TodosModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: UsersModel(),
      child: ScopedModel(
        model: model,
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(model),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final TodosModel model;

  MyHomePage(this.model);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    // Initialize the ToDo list
    widget.model.fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String username =
        ScopedModel.of<UsersModel>(context, rebuildOnChange: true).getUsername;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, $username'),
      ),
      body: TodosPage(),
      floatingActionButton: ScopedModelDescendant<TodosModel>(
        builder: (BuildContext context, Widget child, TodosModel model) {
          return FloatingActionButton(
            onPressed: () {
              _addTodo(context, model);
            },
            tooltip: 'Add',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }

  void _addTodoInList(BuildContext context, TodosModel model) {
    String val = _textFieldController.text;

    model.add(val);

    _textFieldController.clear();

    Navigator.pop(context);
  }

  void _addTodo(BuildContext context, TodosModel model) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add New Todo'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Enter title"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  _textFieldController.clear();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('ADD'),
                onPressed: () {
                  _addTodoInList(context, model);
                },
              )
            ],
          );
        });
  }
}
