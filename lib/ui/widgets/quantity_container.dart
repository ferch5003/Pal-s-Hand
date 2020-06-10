import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/home/my_list_view_model.dart';

class QuantityContainer extends StatefulWidget {
  final int quantity;
  final Function(int) onCountChanged;
  final MyListViewModel model;

  QuantityContainer(
      {key,
      @required this.quantity,
      @required this.model,
      @required this.onCountChanged})
      : super(key: key);

  @override
  _QuantityContainerState createState() => _QuantityContainerState();
}

class _QuantityContainerState extends State<QuantityContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _changeQuantityButton(Icon(Icons.remove), () {
          widget.onCountChanged(-1);
        }),
        Text(
          '${widget.quantity}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _changeQuantityButton(Icon(Icons.add), () {
          widget.onCountChanged(1);
        })
      ],
    );
  }

  Widget _changeQuantityButton(Icon icon, VoidCallback callbak) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      color: widget.model.ready ? Colors.orange[200] : Color(0xFFFECC4C),
      child: InkWell(
        splashColor: Colors.orange[300],
        borderRadius: BorderRadius.circular(10.0),
        onTap: widget.model.ready ? null : () => callbak(),
        child: Center(child: icon),
      ),
    );
  }
}
