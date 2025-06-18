import 'package:currency_converter_app_sl/provider/riverpod_test_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodTestScreen extends ConsumerWidget {
  const RiverpodTestScreen({super.key});

  //const RiverpodTestScreen(super._state, );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var value = ref.watch(counterStateProvider);

    print("value");
    return Scaffold(
      appBar: AppBar(title: Text("RiverPods testing")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                ref.read(searchProvider.notifier).search(value);
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final search = ref.watch(
                  searchProvider.select((state) => state.search),
                );
                print("one");
                return Text("The result" + search);
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                final change = ref.watch(
                  searchProvider.select((state) => state.isChange),
                );
                return Switch(
                  value: change,
                  onChanged: (value) {
                    ref.read(searchProvider.notifier).onChange(value);
                  },
                );
              },
            ),
          ],
        ),
        /////////////////////
        ///State Provider Testing
        ////////////////////
        // child: Column(
        //   children: [
        //     // Text(
        //     //   value.toString(),
        //     //   style: Theme.of(context).textTheme.titleLarge,
        //     // ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         ElevatedButton(
        //           onPressed: () {
        //             ref.read(counterStateProvider.state).state++;
        //           },
        //           child: Icon(Icons.plus_one),
        //         ),
        //         ElevatedButton(
        //           onPressed: () {
        //             ref.read(counterStateProvider.state).state--;
        //           },
        //           child: Icon(Icons.exposure_minus_1_outlined),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 30),
        //     Consumer(
        //       builder: (context, ref, child) {
        //         final value = ref.watch(counterStateProvider);
        //         final jokeAsync = ref.watch(getApi);
        //         final slider = ref.watch(sliderProvider);
        //         return Center(
        //           child: Column(
        //             children: [
        //               Text(value.toString()),
        //               ElevatedButton(
        //                 onPressed: () {
        //                   ref.read(counterStateProvider.state).state++;
        //                 },
        //                 child: Icon(Icons.add),
        //               ),
        //               jokeAsync.when(
        //                 data:
        //                     (joke) => Column(
        //                       children: [
        //                         Text(joke.type),
        //                         Text(joke.setup),
        //                         Text(joke.punchline),
        //                       ],
        //                     ),
        //                 error: (e, st) => Text("error $e"),
        //                 loading: () => CircularProgressIndicator(),
        //               ),
        //               InkWell(
        //                 onTap: () {
        //                   final statePassword = ref.read(
        //                     sliderProvider.notifier,
        //                   );
        //                   statePassword.state = statePassword.state.copyWith(
        //                     showPassword: !slider.showPassword,
        //                   );
        //                 },
        //                 child: Container(
        //                   width: 200,
        //                   height: 200,
        //                   child:
        //                       slider.showPassword
        //                           ? Icon(Icons.remove_red_eye)
        //                           : Icon(Icons.image),
        //                 ),
        //               ),
        //               Container(
        //                 height: 200,
        //                 width: 200,
        //                 color: Colors.red.withOpacity(slider.slider),
        //               ),
        //               Slider(
        //                 value: slider.slider,
        //                 onChanged: (value) {
        //                   final stateProvider = ref.read(
        //                     sliderProvider.notifier,
        //                   );
        //                   stateProvider.state = stateProvider.state.copyWith(
        //                     slider: value,
        //                   );
        //                 },
        //               ),
        //             ],
        //           ),
        //         );
        //       },
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
