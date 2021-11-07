import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  String? errorText;
  String convertedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Currency convertor"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Image.asset('assets/money.jpg'),
          Container(
            margin: const EdgeInsetsDirectional.all(16.0),
            child: TextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (String? value) {
                final double? doubleValue = double.tryParse(value!);

                setState(() {
                  if (doubleValue == null) {
                    errorText = "Please enter a number!";
                  } else {
                    errorText = null;
                  }
                });
              },
              decoration: InputDecoration(
                  hintText: 'Enter the amount in EUR',
                  errorText: errorText,
                  suffix: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      controller.clear();

                      setState(() {
                        convertedText = "";
                      });
                    },
                  )),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final String value = controller.text;

              setState(() {
                if (value == "") {
                  errorText = "Please enter a number!";
                } else {
                  final double? intValue = double.tryParse(value);
                  double? convertedValue;

                  if (intValue != null) {
                    double convertedValue = intValue * 4.95;
                    convertedText = convertedValue.toStringAsFixed(3) + " RON";
                  } else {
                    convertedText = "";
                  }
                }
              });

              FocusScope.of(context).requestFocus(FocusNode());
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            child: const Text("CONVERT!"),
          ),
          Text(
            convertedText,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )
        ])));
  }
}
