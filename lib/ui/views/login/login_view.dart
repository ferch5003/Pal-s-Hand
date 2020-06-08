import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/login_view_model.dart';
import 'package:pals_hand/ui/widgets/beizer_container.dart';
import 'package:pals_hand/ui/widgets/create_account.dart';
import 'package:pals_hand/ui/widgets/entry_fields.dart';
import 'package:pals_hand/ui/widgets/submit_button_google.dart';
import 'package:pals_hand/ui/widgets/submit_button_login.dart';
import 'package:pals_hand/ui/widgets/title.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        EntryFields(
          title: "Email",
          isPassword: false,
          textEditingController: _emailController,
        ),
        EntryFields(
          title: "Password",
          isPassword: true,
          textEditingController: _passwordController,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
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
                      Expanded(flex: 3, child: SizedBox()),
                      TitleWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      model.isLoading
                          ? CircularProgressIndicator()
                          : SubmitButtonLogin(
                              callback: () async {
                                model.login(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              },
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text('OR'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      model.isLoadingGoogle
                          ? CircularProgressIndicator()
                          : SubmitButtonGoogle(
                              callback: () async {
                                await model.loginWithGoogle(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              },
                            ),
                      Expanded(flex: 2, child: SizedBox()),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CreateAccountLabel(),
                ),
                Positioned(
                    top: -MediaQuery.of(context).size.height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer()),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
