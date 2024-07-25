// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'connection_bloc.dart';

class ConnectionState extends Equatable {
  const ConnectionState({this.connectionStatus = const StatusInitial()});
  final Status connectionStatus;

  @override
  List<Object> get props => [connectionStatus];

  ConnectionState copyWith({
    Status? connectionStatus,
  }) {
    return ConnectionState(
      connectionStatus: connectionStatus ?? this.connectionStatus,
    );
  }
}
