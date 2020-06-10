import 'package:flutter/material.dart';
import 'package:pals_hand/core/models/product.dart';
import 'package:pals_hand/core/viewmodels/home/my_list_view_model.dart';

class DeleteButton extends StatelessWidget {
  final MyListViewModel model;
  final String productId;
  final Product product;
  final VoidCallback callback;

  DeleteButton(
      {key,
      @required this.model,
      @required this.productId,
      @required this.product,
      @required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red[200],
      child: InkWell(
        splashColor: Colors.red[100],
        borderRadius: BorderRadius.circular(30.0),
        onTap: () {
          showDialog(context: (context), child: _confirmDelete(context));
        },
        child: Container(
            width: 30, height: 30, child: Center(child: Icon(Icons.remove))),
      ),
    );
  }

  AlertDialog _confirmDelete(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text('Atención', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text('¿Esta seguro que quiere eliminar este producto?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            await model.deleteProduct(product, productId);
            callback();
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text('Si', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text('No', style: TextStyle(fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
