part of 'connection_bloc.dart';

sealed class ConnectionEvent extends Equatable {
  const ConnectionEvent();

  @override
  List<Object> get props => [];
}

class GetConnectionInfo extends ConnectionEvent {
  const GetConnectionInfo();

  @override
  List<Object> get props => [];
}
