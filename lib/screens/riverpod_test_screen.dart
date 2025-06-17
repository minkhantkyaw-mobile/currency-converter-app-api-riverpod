import 'package:currency_converter_app_sl/provider/riverpod_test_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodTestScreen extends ConsumerWidget {
  const RiverpodTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var value = ref.watch(counterStateProvider);
    print("value");
    return Scaffold(
      appBar: AppBar(title: Text("RiverPods testing")),
      body: Center(
        child: Column(
          children: [
            // Text(
            //   value.toString(),
            //   style: Theme.of(context).textTheme.titleLarge,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterStateProvider.state).state++;
                  },
                  child: Icon(Icons.plus_one),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(counterStateProvider.state).state--;
                  },
                  child: Icon(Icons.exposure_minus_1_outlined),
                ),
              ],
            ),
            SizedBox(height: 30),
            Consumer(
              builder: (context, ref1, child) {
                final value = ref1.watch(counterStateProvider);
                final jokeAsync = ref1.watch(getApi);
                return Center(
                  child: Column(
                    children: [
                      Text(value.toString()),
                      ElevatedButton(
                        onPressed: () {
                          ref1.read(counterStateProvider.state).state++;
                        },
                        child: Icon(Icons.add),
                      ),
                      jokeAsync.when(
                        data:
                            (joke) => Column(
                              children: [
                                Text(joke.type),
                                Text(joke.setup),
                                Text(joke.punchline),
                              ],
                            ),
                        error: (e, st) => Text("error $e"),
                        loading: () => CircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
