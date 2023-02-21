import 'package:flutter/material.dart';
import 'package:ios_proj01/utils/routes.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';
import '../providers/session_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: const PeerMeta(
        name: 'My App',
        description: 'A simple social app',
        url: 'https://walletconnect.org',
    )
  );

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          context.read<Session>().setUrl(uri);
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        print(session.accounts[0]);
        print(session.chainId);
        setState(() {
          context.read<Session>().setSession(session);
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  getNetworkName(chainId) {
    switch (chainId) {
      case 1:
        return 'Ethereum Mainnet';
      case 3:
        return 'Ropsten Testnet';
      case 4:
        return 'Rinkeby Testnet';
      case 5:
        return 'Goreli Testnet';
      case 42:
        return 'Kovan Testnet';
      case 137:
        return 'Polygon Mainnet';
      case 80001:
        return 'Mumbai Testnet';
      default:
        return 'Unknown Chain';
    }
  }

  @override
  Widget build(BuildContext context) {
    connector.on(
      'connect',
      (session) => setState(() {
          context.read<Session>().setSession(session);
      })
    );

    connector.on(
      'session_update',
      (payload) => setState(() {
          context.read<Session>().setSession(payload);
          print(context.read<Session>().session.accounts[0]);
          print(context.read<Session>().session.chainId);
      })
    );

    connector.on(
      'disconnect',
      (payload) => setState(() {
        context.read<Session>().setSession(null);
      })
    );

    var session = context.watch<Session>().session;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Login'),
      ),
      body: Center(
        child: 
          (session != null)? 
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '${session.accounts[0]}',
                    style: GoogleFonts.inconsolata(fontSize: 16),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Text(
                        'Chain: ',
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      Text(
                        getNetworkName(session.chainId),
                        style: GoogleFonts.inconsolata(fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  (session.chainId != 5)?
                    Row(
                      children: const [
                        Icon(Icons.warning,
                          color: Colors.redAccent, size: 15),
                        Text('Network not supported. Switch to '),
                        Text(
                          'Goerli Testnet',
                          style:
                            TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  : Container(
                    alignment: Alignment.center,
                    child: SliderButton(
                      action: () async {
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      label: const Text('Slide to login'),
                      icon: const Icon(Icons.check),
                    ),
                  )
                ],
              ),
            )
          :
            Material(
              color: Colors.white60,
              elevation: 3,
              borderRadius: BorderRadius.circular(24),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                splashColor: Colors.black26,
                onTap: (){
                  loginUsingMetamask(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Ink.image(
                      image: AssetImage('assets/images/metamask.svg.png'),
                      height:60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Connect to MetaMask',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(width: 12)
                  ],
                ),
              ),
            )
          ,
      ),
    );
  }
}