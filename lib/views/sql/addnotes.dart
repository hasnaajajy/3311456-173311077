import 'package:firebase_crud_app/views/screens/users_screen.dart';
import 'package:firebase_crud_app/views/sql/sqldb.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crud_app/views/sql/sqldb.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            TextFormField(
              controller: note,
              decoration: InputDecoration(hintText: "note"),
            ),
            TextFormField(
              controller: title,
              decoration: InputDecoration(hintText: "Link"),
            ),
            TextFormField(
              controller: color,
              decoration: InputDecoration(hintText: "color"),
            ),


            Container(
              height: 20,
            ),
            MaterialButton(
              textColor: Colors.white,
              onPressed: () async {
                var response = await sqlDb.insertData(
                    'Insert into notes (title, note) Values ("${title.text}","${note.text}")');

               if (response >0 ){
                 Navigator.of(context).pushAndRemoveUntil
                   (MaterialPageRoute(builder: (context)=>UserScreen()), (route) => false);
               }
              },
              child: Text("Add"),
            )
          ],
        ),
      ),
    );
  }
}
