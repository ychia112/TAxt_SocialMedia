import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Blockchain{
  static Future<DeployedContract> getContract(String name) async {
    String abiFile = await rootBundle.loadString("assets/contracts/$name.json");
    final contract = DeployedContract(ContractAbi.fromJson(abiFile, name),
        EthereumAddress.fromHex(dotenv.env['contract_address_$name'] ?? "Cannot load contract_address"));
    return contract;
  }
}