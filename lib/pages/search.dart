import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              textStyle: TextStyle(
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
  List<String> searchResults= [
    'Apple',
    'Banana',
    'Cat',
    'Dog',
    'Elephant',
  ];
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
  @override
  Widget buildResults(BuildContext context) => Center(
    child: Text(
      query,
      style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
    ),
  );

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
