import 'package:dani/core/app_route.dart';
import 'package:dani/core/constants.dart';
import 'package:dani/core/utils/extensions/text_style_extension.dart';
import 'package:dani/core/widgets/my_btn.dart';
import 'package:dani/features/spending/applications/spending_listing/spending_listing_bloc.dart';
import 'package:dani/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/utils/text_theme_util.dart';
import '../../spending/presentations/spending_listing_screen.dart';
import '../applications/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SpendingListingBloc spendingListingBloc;

  @override
  void initState() {
    super.initState();
    spendingListingBloc = GetIt.I.get<SpendingListingBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(GetIt.I.get()),
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeLogoutSuccessState) {
            AppRoute.pushReplacement(context, AppRoute.loginScreen);
            return;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              tr(LocaleKeys.spendingScreen_spendingListing),
              style: TextThemeUtil.instance.titleMedium?.semiBold
                  .copyWith(color: Colors.white),
            ),
          ),
          drawer: _MyDrawer(),
          body: BlocProvider<SpendingListingBloc>(
            create: (context) => spendingListingBloc..add(FetchSpendingListingEvent()),
            lazy: false,
            child: SpendingListingScreen(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              Navigator.pushNamed(context, AppRoute.spendingScreen)
                  .then((value) {
                spendingListingBloc.add(FetchSpendingListingEvent());
              });
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class _MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                tr(LocaleKeys.common_featureWorkInProgress),
                style: TextThemeUtil.instance.titleMedium?.regular,
              ),
            ),
          ),
          MyFilledWithChildBtn(
            onTap: () {
              BlocProvider.of<HomeCubit>(context).logout();
            },
            child: Row(
              children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                  size: Constants.iconSize,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  tr(LocaleKeys.common_logout),
                  style: TextThemeUtil.instance.bodyMedium?.semiBold
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Constants.padding,
          ),
        ],
      ),
    );
  }
}
