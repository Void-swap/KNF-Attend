import 'package:flutter/material.dart';

class RadioButtonCard extends StatefulWidget {
  final List<int> selectedRadio;
  final int index;
  final String mentee;
  final String mentor;

  RadioButtonCard({
    required this.selectedRadio,
    required this.index,
    required this.mentee,
    required this.mentor,
  });

  @override
  _RadioButtonCardState createState() => _RadioButtonCardState();
}

class _RadioButtonCardState extends State<RadioButtonCard> {
  int? _selection;

  @override
  void initState() {
    super.initState();
    _selection = widget.selectedRadio[widget.index];
  }

  setSelectedRadio(int? val) {
    setState(() {
      _selection = val;
      widget.selectedRadio[widget.index] = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = _selection == 0
        ? Colors.blueGrey.shade100.withOpacity(0.8)
        : _selection == 1
            ? Colors.red[200]!
            : Colors.green[300]!;
    Color textColor =
        ThemeData.estimateBrightnessForColor(cardColor) == Brightness.dark
            ? Colors.white
            : Colors.black87;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.mentee,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: textColor,
                      ),
                    ),
                    Text(
                      widget.mentor,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RadioListTile(
                  activeColor: Colors.red[700],
                  value: 1,
                  groupValue: _selection,
                  onChanged: (val) {
                    setSelectedRadio(val);
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  activeColor: Colors.green[700],
                  value: 2,
                  groupValue: _selection,
                  onChanged: (val) {
                    setSelectedRadio(val);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
