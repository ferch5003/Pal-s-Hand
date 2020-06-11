import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/my_list_view_model.dart';
import 'package:pals_hand/ui/views/home/add_product_view.dart';
import 'package:pals_hand/ui/widgets/delete_button.dart';
import 'package:pals_hand/ui/widgets/image_category.dart';
import 'package:pals_hand/ui/widgets/quantity_container.dart';

import '../../../locator.dart';

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  Future<List<Map<dynamic, dynamic>>> _products;

  @override
  void initState() {
    super.initState();
    _products = locator<MyListViewModel>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MyListViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AddProductView()));
                    },
                    child: Container(
                      height: 50,
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(top: 23),
                      child: Row(
                        children: <Widget>[
                          AutoSizeText('Agregar productos'),
                          Icon(Icons.local_grocery_store)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                  child: Text(
                'Mi lista',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              )),
              Expanded(
                child: FutureBuilder<List<Map<dynamic, dynamic>>>(
                  future: _products,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        if (snapshot.hasData) {
                          return snapshot.data.length == 0
                              ? Center(
                                  child: AutoSizeText(
                                    'No hay productos agregados',
                                    maxLines: 2,
                                  ),
                                )
                              : GridView.builder(
                                  itemCount: snapshot.data.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 8.0 / 16.5,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    Product product =
                                        snapshot.data[index]['product'];
                                    String productId =
                                        snapshot.data[index]['productid'];

                                    return Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Card(
                                            semanticContainer: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          ImageCategory(
                                                              category: product
                                                                  .category),
                                                          Positioned(
                                                            right: 0,
                                                            child: DeleteButton(
                                                                model: model,
                                                                productId:
                                                                    productId,
                                                                product:
                                                                    product,
                                                                callback:
                                                                    () async {
                                                                  setState(() {
                                                                    _products =
                                                                        model
                                                                            .getProducts();
                                                                  });
                                                                }),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: AutoSizeText(
                                                                product.name,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                          ),
                                                          Expanded(
                                                              child: AutoSizeText(
                                                                  '\$ ${product.price} c/u',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFFC1BACB),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))),
                                                          QuantityContainer(
                                                            quantity: product
                                                                .quantity,
                                                            model: model,
                                                            onCountChanged: (int
                                                                val) async {
                                                              setState(() {
                                                                if (!(val ==
                                                                        -1 &&
                                                                    product.quantity ==
                                                                        1)) {
                                                                  product.quantity +=
                                                                      val;
                                                                  model.changeQuantity(
                                                                      product,
                                                                      productId,
                                                                      val);
                                                                }
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )));
                                  },
                                );
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('ERROR: ${snapshot.error}'));
                        }
                        return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
