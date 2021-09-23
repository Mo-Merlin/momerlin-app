import 'package:bitcoins/pgpwordlist/pgpwordlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/bloc/authentication_bloc.dart';
import 'package:momerlin/wallet_screens/wallet_two.dart';
import 'package:momerlin/walletcreation.dart/wallethome.dart';
import 'package:flutter/material.dart';
import 'package:momerlin/walletcreation.dart/walletsucess.dart';
import './simpleBlocObserver.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc()..add(AppStarted()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momerlin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryTextTheme: GoogleFonts.poppinsTextTheme().copyWith(),
        accentTextTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return WalletTwo();
          } else if (state is Unauthenticated) {
            return WalletHomePage();
          } else {
            return Container(
              color: Colors.white,
            );
          }
        },
      ),
      // home: WalletHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
