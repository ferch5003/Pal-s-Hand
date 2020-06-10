import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/friends_list_view_model.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FriendListView extends StatelessWidget {
  //final dbRef = FirebaseDatabase.instance.reference().child("users");
  final users = [];
  @override
  Widget build(BuildContext context) {

    return BaseView<FriendsListViewModel>(
      builder: (context, model, child) => Scaffold(
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("users").getDocuments(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              users.clear();
              List<DocumentSnapshot> values = snapshot.data.documents;
              values.forEach((values){
                users.add(values);
              });
              return new ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder:(BuildContext context, int index){
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(users[index]["image"]),
                                backgroundColor: Colors.orange,
                              ),
                              title: Text(users[index]["name"]),
                              subtitle: Text('Price'), 
                            
                            ),
                      ],
                    ),
                  );
                },
              );
            }
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        ),
      ),
    );
  }
}
