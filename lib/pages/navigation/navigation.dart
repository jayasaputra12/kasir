import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasir/model/auth/auth_model.dart';

import '../../cubit/navbar_cubit.dart';
import 'home/home_page.dart';

class NavigationPage extends StatelessWidget {
  NavigationPage({this.auth, super.key});
  AuthModel? auth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationChange, int>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: SizedBox(
            height: 87,
            child: BottomNavigationBar(
              currentIndex: state,
              onTap: (value) {
                context.read<NavigationChange>().changeNavigation(value);
              },
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: const Color(0xffBDBDBD),
              unselectedFontSize: 14,
              fixedColor: const Color(0xff4F4F4F),
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 20),
                    child: state == 0
                        ? Image.asset(
                            'assets/icons/home_active.png',
                            width: 21,
                          )
                        : Image.asset(
                            'assets/icons/home.png',
                            width: 21,
                          ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 20),
                    child: state == 1
                        ? Image.asset(
                            'assets/icons/cart_active.png',
                            width: 21,
                          )
                        : Image.asset(
                            'assets/icons/cart.png',
                            width: 21,
                          ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 20),
                    child: state == 2
                        ? Image.asset(
                            'assets/icons/profile_active.png',
                            width: 21,
                          )
                        : Image.asset(
                            'assets/icons/profile.png',
                            width: 21,
                          ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, int state) {
    switch (state) {
      case 0:
        return HomePage(
          auth: auth,
        );
      case 1:
        return const Center(
          child: Text('Cart'),
        );
      case 2:
        return const Center(
          child: Text('Profile'),
        );
      default:
        return const Center(
          child: Text('Home'),
        );
    }
  }
}
