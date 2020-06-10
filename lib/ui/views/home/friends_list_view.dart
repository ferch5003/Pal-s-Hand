import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/friends_list_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pals_hand/core/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendListView extends StatelessWidget {
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
                  var price = users[index]["total"];
                  if(users[index]["total"]!=0 && users[index]["total"]!=null){
                    price = users[index]["total"].toInt();
                  }
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: users[index]["image"]!= "" ?  NetworkImage(users[index]["image"]) : AssetImage('assets/users.png'),
                                backgroundColor: Colors.orange,
                              ),
                              title: Text(users[index]["name"]),
                              subtitle: users[index]["total"]!=0 ? Text('\$$price'): Text('Aún no tengo lista de productos'),
                              onTap: () async{
                                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                                DatabaseService(uid: user.uid).updateFriendListData(frienduid:users[index]["uid"]);
                              },
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
