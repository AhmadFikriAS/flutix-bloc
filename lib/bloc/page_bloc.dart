import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/model/models.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageState get initialState => OnInitialPage();

  PageBloc() : super(OnInitialPage()) {
    on<PageEvent>((event, emit) async {
      if (event is GoToSplashPage) {
        emit(OnSplashPage());
      } else if (event is GoToLoginPage) {
        emit(OnLoginPage());
      } else if (event is GoToMainPage) {
        emit(OnMainPage(
            bottomNavBarIndex: event.bottomNavBarIndex,
            isExpired: event.isExpired));
      } else if (event is GoToRegistrationPage) {
        emit(OnRegistrationPage(event.registrationData));
      } else if (event is GoToPreferencePage) {
        emit(OnPreferencePage(event.registrationData));
      } else if (event is GoToAccountConfirmationPage) {
        emit(OnAccountConfirmationPage(event.registrationData));
      } else if (event is GoToMovieDetailPage) {
        emit(OnMovieDetailPage(event.movie));
      } else if (event is GoToSelectSchedulePage) {
        emit(OnSelectSchedulePage(event.movieDetail));
      } else if (event is GoToSelectSeatPage) {
        emit(OnSelectSeatPage(event.ticket));
      } else if (event is GoToCheckoutPage) {
        emit(OnCheckoutPage(event.ticket));
      } else if (event is GoToSuccessPage) {
        emit(OnSuccessPage(event.ticket, event.transaction));
      } else if (event is GoToTicketDetailPage) {
        emit(OnTicketDetailPage(event.ticket));
      } else if (event is GoToProfilePage) {
        emit(OnProfilePage());
      } else if (event is GoToTopUpPage) {
        emit(OnTopUpPage(event.pageEvent));
      } else if (event is GoToWalletPage) {
        emit(OnWalletPage(event.pageEvent));
      } else if (event is GoToEditProfilePage) {
        emit(OnEditProfilePage(event.user));
      }
    });
  }
}
