import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class Blockchain{
  static Future<DeployedContract> getContract() async {
    String abiFile = await rootBundle.loadString("assets/contracts/PostSystem.json");
    final contract = DeployedContract(ContractAbi.fromJson(abiFile, "PostNFT"),
        EthereumAddress.fromHex(dotenv.env['contract_address'] ?? "Cannot load contract_address"));
    return contract;
  }
}