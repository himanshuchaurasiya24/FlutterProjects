import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart' as pip;

class PIPView extends StatefulWidget {
  const PIPView({super.key});

  @override
  State<PIPView> createState() => _PIPViewState();
}

class _PIPViewState extends State<PIPView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PiP View'),
        centerTitle: true,
      ),
      body: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return pip.PIPView(
      builder: (context, isFloating) {
        return Scaffold(
          resizeToAvoidBottomInset: !isFloating,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Center(
                      child: Text('This is the PiP Window'),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    MaterialButton(
                      onPressed: () {
                        pip.PIPView.of(context)!.presentBelow(
                          const BackgroundScreen(),
                        );
                      },
                      child: const Text('Start Floating'),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text('This is the background page!'),
          ),
        ),
      ),
    );
  }
}
