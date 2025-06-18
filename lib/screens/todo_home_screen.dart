import 'package:currency_converter_app_sl/provider/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoHomeScreen extends ConsumerWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvier);
    return Scaffold(
      appBar: AppBar(title: Text("ToDo APP")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(itemProvier.notifier).showInputDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body:
          item.isEmpty
              ? Center(child: Text("No Data Available"))
              : ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  final data = item[index];
                  return ListTile(
                    title: Text(data.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            String id = data.id;
                            ref
                                .read(itemProvier.notifier)
                                .showInputDialogUpdate(context, id);
                          },
                          icon: Icon(Icons.update),
                        ),
                        IconButton(
                          onPressed: () {
                            ref.read(itemProvier.notifier).deleteItem(data.id);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
