//List<Todo> items=[Todo.all(1, 'hello 1', false),Todo.all(2, 'hello 2', false),Todo.all(3, 'hello 3', false)];
List<Todo> items = []
  ..add(Todo.all(1, 'hello 1', false))
  ..add(Todo.all(2, 'hello 2', false))
  ..add(Todo.all(3, 'hello 3', false))
  ..add(Todo('hello 4'));

class Todo {
  int _id;
  String _body;
  bool _isCompleted = false;

  Todo(this._body);
  Todo.all(this._id, this._body, this._isCompleted);

  bool get isCompleted => _isCompleted;

  set isCompleted(bool value) {
    _isCompleted = value;
  }

  String get body => _body;

  set body(String value) {
    _body = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
