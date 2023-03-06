import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kasir/bloc/cart/cart_bloc.dart';
import 'package:kasir/bloc/category/category_bloc.dart';
import 'package:kasir/bloc/product/product_bloc.dart';
import 'package:kasir/pages/splash/splash_screen.dart';
import 'package:kasir/repositories/auth/auth_repository.dart';
import 'package:kasir/repositories/cart/cart_repository.dart';
import 'package:kasir/repositories/category/category_repository.dart';
import 'package:kasir/repositories/product/product_repository.dart';
import 'package:kasir/services/shared_preferences_services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/auth_bloc.dart';
import 'cubit/navbar_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationChange>(
          create: (context) => NavigationChange(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(CategoryRepository()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductRepository()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(CartRepository()),
        )
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: Center(
              child: SpinKitCubeGrid(
                color: Color(0xff1B9C42),
                size: 50.0,
              ),
            ),
            overlayColor: Colors.black,
            overlayOpacity: 0.8,
            duration: Duration(seconds: 2),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
