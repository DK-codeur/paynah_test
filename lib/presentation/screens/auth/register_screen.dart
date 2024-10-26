import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paynah_test/presentation/bloc/auth/auth_cubit.dart';
import 'package:paynah_test/helpers.dart/ui_helper.dart';
import 'package:paynah_test/presentation/screens/choose_account_screen.dart';
import 'package:paynah_test/widgets/app_input.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _pwd = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _lName.dispose();
    _fName.dispose();
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
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    33.heightBox,
                    const Text(
                      "Crée un compte",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                    ),
                    16.heightBox,
                    AppInput(
                      controller: _email,
                      textInputType: TextInputType.emailAddress,
                      labelText: "Votre identifiant",
                    ),
                
                    AppInput(
                      controller: _lName,
                      labelText: "Votre nom",
                    ),
                    AppInput(
                      controller: _fName,
                      labelText: "Votre prénoms",
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            context.read<AuthCubit>().signUp(_email.text, _pwd.text, fName: _fName.text, lName: _lName.text);
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
          );
        },
      ),
    );
  }
}
