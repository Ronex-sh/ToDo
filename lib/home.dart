import 'package:flutter/material.dart';
import 'package:todo2/data.dart';

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _todoListView,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewItem();
        },
        child: Icon(Icons.library_add),
      ),
    );
  }

  Widget get _todoListView {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Checkbox(
                      value: items[index].isCompleted,
                      onChanged: (bool state) {
                        setState(() {
                          items[index].isCompleted = state;
                        });
                      },
                    )),
                Expanded(
                    flex: 7,
                    child: GestureDetector(
                      onDoubleTap: () {
                        _updateItem(items, index);
                      },
                      child: Text(
                        items[index].body,
                        style: TextStyle(
                            color: items[index].isCompleted
                                ? Colors.grey
                                : Colors.black),
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                      child: Icon(Icons.delete),
                      onTap: () {
                        _delete(items, index);
                      },
                    ))
              ],
            ),
          );
        });
  }

  _delete(List<Todo> items, int index) {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text('are you shore ??'),
            content: Text('Delete :${items[index].body}'),
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      items.removeAt(index);
                    });
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete_forever),
                  label: Text('Delete')),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel),
                  label: Text('Cancle')),
            ],
          );
        });
  }

  void _addNewItem() {
    TextEditingController editingController = TextEditingController();
    showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text('Add Item'),
            content: Column(
              children: <Widget>[
                Text('Ad new item then press save '),
                TextField(
                  controller: editingController,
                )
              ],
            ),
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    if (editingController.text.isNotEmpty) {
                      items.add(Todo(editingController.text));
                      snack_bar('you add item');

                      setState(() {});
                    }

                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.save),
                  label: Text('save')),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel),
                  label: Text('cancel')),
            ],
          );
        });
  }

  void _updateItem(List<Todo> items, int index) {
    TextEditingController editingController =
        TextEditingController(text: items[index].body);
    showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Text('update Item'),
            content: Column(
              children: <Widget>[
                Text('update this item:\n${items[index].body}'),
                TextField(
                  controller: editingController,
                )
              ],
            ),
            actions: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    if (editingController.text.isNotEmpty) {
                      items[index].body = editingController.text;
                      snack_bar('you update item to :${items[index].body} ');

                      setState(() {});
                    }

                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.update),
                  label: Text('update')),
              FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel),
                  label: Text('cancel')),
            ],
          );
        });
  }

  void snack_bar(String str) {
    SnackBar snackBar = SnackBar(
      content: Text(str),
    );
    _globalKey.currentState.showSnackBar(snackBar);
  }
}
