import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UnicodeConversionDemo(),
    );
  }
}

class UnicodeConversionDemo extends StatefulWidget {
  @override
  _UnicodeConversionDemoState createState() => _UnicodeConversionDemoState();
}

class _UnicodeConversionDemoState extends State<UnicodeConversionDemo> {
  TextEditingController _messageController = TextEditingController();

  String unicodeToASCII(String unicodeString) {
    StringBuffer asciiString = StringBuffer();
    for (int i = 0; i < unicodeString.runes.length; i++) {
      int codeUnit = unicodeString.runes.elementAt(i);
      asciiString.write(String.fromCharCode(codeUnit));
    }
    return asciiString.toString();
  }

  String asciiToUnicode(String asciiString) {
    StringBuffer unicodeString = StringBuffer();
    for (int i = 0; i < asciiString.runes.length; i++) {
      int codeUnit = asciiString.codeUnitAt(i);
      unicodeString.write(String.fromCharCode(codeUnit));
    }
    return unicodeString.toString();
  }

  String convertString(String inputString) {
  StringBuffer result = StringBuffer();
  for (int i = 0; i < inputString.runes.length; i++) {
    if (inputString.runes.elementAt(i) > 127) {
      result.write(unicodeToASCII(String.fromCharCode(inputString.runes.elementAt(i))));
    } else {
      result.write(String.fromCharCode(inputString.runes.elementAt(i)));
    }
  }
  return result.toString();
}

String convertBack(String inputString) {
  StringBuffer result = StringBuffer();
  for (int i = 0; i < inputString.runes.length; i++) {
    if (inputString.runes.elementAt(i) > 127) {
      result.write(asciiToUnicode(String.fromCharCode(inputString.runes.elementAt(i))));
    } else {
      result.write(String.fromCharCode(inputString.runes.elementAt(i)));
    }
  }
  return result.toString();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Handling ASCII and Unicode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              cursorColor: Colors.amber,
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Enter your message',
                focusColor: Colors.amber,
                fillColor: Colors.amber,
                iconColor: Colors.amber,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              onPressed: () {
                String message = _messageController.text;
                String convertedMessage = convertString(message);
                String convertedBack = convertBack(convertedMessage);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Conversion Results'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Original Message: $message'),
                          SizedBox(height: 8),
                          Text('Converted Message: $convertedMessage'),
                          SizedBox(height: 8),
                          Text('Converted Back: $convertedBack'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
