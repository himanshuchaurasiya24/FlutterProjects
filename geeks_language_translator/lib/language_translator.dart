import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  var languages = ['Hindi', 'English', 'Arabic'];
  var originLanguage = 'From';
  var destinationLanguage = 'To';
  var output = '';
  final controller = TextEditingController();
  void translate(String src, String dest, String input) async {
    if (originLanguage == 'From' || destinationLanguage == 'To') {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog.adaptive(
            icon: Icon(Icons.error),
            title: Text('Select language first'),
          );
        },
      );
      return;
    } else if (controller.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog.adaptive(
            icon: Icon(Icons.error),
            title: Text('Enter text to translate'),
          );
        },
      );
      return;
    } else {
      GoogleTranslator translator = GoogleTranslator();
      var translatedText =
          await translator.translate(input, from: src, to: dest);
      setState(() {
        if (src == '--' || dest == '--') {
          output = 'Failed to translate text';
        } else {
          output = translatedText.text.toString();
        }
      });
    }

    // setState(() {
    //   output = translatedText.text.toString();
    // });
    // if (src == '--' || dest == '--') {
    //   setState(() {
    //     output = 'Failed to translate';
    //   });
    // }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Hindi') {
      return 'hi';
    } else if (language == 'Arabic') {
      return 'ar';
    }
    return '--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10223d),
      appBar: AppBar(
        backgroundColor: const Color(0xff10223d),
        title: const Text(
          'Language Translator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Text(
                  output,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                      focusColor: Colors.white,
                      iconDisabledColor: Colors.red,
                      iconEnabledColor: Colors.black,
                      hint: Text(
                        originLanguage,
                        style: const TextStyle(color: Colors.black),
                      ),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: languages
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          originLanguage = value!;
                        });
                      }),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                      focusColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.black,
                      hint: Text(
                        destinationLanguage,
                        style: const TextStyle(color: Colors.black),
                      ),
                      dropdownColor: Colors.white,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: languages
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          destinationLanguage = value!;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  onFieldSubmitted: (value) {
                    translate(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      controller.text,
                    );
                  },
                  autofocus: false,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Please enter your text here',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Text';
                    } else if (destinationLanguage == 'To' ||
                        originLanguage == 'From') {
                      return 'Please select language';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // backgroundColor: const Color(0xff2b3c5a),
                      ),
                  onPressed: () {
                    translate(
                      getLanguageCode(originLanguage),
                      getLanguageCode(destinationLanguage),
                      controller.text,
                    );
                  },
                  child: const Text('Translate'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
