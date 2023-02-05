import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.grey,
              ),
              title: Text('A p p N a m e'),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 200,
                  color: Colors.grey,
                ),
              )
            )
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 200,
                      color: Colors.grey,
                    ),
                  )
              )
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 200,
                      color: Colors.grey,
                    ),
                  )
              )
          ),
          SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 200,
                      color: Colors.grey,
                    ),
                  )
              )
          ),
        ]
      )
    );
  }
}
