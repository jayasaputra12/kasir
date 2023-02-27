import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/pages/navigation/navigation.dart';
import 'package:kasir/widget/perhatian_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../widget/btn_primary.dart';
import '../../widget/text_field_customer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            context.loaderOverlay.show();
          }
          if (state is AuthSuccess) {
            context.loaderOverlay.hide();
            return NavigationPage(auth: state.authModel);
          }
          if (state is AuthFailed) {
            context.loaderOverlay.hide();
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                builder: (context) => AttentionPop(
                  title: "Perhatian",
                  message: state.message,
                ),
              );
            });
          }
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff020202),
                    ),
                  ),
                  Text(
                    "Silahkan Login untuk memulai",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff8D92A3),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFieldCustom(
                    controller: _emailController,
                    label: "Email",
                  ),
                  const SizedBox(height: 16),
                  TextFieldCustom(
                    controller: _passwordController,
                    label: "Pasworrd",
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  BtnPrimary(
                    onPressed: () {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Email dan Password tidak boleh kosong"),
                          ),
                        );
                      } else {
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
                    txtBtn: "Login",
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
