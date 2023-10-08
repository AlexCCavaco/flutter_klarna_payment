import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_klarna_payment/flutter_klarna_payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterKlarnaPaymentPlugin = FlutterKlarnaPayment();
  EventChannel eventChannel =
      const EventChannel("flutter_klarna_payment_event");

  @override
  void initState() {
    super.initState();
    initPlatformState();
    eventChannel.receiveBroadcastStream().listen(
      (event) {
        print(event);
      },
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // try {
    //   platformVersion =
    //       await _flutterKlarnaPaymentPlugin.getPlatformVersion() ?? 'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: [
              Expanded(
                child: KlarnaPaymentView(
                    request: KlarnaPaymentRequest(
                        clientToken: token,
                        returnUrl: 'https://example.flutter_klarna_payment')),
              ),
              ElevatedButton(
                  onPressed: () {
                    _flutterKlarnaPaymentPlugin.pay();
                  },
                  child: Text('Pay'))
            ],
          )),
    );
  }
}

const token =
    'eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMzA1ZWJjLWI4MTEtMzYzNy1hYTRjLTY2ZWNhMTg3NGYzZCJ9.eyJzZXNzaW9uX2lkIjoiNjFiNTk0YjEtZjRmZS01ZjQ0LWFhNDctZDc3NTI4NTYyOGJkIiwiYmFzZV91cmwiOiJodHRwczovL2pzLnBsYXlncm91bmQua2xhcm5hLmNvbS9ldS9rcCIsImRlc2lnbiI6ImtsYXJuYSIsImxhbmd1YWdlIjoiZW4iLCJwdXJjaGFzZV9jb3VudHJ5IjoiR0IiLCJlbnZpcm9ubWVudCI6InBsYXlncm91bmQiLCJtZXJjaGFudF9uYW1lIjoiWW91ciBidXNpbmVzcyBuYW1lIiwic2Vzc2lvbl90eXBlIjoiUEFZTUVOVFMiLCJjbGllbnRfZXZlbnRfYmFzZV91cmwiOiJodHRwczovL2V1LnBsYXlncm91bmQua2xhcm5hZXZ0LmNvbSIsInNjaGVtZSI6dHJ1ZSwiZXhwZXJpbWVudHMiOlt7Im5hbWUiOiJrcGMtMWstc2VydmljZSIsInZhcmlhdGUiOiJ2YXJpYXRlLTEifSx7Im5hbWUiOiJrcGMtUFNFTC0zMDk5IiwidmFyaWF0ZSI6InZhcmlhdGUtMSJ9LHsibmFtZSI6ImtwLWNsaWVudC11dG9waWEtcG9wdXAtcmV0cmlhYmxlIiwidmFyaWF0ZSI6InZhcmlhdGUtMSJ9LHsibmFtZSI6ImtwLWNsaWVudC11dG9waWEtc3RhdGljLXdpZGdldCIsInZhcmlhdGUiOiJpbmRleCIsInBhcmFtZXRlcnMiOnsiZHluYW1pYyI6InRydWUifX0seyJuYW1lIjoia3AtY2xpZW50LXV0b3BpYS1mbG93IiwidmFyaWF0ZSI6InZhcmlhdGUtMSJ9LHsibmFtZSI6ImtwLWNsaWVudC1vbmUtcHVyY2hhc2UtZmxvdyIsInZhcmlhdGUiOiJ2YXJpYXRlLTEifSx7Im5hbWUiOiJpbi1hcHAtc2RrLW5ldy1pbnRlcm5hbC1icm93c2VyIiwicGFyYW1ldGVycyI6eyJ2YXJpYXRlX2lkIjoibmV3LWludGVybmFsLWJyb3dzZXItZW5hYmxlIn19LHsibmFtZSI6ImtwLWNsaWVudC11dG9waWEtc2RrLWZsb3ciLCJ2YXJpYXRlIjoidmFyaWF0ZS0xIn0seyJuYW1lIjoia3AtY2xpZW50LXV0b3BpYS13ZWJ2aWV3LWZsb3ciLCJ2YXJpYXRlIjoidmFyaWF0ZS0xIn0seyJuYW1lIjoiaW4tYXBwLXNkay1jYXJkLXNjYW5uaW5nIiwicGFyYW1ldGVycyI6eyJ2YXJpYXRlX2lkIjoiY2FyZC1zY2FubmluZy1lbmFibGUifX1dLCJyZWdpb24iOiJldSIsIm9yZGVyX2Ftb3VudCI6MTAsIm9mZmVyaW5nX29wdHMiOjAsIm9vIjoiN3MiLCJ2ZXJzaW9uIjoidjEuMTAuMC0xNTkwLWczZWJjMzkwNyJ9.Hr-wcQxWLNWvlFpicKoxvAx60JRb2vGzNFH6p-5zYU0ZBa69WAyARJFFqBKCTxjs__48EXQtV6Rylsxqau8kiszBI8e4Y24rkJiBFolajiw3xE4ujtj5EtYAIY8nmUMmJ8uC4WP1inYDAnD8yG00tf9-X0ZFWQX72OvugIWlIrmOVaa08_NwBVIM0Op1bZfs-0-AsG1CaVhUQVDtfvyxyLwtPQF2MwAQ8RQAfRKGnOx6W9A4fM1-U_k9Kxrmp91_LpX2njGkazd75xdlEWfMN1IQ0JWNILkmaAm_CmegUe-Gw-6-f27eKaz6Q6jzbatMlENMt5Shvm98PikRodVB2w';
