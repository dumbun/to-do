import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do/modules/data.dart';
import 'package:to_do/widgets/check_box_widget.dart';
import 'constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed("/login/");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userNewEntry = TextEditingController();
    return Scaffold(
      drawer: Drawer(
        child: IconButton(onPressed: logout, icon: Icon(Icons.logout)),
      ),
      appBar: AppBar(
        title: const Text("To-Do"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          trailing: IconButton(
            onPressed: () {
              setState(() {
                userEnteredData.removeAt(index);
              });
            },
            icon: const Icon(Icons.delete),
          ),
          leading: const CheckBoxWidget(),
          key: UniqueKey(),
          title: Text(userEnteredData[index].data.toString()),
        ),
        itemCount: userEnteredData.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("enter new to-do"),
              content: TextField(
                autocorrect: false,
                controller: userNewEntry,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      userEnteredData.add(
                        Data(data: userNewEntry.text),
                      );
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add"),
                )
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
