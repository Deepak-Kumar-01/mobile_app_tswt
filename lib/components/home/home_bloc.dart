import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/pref/pref_manager.dart';

//Event
abstract class HomeEvent {}

class OnLoadHome extends HomeEvent {
  final bool isFirstTime;
  final bool isRefresh;
  OnLoadHome({this.isFirstTime = false, this.isRefresh = false});
}

//State
abstract class HomeState {}

class HomeLoading extends HomeState {}

class ShowSplashScreen extends HomeState {}

class ShowUserAuthentication extends HomeState {}

class AuthenticationSuccess extends HomeState {}

class ErrorLoadingHome extends HomeState {
  final String errorMessage;
  ErrorLoadingHome({required this.errorMessage});
}

// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    //OnLoadHome Event
    on<OnLoadHome>((event, emit) async {
      if (event.isFirstTime) {
        emit(ShowSplashScreen());
        await Future.delayed(const Duration(seconds: 1));
      }
      if (!event.isRefresh) {
        await PrefManager.db.init();
        final bool isLoggedInStatus = PrefManager.db.isLoggedIn;
        if (!isLoggedInStatus) {
          emit(ShowUserAuthentication());
          return;
        }
      }
      emit(AuthenticationSuccess());
    });
  }
}