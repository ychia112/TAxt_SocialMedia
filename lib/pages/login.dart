import 'package:flutter/material.dart';
import 'package:ios_proj01/utils/routes.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';
import '../providers/metamask_provider.dart';

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

  void loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          context.read<MetaMask>().setUrl(uri);
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        print(session.accounts[0]);
        print(session.chainId);
        setState(() {
          context.read<MetaMask>().setSession(session);
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  String getNetworkName(chainId) {
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
          context.read<MetaMask>().setSession(session);
      })
    );

    connector.on(
      'session_update',
      (payload) => setState(() {
          context.read<MetaMask>().setSession(payload);
          print(context.read<MetaMask>().session.accounts[0]);
          print(context.read<MetaMask>().session.chainId);
      })
    );

    connector.on(
      'disconnect',
      (payload) => setState(() {
        context.read<MetaMask>().setSession(null);
      })
    );

    var session = context.watch<MetaMask>().session;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Login',
          style: GoogleFonts.abrilFatface(
              textStyle: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )),
        ),
      ),
      body: Center(
        child: 
          (session != null)? 
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(24)),
                  Text(
                    'Account',
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '${session.accounts[0]}',
                    style: GoogleFonts.inconsolata(fontSize: 16),
                  ),
                  const SizedBox(height: 24,),
                  Row(
                    children: [
                      Text(
                        'Chain : ',
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
                        context.read<MetaMask>().setConnector(connector);
                        Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
                      },
                      label: Text(
                        'Slide to login',
                        style: GoogleFonts.merriweather(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black
                            )),
                      ),
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
                      style: GoogleFonts.abrilFatface(
                          textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Colors.black
                          )),
                    ),
                    SizedBox(width: 16)
                  ],
                ),
              ),
            )
          ,
      ),
    );
  }
}