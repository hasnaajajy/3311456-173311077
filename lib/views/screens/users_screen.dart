import 'package:firebase_crud_app/constants/constants.dart';
import 'package:firebase_crud_app/views/sql/sqldb.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  SqlDb sqlDb = SqlDb();

  Future<List<Map>> readDate() async {
    List<Map> response = await sqlDb.readData("SELECT *FROM notes");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: ListView(
          children: [
            MaterialButton(
              onPressed: () async {
                await sqlDb.mydeletDatabase();
              },
              child: Text("delete database"),
            ),
            FutureBuilder(
                future: readDate(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Card(
                              child: ListTile(
                            title: Text("${snapshot.data![i]['title']}"),
                            subtitle: Text("${snapshot.data![i]['note']}"),
                            trailing: IconButton(
                              onPressed: () async{
                                int response =await sqlDb.deleteData("DELETE FROM notes WHERE id =${snapshot.data![i]['id']}");
                                if (response > 0){
                                  Navigator.of(context).pushAndRemoveUntil
                                    (MaterialPageRoute(builder: (context)=>UserScreen()), (route) => false);
                                }
                              },
                              icon:Icon(Icons.delete),
                            ),
                          ));
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }
}
