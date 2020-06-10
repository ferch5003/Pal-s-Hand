import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/signup_view_model.dart';
import 'package:pals_hand/ui/widgets/beizer_container.dart';
import 'package:pals_hand/ui/widgets/entry_fields.dart';
import 'package:pals_hand/ui/widgets/submit_button_register.dart';
import 'package:pals_hand/ui/widgets/title.dart';

class SignupView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        EntryFields(
          title: "Nombre de usuario",
          isPassword: false,
          textEditingController: _nameController,
        ),
        EntryFields(
          title: "ID del correo",
          isPassword: false,
          textEditingController: _emailController,
        ),
        EntryFields(
          title: "Contraseña",
          isPassword: true,
          textEditingController: _passwordController,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SignupViewModel>(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 1.2,
              child: Form(
                key: _formKey,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                          TitleWidget(),
                          SizedBox(
                            height: 10,
                          ),
                          _emailPasswordWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          model.isLoading
                              ? CircularProgressIndicator()
                              : SubmitButtonRegister(callback: () async {
                                  await model.signUp(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                }),
                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        top: -MediaQuery.of(context).size.height * .24,
                        right: -MediaQuery.of(context).size.width * .60,
                        child: BezierContainer())
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
