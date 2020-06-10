import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/add_product_view_model.dart';
import 'package:pals_hand/ui/views/home/my_list_view.dart';
import 'package:pals_hand/ui/widgets/category_dropdown_menu.dart';
import 'package:pals_hand/ui/widgets/image_category.dart';
import 'package:pals_hand/ui/widgets/search_text_field.dart';

class AddProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<AddProductViewModel>(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyListView()));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('Agregar producto'),
            leading: IconTheme(
                data: IconThemeData(color: Colors.black), child: BackButton()),
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 15, right: 15, bottom: 20),
            child: Column(
              children: <Widget>[
                SearchTextField(
                  model: model,
                ),
                SizedBox(
                  height: 20,
                ),
                CategoryDropdownMenu(model: model),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder<List<Product>>(
                    future: model.getProducts(),
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
                                    child: AutoSizeText('No hay productos'),
                                  )
                                : ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      Product product = snapshot.data[index];

                                      return Center(
                                        child: AspectRatio(
                                          aspectRatio: 25.0 / 10.0,
                                          child: Card(
                                            semanticContainer: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0,
                                                  left: 15.0,
                                                  right: 20.0,
                                                  bottom: 15.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: ImageCategory(
                                                        category:
                                                            product.category),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  AutoSizeText(
                                                                product.name,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      17.0,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                          'Categoria: ${product.category}',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFC1BACB),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  AutoSizeText(
                                                                '\$ ${product.price} c/u',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () => model
                                                                  .addProduct(
                                                                      product),
                                                              child: Text(
                                                                'Agregar',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                            .orange[
                                                                        400]),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
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
      ),
    );
  }
}
