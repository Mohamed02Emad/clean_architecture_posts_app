import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
}

class OfflineFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class EmptyCasheFailure extends Failure{
  @override
  List<Object?> get props => [];

}


String getFailureMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "Server failure";

    case EmptyCasheFailure:
      return "Empty cashe failure";

    case OfflineFailure:
      return "Offline failure";
    default:
      return "Unknown Error";
  }
}
