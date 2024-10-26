import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynah_test/presentation/bloc/auth/auth_cubit.dart';
import 'package:paynah_test/helpers.dart/ui_helper.dart';
import 'package:paynah_test/presentation/screens/choose_account_screen.dart';
import 'package:paynah_test/widgets/app_input.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
         if (state is AuthAuthenticated) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ChooseAccountScreen(),), (route) => false,);
          } else if (state is AuthError) {
            UiHelper.showSnackbar(context, state.message, backgroundColor: Colors.red);
          }
        },
        builder:(context, state) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  33.heightBox,
                  const Text(
                    "Connexion",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                  ),
                  16.heightBox,
                  AppInput(
                    controller: _email,
                    textInputType: TextInputType.emailAddress,
                    labelText: "Votre identifiant",
                  ),
                  AppInput(
                    controller: _pwd,
                    labelText: "Clé d'accès",
                    suffixIcon: const Icon(
                      Icons.vpn_key_sharp,
                      color: Colors.grey,
                    ),
                  ),
                  15.heightBox,
                  const Text(
                    "J’ai perdu ma clé",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          if (!_loginFormKey.currentState!.validate()) {
                            return;
                          }
                          context
                              .read<AuthCubit>()
                              .signIn(_email.text, _pwd.text);
                        },
                        icon: (state is AuthLoading) 
                          ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white,),) 
                          : const Icon(Icons.arrow_forward_sharp),
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.black,
                            fixedSize: const Size(53, 52)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
