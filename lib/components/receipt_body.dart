import 'package:mypos/components/primary_button.dart';
import 'package:mypos/components/secondary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReceiptBody extends StatefulWidget {
  const ReceiptBody({Key? key}) : super(key: key);

  @override
  _ReceiptBodyState createState() => _ReceiptBodyState();
}

class _ReceiptBodyState extends State<ReceiptBody> {
  bool? _selectedValue = false;
  bool? _anotherSelectedValue = false;
  String? dropdownValue = 'English';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Enter header"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              decoration: const InputDecoration(hintText: "Enter footer"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Text(
                  'Show customer info',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  trackColor: Colors.black,
                  value: _selectedValue!,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Divider(
              color: Colors.grey.shade400,
              thickness: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 14.0),
                  child: Text(
                    'Show comments',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    trackColor: Colors.black,
                    value: _anotherSelectedValue!,
                    onChanged: (value) {
                      setState(() {
                        _anotherSelectedValue = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Divider(
              color: Colors.grey.shade400,
              thickness: 1.0,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonFormField(
              decoration: const InputDecoration.collapsed(hintText: ''),
              isDense: true,
              iconSize: 40.0,
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  SizedBox(
                    width: 225.0,
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.black,
                  ),
                ],
              ),
              value: dropdownValue,
              items: <String>['English', 'Nepali', 'Chinease', 'Korean']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButton(title: 'Cancel', onPressed: () => {}),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: PrimaryButton(title: 'Save', onPressed: () => {}),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
