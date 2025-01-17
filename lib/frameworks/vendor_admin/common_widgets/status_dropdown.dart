import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class StatusDropdown extends StatefulWidget {
  final Function(String) onCallBack;
  final String status;
  const StatusDropdown({Key key, this.onCallBack, this.status})
      : super(key: key);
  @override
  _StatusDropdownState createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<StatusDropdown> {
  final List<String> statuses = ['draft', 'pending', 'private', 'publish'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: widget.status,
        elevation: 16,
        style: Theme.of(context).textTheme.subtitle1,
        onChanged: (String newValue) {
          widget.onCallBack(newValue);
        },
        items: List.generate(statuses.length, (index) {
          String text;
          switch (statuses[index]) {
            case 'publish':
              text = S.of(context).publish;
              break;
            case 'draft':
              text = S.of(context).draft;
              break;
            case 'pending':
              text = S.of(context).pending;
              break;
            case 'private':
              text = S.of(context).private;
              break;
          }
          return DropdownMenuItem<String>(
            value: statuses[index],
            child: Text(
              text,
              style: Theme.of(context).textTheme.caption,
            ),
          );
        }));
  }
}
