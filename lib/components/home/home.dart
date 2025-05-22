import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_tswt/components/authentication/logout.dart';
import 'package:mobile_app_tswt/components/workouts/workout_list/workout_list.dart';
import '../../utils/widgets/splash_screen.dart';
import '../authentication/email_authentication.dart';
import '../workouts/history/workout_history.dart';
import 'home_bloc.dart';

class Home extends StatefulWidget {
  final bool isFirstTime;

  const Home({super.key, this.isFirstTime = false});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {
        'icon1':
        "assets/dashboard_icons/icons8-home.png",
        'icon2':
        "assets/dashboard_icons/icons8-home-grey.png",
        'label': 'Home'
      },
      {
        'icon1':
        "assets/dashboard_icons/icons8-order-history.png",
        'icon2':
        "assets/dashboard_icons/icons8-order-history-grey.png",
        'label': 'History '
      },
      {
        'icon1':
        "assets/dashboard_icons/icons8-logout.png",
        'icon2':
        "assets/dashboard_icons/icons8-logout-grey.png",
        'label': 'Logout '
      },
    ];
    final List<Widget> children = [
      WorkoutList(),
      WorkoutHistory(),
      LogoutSession()
    ];
    return BlocProvider(
      create: (context) =>
      HomeBloc()..add(OnLoadHome(isFirstTime: widget.isFirstTime)),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) async {},
        builder: (context, state) {
          if (state is ShowSplashScreen) {
            return const SplashScreen();
          }
          if (state is ShowUserAuthentication) {
            return const UserEmailAuthentication();
          }
          if (state is HomeTabSelected) {
            return Scaffold(
              body: children[state.tabPosition],
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.height*0.15,
                decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarTheme.color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(
                          0, -2), // Shadow on top of BottomAppBar
                    ),
                  ],
                ),
                child: BottomAppBar(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 6.0,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: (){
                            BlocProvider.of<HomeBloc>(context)
                                .add(OnHomeTabPressed(index));
                          },
                          child: AnimatedContainer(
                            duration:
                            const Duration(milliseconds: 300),
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                              color: state.tabPosition == index
                                  ? Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Colors.blue[900]
                                  : const Color(0xFF10006D)
                                  : Colors.transparent,
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 2),
                            // Reduced padding to prevent overflow
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                state.tabPosition == index
                                    ? Image.asset(
                                  tabs[index]['icon1'],
                                  height: 20,
                                  width: 20,
                                )
                                    : Image.asset(
                                  tabs[index]['icon2'],
                                  height: 25,
                                  width: 25,
                                ),
                                if (state.tabPosition ==
                                    index) // Show text only if selected
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left:
                                        7), // Space between icon and text
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                          milliseconds: 300),
                                      transitionBuilder:
                                          (child, animation) =>
                                          FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                      child: Text(
                                        tabs[index]['label'],
                                        key: ValueKey(index),
                                        // Ensures animation runs correctly
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  width: 4,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          }

          if (state is ErrorLoadingHome) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("TSWT"),
              ),
              //Need to write Custom Show Error msg
              body: const Text("Error:Home.dart"),
            );
          }
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Just a moment"),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Theme.of(context).brightness == Brightness.dark
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : CircularProgressIndicator(
                    color: Colors.blue[900],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
