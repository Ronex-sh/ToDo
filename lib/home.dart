import 'package:flutter/material.dart';
import 'package:todo2/data.dart';

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Text(
                      items[index].body,
                      style: TextStyle(
                          color: items[index].isCompleted
                              ? Colors.grey
                              : Colors.black),
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
                    items.add(Todo(editingController.text));

                    setState(() {});
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
}
