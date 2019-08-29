import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';
import '../models/Todo.dart';

class TodosModel extends Model {
  List<Todo> _todos = [];

  List<Todo> get todos {
    return List.from(_todos);
  }

  void add(String val) {

    final newTodo = {"title": val, "id": Uuid().v4()};

    _todos.insert(0, Todo.fromJson(newTodo));

    notifyListeners();
  }

  void remove(int index){
    _todos.removeAt(index);
    notifyListeners();
  }

  void fetchTodos() {
    // In this method you actualyy perform any network related job
    // Like if your fetching the list from your server
    // This will initialize out state at the start of the application
    final List<Map<String, dynamic>> todos = [
      {"title": "tweet milk", "done": false, "id": Uuid().v4()},
      {"title": "try to clean needle work", "done": false, "id": Uuid().v4()},
      {"title": "help crash fishing rod", "done": false, "id": Uuid().v4()},
      {"title": "forget fishing rod", "done": false, "id": Uuid().v4()},
      {"title": "pretend to pick chess", "done": false, "id": Uuid().v4()},
      {"title": "clean laptop", "done": false, "id": Uuid().v4()},
      {"title": "avoid distant relatives", "done": false, "id": Uuid().v4()},
      {"title": "pick needle work", "done": false, "id": Uuid().v4()},
      {"title": "try to sell fishing rod", "done": false, "id": Uuid().v4()},
      {"title": "avoid forgeting milk", "done": false, "id": Uuid().v4()},
      {"title": "exercise Italian", "done": false, "id": Uuid().v4()},
      {"title": "buy knife", "done": false, "id": Uuid().v4()},
    ];

    todos.forEach((todoMap)=> _todos.add(Todo.fromJson(todoMap)));

    notifyListeners();
  }
}
