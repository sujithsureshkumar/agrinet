import 'package:AgriNet/providers/laborProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../services/firebase_api_methods.dart';

class LabourOnboarding extends StatefulWidget {
  @override
  _LabourOnboardingState createState() => _LabourOnboardingState();
}

class _LabourOnboardingState extends State<LabourOnboarding> {

  int _activeStepIndex = 0;
  TextEditingController name = TextEditingController();
  TextEditingController skill = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _locality = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController holder_name = TextEditingController();
  TextEditingController acc_number = TextEditingController();
  TextEditingController ifs_code= TextEditingController();
  TextEditingController bank_name= TextEditingController();

  Widget locationTextField(TextEditingController name,String label) {
    return TextFormField(
      controller: name,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
      enabled:false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        labelText: label,
        //helperText: "Name can't be empty",
      ),
    );
  }
  List<Step> stepList() => [
    Step(
      state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeStepIndex >= 0,
      title: const Text('Account'),
      content: Container(
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: phone_number,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            locationTextField(skill,"Skill"),
            const SizedBox(
              height: 12,
            ),
            locationTextField(_locality,"Locality"),
            const SizedBox(
              height: 12,
            ),
            locationTextField(_district,"District"),
            const SizedBox(
              height: 12,
            ),
            locationTextField(_state,"State"),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: pincode,
              //obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pincode',
              ),
            ),




          ],
        ),
      ),
    ),
    Step(
        state:
        _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 1,
        title: const Text('Bank Details'),
        content: Container(
          child: Column(
            children: [

              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: holder_name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'A/c Holder Name',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: acc_number,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'A/c Number',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: ifs_code,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'IFS Code',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: bank_name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bank Name',
                ),
              ),
            ],
          ),
        )),
    Step(
        state: StepState.complete,
        isActive: _activeStepIndex >= 2,
        title: const Text('Confirm'),
        content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Phone Number: ${phone_number.text}'),
                Text('Location : ${location.text}'),
                Text('PinCode : ${pincode.text}'),
                Text('A/c Holder Name: ${holder_name.text}'),
                Text('A/c Number : ${acc_number.text}'),
                Text('IFS Code: ${ifs_code.text}'),
                Text('Bank Name : ${bank_name.text}'),
              ],
            )))
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    LaborProvider laborData =Provider.of<LaborProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Provider Onboarding '),

        backgroundColor:Colors.green,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            labour_onboarding(user.uid,name.text,
                phone_number.text,skill.text,_locality.text,
                _district.text,_state.text,pincode.text,holder_name.text,acc_number.text,
              ifs_code.text,bank_name.text,false)
                .then((value) => laborData.spFormFillCheck(user.uid))
                .then((value) => {
              Navigator.pop(context)
            });
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final isLastStep = _activeStepIndex == stepList().length - 1;
          return Container(
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: details.onStepContinue,
                    child: (isLastStep)
                        ? const Text('Submit')
                        : const Text('Next'),
                  ),
                ),
                if (_activeStepIndex > 0)
                  const SizedBox(
                    width: 10,
                  ),
                if (_activeStepIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}