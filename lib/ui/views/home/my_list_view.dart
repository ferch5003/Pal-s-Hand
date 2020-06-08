import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/my_list_view_model.dart';

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyListViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  AutoSizeText('My List'),
                  Row(
                    children: <Widget>[
                      AutoSizeText('Add product/s'),
                      Icon(Icons.local_grocery_store)
                    ],
                  )
                ],
              ),
              FutureBuilder<List<Product>>(
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      break;
                    default:
                      if (snapshot.hasData) {
                        return snapshot.data.length == 0
                            ? Container()
                            : GridView.builder(
                                itemCount: 6,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 8.0 / 10.0,
                                  crossAxisCount: 2,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Card(
                                          semanticContainer: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/no_image.png'),
                                                      fit: BoxFit.fill),
                                                ),
                                              )),
                                              Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    "Name",
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  )),
                                            ],
                                          )));
                                },
                              );
                      } else if (snapshot.hasError) {}
                      return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
