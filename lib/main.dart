import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          title: const Center(
            child: Text(
              'To-do list',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: const ToDoState(),
      ),
    );
  }
}

class ToDoState extends StatefulWidget {
  const ToDoState({super.key});

  @override
  State<ToDoState> createState() => _ToDoStateState();
}

class _ToDoStateState extends State<ToDoState> {

  final myController = TextEditingController();
  final List<Tarefa> myTasksList = [];

  void _saveTaskInput(){
    if(myController.text.isNotEmpty){
      setState(() {
        myTasksList.add(Tarefa(name: myController.text));
      });
      myController.clear();
    }
  }

  void _deleteTask(int index){
    setState(() {
      myTasksList.removeAt(index);
    });
  }

  void _completeTask(int index){
    if(myTasksList[index].concluido == false){
      setState(() {myTasksList[index].concluido = true;});
    }else{
      setState(() {myTasksList[index].concluido = false;});
    }
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 30,
              child: TextField(
                controller: myController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Input test',
                ),
              ),
            ),
            IconButton(onPressed: _saveTaskInput, icon: const Icon(Icons.add), color: Colors.blue,),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: myTasksList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  myTasksList[index].name,
                  style: TextStyle(color: myTasksList[index].concluido ? Colors.green : Colors.black,),),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () => _deleteTask(index), icon: const Icon(Icons.delete, color: Colors.red,)),
                    IconButton(onPressed: () => _completeTask(index), icon: Icon(myTasksList[index].concluido ? Icons.check_box : Icons.check_box_outline_blank,)),
                  ],
                )
              );
            },
          )
        )
      ],
    );
  }
}

class Tarefa{
  Tarefa({required this.name, this.concluido = false});

  final String name;
  bool concluido;
}