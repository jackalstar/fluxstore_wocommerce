import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../colors_config/theme.dart';

class ProductAttributeWidget extends StatefulWidget {
  final Map<dynamic, dynamic> attributeMap;
  final Map<dynamic, dynamic> comparedMap;
  final String attributeKey;
  final bool hideVariation;
  final Function(String) onDelete;
  const ProductAttributeWidget({
    Key key,
    this.attributeMap,
    this.attributeKey,
    this.comparedMap,
    this.hideVariation,
    this.onDelete,
  }) : super(key: key);

  @override
  _ProductAttributeWidgetState createState() => _ProductAttributeWidgetState();
}

class _ProductAttributeWidgetState extends State<ProductAttributeWidget> {
  bool isAddNew = false;
  final _addNewController = TextEditingController();

  @override
  void initState() {
    if (!widget.comparedMap['isActive']) {
      widget.attributeMap['options'].clear();
    }
    super.initState();
  }

  void _removeOrAddAttribute(String term) {
    if (widget.attributeMap['options'].contains(term)) {
      widget.attributeMap['options'].remove(term);
    } else {
      widget.attributeMap['options'].add(term);
    }
    setState(() {});
  }

  void _selectAllAttributes() {
    if (!widget.attributeMap['isActive']) {
      return;
    }
    for (var option in widget.comparedMap['options']) {
      if (!widget.attributeMap['options'].contains(option)) {
        widget.attributeMap['options'].add(option);
      }
    }
    setState(() {});
  }

  void _deSelectAllAttributes() {
    if (!widget.attributeMap['isActive']) {
      return;
    }
    widget.attributeMap['options'].clear();
    setState(() {});
  }

  void _onActiveChanged() {
    widget.attributeMap['isActive'] = !widget.attributeMap['isActive'];
    setState(() {});
  }

  void _onVisibleChanged() {
    widget.attributeMap['visible'] = !widget.attributeMap['visible'];
    setState(() {});
  }

  void _onVariationChanged() {
    widget.attributeMap['variation'] = !widget.attributeMap['variation'];
    setState(() {});
  }

  void _addNewAttribute() {
    if (_addNewController.text.isNotEmpty &&
        !widget.attributeMap['options'].contains(_addNewController.text)) {
      widget.attributeMap['options'].add(_addNewController.text);
      widget.comparedMap['options'].add(_addNewController.text);
    }
    _addNewController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
            bottom:
                BorderSide(color: Theme.of(context).accentColor, width: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(
              S.of(context).active,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Expanded(child: SizedBox(width: 10)),
            Checkbox(
              value: widget.attributeMap['isActive'],
              onChanged: (val) => _onActiveChanged(),
              activeColor: ColorsConfig.activeCheckedBoxColor,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.attributeKey.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (!isAddNew)

                    if (isAddNew)
                      Row(
                        children: [
                          InkWell(
                            onTap: () => setState(() => isAddNew = !isAddNew),
                            child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                padding: const EdgeInsets.all(5.0),
                                child: const Icon(
                                  Icons.close,
                                  size: 14.0,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(width: 5.0),
                          Container(
                            width: 50,
                            height: 35,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            margin: const EdgeInsets.only(right: 5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).accentColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextField(
                              controller: _addNewController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 15.0),
                              ),
                              onSubmitted: (val) {
                                _addNewAttribute();
                                isAddNew = false;
                                setState(() {});
                              },
                              maxLines: 1,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                        ],
                      ),
                    Row(
                      children: List.generate(
                        widget.comparedMap['options'].length,
                        (i) {
                          final isChecked = widget.attributeMap['options']
                              .contains(widget.comparedMap['options'][i]);

                          return InkWell(
                            onTap: () => widget.attributeMap['isActive']
                                ? _removeOrAddAttribute(
                                    widget.comparedMap['options'][i])
                                : null,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              margin: const EdgeInsets.only(right: 5.0),
                              decoration: BoxDecoration(
                                color: widget.attributeMap['isActive']
                                    ? isChecked
                                        ? Theme.of(context).primaryColor
                                        : null
                                    : Colors.grey,
                                border: Border.all(
                                    color: Theme.of(context).accentColor,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                widget.comparedMap['options'][i],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: widget.attributeMap['isActive']
                                            ? isChecked
                                                ? Colors.white
                                                : null
                                            : Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).visible,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: widget.attributeMap['isActive']
                              ? null
                              : Colors.grey,
                        ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: Checkbox(
                      value: widget.attributeMap['isActive']
                          ? widget.attributeMap['visible']
                          : false,
                      onChanged: (val) => widget.attributeMap['isActive']
                          ? _onVisibleChanged()
                          : null,
                      activeColor: widget.attributeMap['isActive']
                          ? ColorsConfig.activeCheckedBoxColor
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              if (widget.hideVariation) ...[
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      S.of(context).variation,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: widget.attributeMap['isActive']
                                ? null
                                : Colors.grey,
                          ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: Checkbox(
                        value: widget.attributeMap['isActive']
                            ? widget.attributeMap['variation']
                            : false,
                        onChanged: (val) => widget.attributeMap['isActive']
                            ? _onVariationChanged()
                            : null,
                        activeColor: widget.attributeMap['isActive']
                            ? ColorsConfig.activeCheckedBoxColor
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
              const SizedBox(height: 10),
              if (!widget.attributeMap['default'])
                InkWell(
                  onTap: () => widget.onDelete(widget.attributeKey),
                  child: Text(
                    S.of(context).delete,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.red),
                  ),
                )
            ],
          ),
        ),
      ]),
    );
  }
}
