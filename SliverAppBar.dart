import 'package:flutter/material.dart';

class CollapsableAppbarDemo extends StatefulWidget {
  CollapsableAppbarDemo() : super();

  final String title = "Collpasable Appbar Demo";

  @override
  CollapsableAppbarDemoState createState() => CollapsableAppbarDemoState();
}

class CollapsableAppbarDemoState extends State<CollapsableAppbarDemo> {
  //

  custom() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              "Collapsing AppBar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            background: Image.network(
              "https://images.pexels.com/photos/1020315/pexels-photo-1020315.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
                  title: Text("List Item $index"),
                ),
          ),
        ),
      ],
    );
  }

  nested() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Collapsing AppBar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              background: Image.asset(
                "images/parrot.jpg",
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body: Center(
        child: Text("The Parrot"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: custom(),
    );
  }
}
