import 'package:flutter/material.dart';
import 'models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

//Scaffold => Representa um página

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];

    items.add(Item(title: "title1", done: false));
    items.add(Item(title: "title2", done: true));
    items.add(Item(title: "title3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      widget.items.add(
        Item(title: newTaskCtrl.text, done: false),
      );
      newTaskCtrl.text = "";
    });
  }

  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
        ),
        actions: <Widget>[Icon(Icons.accessibility)],
      ),
      body: ListView.builder(
          itemCount: widget.items.length, // tamanho da lista
          itemBuilder: (BuildContext ctxt, int index) {
            // como eu construo esses itens na tela?
            final item = widget.items[index];
            return Dismissible(
              child: CheckboxListTile(
                title: Text(item.title),
                value: item.done,
                onChanged: (value) {
                  setState(() {
                    item.done = value;
                  });
                },
              ),
              key: Key(item.title),
              background: Container(
                color: Colors.red.withOpacity(0.2),
                child: Text("Excluir"),
              ),
              onDismissed: (direction) {
                remove(index);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
