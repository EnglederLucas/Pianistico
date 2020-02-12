import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _key = GlobalKey<FormState>();
  String _email;
  String _password;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("SIGNUP"),
          Expanded(
            child: Form(
              key: _key,
              child: Stepper(
                currentStep: _currentStep,
                onStepTapped: (int step) => setState(() => _currentStep = step),
                onStepContinue: _currentStep < 3 ? () => setState(() => _currentStep += 1) : null,
                onStepCancel: _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
                steps: <Step>[
                  _stepEmail(),
                  _stepPassword(),
                  _stepRepeatPassword(),
                  _stepConfirm()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Step _stepEmail(){
    return Step(
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
        title: Text("ENTER EMAIL"),
        content: TextFormField(
          decoration: InputDecoration(
            hintText: "Email"
          ),
          onSaved: (value) => _email = value.trim(),
        )
    );
  }

  Step _stepPassword(){
    return Step(
        isActive: _currentStep >= 0,
        state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
        title: Text("ENTER PASSWORD"),
        content: TextFormField(
          decoration: InputDecoration(
              hintText: "Password"
          ),
          onSaved: (value) => _password = value,
        )
    );
  }

  Step _stepRepeatPassword(){
    return Step(
        isActive: _currentStep >= 0,
        state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
        title: Text("ENTER PASSWORD"),
        content: TextFormField(
          decoration: InputDecoration(
              hintText: "Password"
          ),
          onSaved: (value) => _password = value,
        )
    );
  }

  Step _stepConfirm(){
    return Step(
      isActive: _currentStep >= 0,
      state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
      title: Text("Confirm"),
      content: Column(
        children: <Widget>[
          Text("E-Mail: "),
          RaisedButton(
            child: Text("Submit"),
            onPressed: () {

            },
          )
        ],
      )
    );
  }
}
