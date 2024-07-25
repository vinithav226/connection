import 'dart:async';

import 'package:connect/bloc/connection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => ConnectionBloc(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool checked = false;
  final _formKey = GlobalKey<FormState>();
  final actualController = TextEditingController();
  final configController = TextEditingController();
  final passwordController = TextEditingController();

  late StreamSubscription _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    // final List<ConnectivityResult> connectivityResult =
    //     await (Connectivity().checkConnectivity());
    connectivity();

    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    actualController.dispose();
    configController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void connectivity() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.wifi) {
        context.read<ConnectionBloc>().add(const GetConnectionInfo());
        // alert();
      } else {}
    });
  }

  Future<void> alert() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Please connect to wi-fi to proceed"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Actual Value'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: actualController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter actual value';
                      } else if (value.length < 4) {
                        return 'Please enter 4 digit actual value';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Config Value'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: configController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter config value';
                      } else if (value.length < 4) {
                        return 'Please enter 4 digit config value';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: checked,
                          onChanged: (val) {
                            setState(() {
                              checked = val!;
                            });
                          }),
                      const Text('Enable password')
                    ],
                  ),
                  checked
                      ? TextFormField(
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password ';
                            } else if (value.length < 4) {
                              return 'Please enter password with 4 -8 characters ';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(8)
                          ],
                          style: const TextStyle(),
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: ElevatedButton(
          onPressed: () {
            context.read<ConnectionBloc>().add(const GetConnectionInfo());
            if (_formKey.currentState!.validate()) {}
          },
          style: const ButtonStyle(
            padding:
                WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(16)),
            backgroundColor: WidgetStatePropertyAll<Color>(
              Colors.deepPurple,
            ),
            foregroundColor: WidgetStatePropertyAll<Color>(
              Colors.white,
            ),
          ),
          child: const Text('Update'),
        ));
  }
}
