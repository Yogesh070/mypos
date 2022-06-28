import 'package:mypos/components/primary_button.dart';
import 'package:mypos/utils/constant.dart';
import 'package:flutter/material.dart';

class SplitPaymentInputRow extends StatefulWidget {
  const SplitPaymentInputRow({Key? key}) : super(key: key);

  @override
  _SplitPaymentInputRowState createState() => _SplitPaymentInputRowState();
}

class _SplitPaymentInputRowState extends State<SplitPaymentInputRow> {
  final List<String> items = ['Cash', 'Online', 'Card', 'Credit'];
  String dropdownValue = 'Cash';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.4, color: Colors.black),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  iconSize: 35,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: items
                      .map((values) => DropdownMenuItem(
                            child: Text(
                              values,
                              style: const TextStyle(fontSize: 16),
                            ),
                            value: values,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, bottom: 8),
                    alignLabelWithHint: true,
                    hintText: 'Amount',
                    labelStyle: TextStyle(color: kAccentColor),
                    labelText: 'Amount',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kAccentColor, width: 1),
                    ),
                  ),
                  onSaved: (String? value) {
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  validator: (value) {
                    return null;
                  }),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          PrimaryButton(title: 'Pay', onPressed: () {}),
        ],
      ),
    );
  }
}
