import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paynah_test/presentation/bloc/auth/auth_cubit.dart';
import 'package:paynah_test/presentation/bloc/profile/profile_cubit.dart';
import 'package:paynah_test/utils/app_const.dart';
import 'package:paynah_test/widgets/app_button.dart';
import 'package:paynah_test/widgets/card_bottom_indicator.dart';
import 'package:paynah_test/widgets/card_item.dart';
import 'package:velocity_x/velocity_x.dart';

class ChooseAccountScreen extends StatefulWidget {
  const ChooseAccountScreen({super.key});

  @override
  State<ChooseAccountScreen> createState() => _ChooseAccountScreenState();
}

class _ChooseAccountScreenState extends State<ChooseAccountScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  int cardlength = 2;
  bool _isAtEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    final int page = (offset / context.screenWidth * 0.8).round();
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
    }

    var isAtEnd = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100;

    if (isAtEnd != _isAtEnd) {
      setState(() {
        _isAtEnd = isAtEnd;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchUserData(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
                icon: const Icon(Icons.logout_sharp))
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (state is ProfileLoaded) {
              return SizedBox(
                width: context.screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Choisissez un compte",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                    ),

                    20.heightBox,

                    SizedBox(
                      height: context.screenHeight / 1.8,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: cardlength + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return 30.widthBox;
                          }

                          if (index == 2) {
                            return Container(
                              padding: const EdgeInsets.all(30),
                              height: context.screenHeight / 1.8,
                              width: context.screenWidth * 0.8,
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(45),
                                  border:
                                      Border.all(color: Colors.grey.shade200)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  SvgPicture.asset(
                                    "${AppConst.imgDir}/binoculars.svg",
                                    width: 60,
                                  ),
                                  8.heightBox,
                                  const Text("Ajouter un compte"),
                                  const Spacer(),
                                  const CradBottomIndicator(),
                                ],
                              ),
                            );
                          }

                          return CardItem(paynahUser: state.paynahUser,);
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          cardlength,
                          (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[300],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          AppButton(
                            title: "Choisir ce compte",
                            onTap: () {},
                          ),
                          Visibility(
                            visible: _isAtEnd,
                            child: AppButton(
                              title: "Ouvrir un compte",
                              bgColor: Colors.white,
                              textColor: Colors.black,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
          
            } else {
              return const Center(child: Text("Une erreur s'est produite"),);
            }
          },
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "Besoin d'aide ?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
