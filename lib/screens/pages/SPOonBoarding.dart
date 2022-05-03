import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../services/firebase_api_methods.dart';

class SPOnBoarding extends StatefulWidget {
  @override
  _SPOnBoardingState createState() => _SPOnBoardingState();
}

class _SPOnBoardingState extends State<SPOnBoarding> {

  int _activeStepIndex = 0;
  TextEditingController name = TextEditingController();
  //TextEditingController company_name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController address= TextEditingController();
  TextEditingController service_type = TextEditingController();
  //TextEditingController sp_id = TextEditingController();
  TextEditingController holder_name = TextEditingController();
  TextEditingController acc_number = TextEditingController();
  TextEditingController ifs_code= TextEditingController();
  TextEditingController bank_name= TextEditingController();
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
            /*const SizedBox(
              height: 12,
            ),
            TextField(
              controller: sp_id,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Service Provider ID ',
              ),
            ),*/
            /*const SizedBox(
              height: 12,
            ),
            TextField(
              controller: company_name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Company Name',
              ),
            ),*/
            const SizedBox(

              height: 12,
            ),
            TextField(
              controller: service_type,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type Of Service',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: location,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Location',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: pincode,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pincode',
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
                //Text('Service Provider ID : ${sp_id.text}'),
                //Text('Company Name: ${company_name.text}'),
                Text('Type Of Service: ${service_type.text}'),
                Text('Location : ${location.text}'),
                Text('PinCode : ${pincode.text}'),
                Text('Phone Number: ${phone_number.text}'),
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
            updateFirebaseProfileFillStatus(user.uid,false);
            sp_onboarding(user.uid,name.text,service_type.text,location.text,
                phone_number.text,holder_name.text,acc_number.text,ifs_code.text,bank_name.text,pincode.text)
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