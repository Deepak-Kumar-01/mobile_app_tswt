import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/widgets/splash_screen.dart';
import '../authentication/email_authentication.dart';
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
          if (state is AuthenticationSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Home"),
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
