import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.black,
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
                  color: Colors.grey.shade200,
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
                      color: Colors.grey.shade200,
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
                      color: Colors.grey.shade200,
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
                      color: Colors.grey.shade200,
                    ),
                  )
              )
          ),
        ]
      )
    );
  }
}
