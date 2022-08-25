import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vendo/screens/Main_page/mainpage.dart';
import '../../../services/dio_client.dart';
import '../../language_selector/language_selector.dart';

class WhereToDirect extends ConsumerStatefulWidget {
  const WhereToDirect({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WhereToDirect();
}

String go = "/";
final goProvider = StateProvider<String>((ref) {
  return go;
});

class _WhereToDirect extends ConsumerState<WhereToDirect> {
  Future<void> tokenGeneration(WidgetRef ref) async {
    // log(ref.watch(goProvider.notifier).state);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('x-auth-token') ?? "";
    log("token : $token");
    ref.watch(goProvider.notifier).state = token;

    // log(ref.watch(goProvider.notifier).state);
  }

  @override
  Widget build(BuildContext context) {
    tokenGeneration(ref);

    String comp = ref.watch(goProvider);
    if (comp == "/") {
      ref.watch(apiserviceProvider).getuserData(context, ref);
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (comp == "") {
      return LanguageSelector();
    } else {
      return MainPage();
    }

    // return FutureBuilder<String>(
    //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
    //     if (snapshot.data == '0') {
    //       return const LoginScreen();
    //     } else {
    //       return const MainPage();
    //     }
    //   },
    //   future: tokenGeneration(),
    // );
  }
}
