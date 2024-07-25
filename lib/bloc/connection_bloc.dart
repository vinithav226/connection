import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:http/http.dart' as http;

import 'package:connect/status/status.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionState> {
  ConnectionBloc() : super(const ConnectionState()) {
    on<GetConnectionInfo>((event, emit) async {
      final info = NetworkInfo();
      final wifiIP = await info.getWifiIP();
      final url = Uri.parse('$wifiIP/info');

      var response = await http.get(url);
      log(response.toString());
    });
  }
}
