import 'package:bloc/bloc.dart';
import 'package:dogs_breed/domain/register_dog.dart';
import 'package:dogs_breed/verification/verification_repo.dart';

import '../domain/format_breed.dart';
import '../domain/problems.dart';

class VerificationEvent {}

class Created extends VerificationEvent {}

class ReciviedBreed extends VerificationEvent {
  final FormatBreed breed;
  ReciviedBreed(this.breed);
}

class ConfirmedName extends VerificationEvent {}

class VerificationState {}

class Creating extends VerificationState {}

class RequestingBreed extends VerificationState {}

class WaitingConfirmationName extends VerificationState {}

class ShowingRequestUpdate extends VerificationState {}

class InvalidBreed extends VerificationState {}

class ShowingNotConfirmedBreed extends VerificationState {
  final FormatBreed breed;
  ShowingNotConfirmedBreed(this.breed);
}

class ShowingConfirmedBreed extends VerificationState {
  final DogRegister dogRegister;
  final FormatBreed breed;
  ShowingConfirmedBreed(this.dogRegister, this.breed);
}

class ShowingBreedWithoutSubBreed extends VerificationState {
  final FormatBreed breed;
  ShowingBreedWithoutSubBreed(this.breed);
}

class ShowName extends VerificationState {}

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final VerificationRepo _verificationRepo;
  VerificationBloc(this._verificationRepo) : super(Creating()) {
    on<Created>((event, emit) {
      emit(RequestingBreed());
    });
    on<ReciviedBreed>(
      (event, emit) {
        emit(WaitingConfirmationName());
        final result = _verificationRepo.getDogRegister(event.breed);
        result.match((l) {
          if (l is IncorrectVersionJson) {
            emit(ShowingRequestUpdate());
          }
          if (l is NotRegisteredDog) {
            emit(ShowingNotConfirmedBreed(event.breed));
          }
          if (l is WithoutSubBreed) {
            emit(ShowingBreedWithoutSubBreed(event.breed));
          }
        }, (r) {
          emit(ShowingConfirmedBreed(r, event.breed));
        });
      },
    );
  }
}
