import 'package:flutter/material.dart';
import 'package:pals_hand/core/viewmodels/base_view.dart';
import 'package:pals_hand/core/viewmodels/home/home_view_model.dart';
import 'package:pals_hand/ui/widgets/custom_bottom_bar.dart';
import '../../tab_router.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Navigator(
          key: _navigationKey,
          initialRoute: 'home/my_list',
          onGenerateRoute: TabRouter.generateRoute,
        ),
        bottomNavigationBar: CustomBottomBar(
          model: model,
          navigationKey: _navigationKey,
        ),
      ),
    );
  }
}
