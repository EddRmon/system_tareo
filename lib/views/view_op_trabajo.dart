import 'package:flutter/material.dart';

const String url =
    'https://images.pexels.com/photos/17862061/pexels-photo-17862061/free-photo-of-bote-en-el-humedal-de-santa-elena-en-medio-de-la-selva.jpeg?auto=compress&cs=tinysrgb&w=300';

class ViewOpTrabajo extends StatefulWidget {
  const ViewOpTrabajo({super.key});

  @override
  State<ViewOpTrabajo> createState() => _ViewOpTrabajoState();
}

class _ViewOpTrabajoState extends State<ViewOpTrabajo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Naturaleza', style: TextStyle(color: Colors.white70),),
              background: Image.network(url, fit: BoxFit.cover),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: 
            MySliverPersistenHeader()),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text('Grid # $index', style: const TextStyle(color: Colors.white),)),
                ),
              );
            },
            childCount: 8
            ), 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 1,
              mainAxisExtent: 70,
             // childAspectRatio: 1.5
              )
          ),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) {
             return ListTile(
              title: Text('Numeros de animales #$index'),
              tileColor: Colors.green,
              ); 
          },
          childCount: 10
          ))
        ],
      ),
    );
  }
}


class MySliverPersistenHeader extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.blueAccent ,child: const Center(child: Text('CABECERA', style: TextStyle(color: Colors.white),),),);
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}


