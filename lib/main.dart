import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'IMC Calculator',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Enter your data!';

  void _resetField() {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = 'Enter your data!';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculator() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = 'Under weight (${imc.toStringAsPrecision(3)})';
      } else if (imc > 18.6 && imc < 24.9) {
        _infoText = 'Ideal weight (${imc.toStringAsPrecision(3)})';
      } else if (imc > 24.9 && imc < 29.9) {
        _infoText = 'Slightly overweight (${imc.toStringAsPrecision(3)})';
      } else if (imc > 29.9 && imc < 34.9) {
        _infoText = 'Grade I obesity (${imc.toStringAsPrecision(3)})';
      } else if (imc > 34.9 && imc < 39.9) {
        _infoText = 'Obesity Grade II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        _infoText = 'Grade III obesity (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC Calculator'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetField,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outlined,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: weightController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your Weight!';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: heightController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter your Height!';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? true) {
                        _calculator();
                      }
                    },
                    child: Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
              ),
              Text(_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25)),
            ],
          ),
        ),
      ),
    );
  }
}
