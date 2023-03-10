import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ios_proj01/pages/profile.dart';
import 'package:ios_proj01/providers/metamask_provider.dart';
import 'package:provider/provider.dart';
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Search',
          style: GoogleFonts.abrilFatface(
              textStyle: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,color: Colors.black,size: 30,),
            onPressed: (){
                showSearch(context: context, delegate: MySearchDelegate(),
              );
            },
          )
        ],
      ),
    );
  }
}
class MySearchDelegate extends SearchDelegate{
  List<String> searchResults= [];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
  );

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        onPressed: (){
          if (query.isEmpty){
            close(context, null);
          }else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
    ),
  ];
  // @override
  // Widget buildResults(BuildContext context) => Center(
  //   child: Text(
  //     query,
  //     style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
  //   ),
  // );

  @override
  Widget buildResults(BuildContext context){
    if(isValidEthereumAddress(query.toLowerCase())){
      return UserProfile(
        address: query.toLowerCase(),
        viewByOwner: false,
        isSearchPage: true,
      );
    }
    if(query == ''){
      return const Center(
        child: Text(
          'Please type the address',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
    return const Center(
      child: Text(
        'It is not a valid Ethereum address',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    List<String> suggestions = searchResults.where((searchResult){
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index){
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: (){
            query = suggestion;

            showResults(context);
          },
        );
      },
    );
  }
}
