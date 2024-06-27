import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newprovider=StateProvider<int>((ref) => 0,);


class home extends ConsumerWidget {
  const home({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pro=ref.watch(newprovider);


    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          ref.read(newprovider.notifier).update((state) => state+1);
        },
            child: Icon(Icons.add)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(pro.toString(), style: TextStyle(fontSize: 50)),
            ),
          ],
        ));
  }
}



