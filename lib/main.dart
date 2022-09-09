import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Myapp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Myapp extends StatefulWidget {
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  List todos = List.empty(growable: true);
  String inptask = "";
  String inptdesc = "";

  @override
  Widget build(BuildContext context) {
    String time = "";
    return Scaffold(
      /////////////////////////
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 138, 189, 231),
        title: Text(
          "TO DO",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      ////////////////////////////////
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(todos[index]),
            onDismissed: (DismissDirection direction) {
              setState(() {
                todos.removeAt(index);
              });
            },
            child: Card(
              elevation: 10,
              color: Color.fromARGB(255, 208, 221, 231),
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(
                  todos[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      todos.removeAt(index);
                    });
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          );
        },
      ),
      ///////////////////////////////
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 138, 189, 231),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertDialog(
                title: Text("Add Task", textAlign: TextAlign.center),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (String Value) {
                          inptask = Value;
                        },
                        decoration: InputDecoration(
                          hintText: "Add Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        textInputAction: TextInputAction.done,
                        maxLines: 7,
                        onChanged: (String value) {
                          inptdesc = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Add Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: Text(
                          'Due date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        timeLabelText: "Hour",
                        selectableDayPredicate: (date) {
                          // Disable weekend days to select from the calendar
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }

                          return true;
                        },
                        onChanged: (val) => time = val,
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => print(val),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            todos.add(
                              "$inptask\n\n$inptdesc\n\nDue : $time",
                            );
                            inptask = "";
                            inptdesc = "";
                          });
                        },
                        child: Text("Add"),
                      ),
                    ],
                  ),
                ),
                elevation: 20,
              );
            },
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
