import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/config.dart';
import '../../../generated/l10n.dart';
import '../../../models/entities/vendor_admin_variation.dart';
import '../colors_config/theme.dart';
import 'edit_product_info_widget.dart';

class VariationProductWidget extends StatefulWidget {
  final productAttributes;
  final VendorAdminVariation variation;
  final Function onDelete;
  const VariationProductWidget(
      {Key key, this.productAttributes, this.variation, this.onDelete})
      : super(key: key);
  @override
  _VariationProductWidgetState createState() => _VariationProductWidgetState();
}

class _VariationProductWidgetState extends State<VariationProductWidget> {
  final TextEditingController _regularPriceController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  var keys = [];

  void _setManageStock() {
    widget.variation.isManageStock = !widget.variation.isManageStock;
    setState(() {});
  }

  void _setEnable() {
    widget.variation.isActive = !widget.variation.isActive;
    setState(() {});
  }

  @override
  void initState() {
    widget.productAttributes.forEach((k, v) {
      if (v['isActive'] && v['variation']) {
        keys.add(k);
      }
    });
    _regularPriceController.text = widget.variation.regularPrice.toString();
    _salePriceController.text = widget.variation.salePrice.toString();
    _stockController.text = widget.variation.stockQuantity.toString();

    _regularPriceController.addListener(() {
      if (_regularPriceController.text.isNotEmpty) {
        widget.variation.regularPrice =
            double.parse(_regularPriceController.text);
      } else {
        widget.variation.regularPrice = 0.0;
      }
    });
    _salePriceController.addListener(() {
      if (_salePriceController.text.isNotEmpty) {
        widget.variation.salePrice = double.parse(_salePriceController.text);
      } else {
        widget.variation.salePrice = 0.0;
      }
    });
    _stockController.addListener(() {
      if (_stockController.text.isNotEmpty) {
        widget.variation.stockQuantity = int.parse(_stockController.text);
      } else {
        widget.variation.stockQuantity = 0;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _regularPriceController.dispose();
    _salePriceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _setAttribute(String key, int index) {
    final attrKey = widget.productAttributes[key]['default']
        ? 'pa_${key.toLowerCase()}'
        : '${key.toLowerCase()}';
    if (index == 0) {
      widget.variation.attributes[attrKey] = '';
      setState(() {});
      return;
    }

    widget.variation.attributes[attrKey] =
        widget.productAttributes[key]['options'][index - 1];
    setState(() {});
  }

  void _showAttributeOption(key, options) {
    final attrKey = widget.productAttributes[key]['default']
        ? 'pa_${key.toLowerCase()}'
        : '${key.toLowerCase()}';
    var list = [];
    list.addAll(options);
    list.insert(0, 'Any');
    int selected;
    if (widget.variation.attributes[attrKey] == null ||
        widget.variation.attributes[attrKey].isEmpty) {
      selected = 0;
    } else {
      selected = options.indexWhere((element) =>
          element.toLowerCase() ==
          widget.variation.attributes[attrKey].toLowerCase());
      selected++;
    }
    selected ??= 0;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: (context),
      builder: (_) => Container(
        height: 200,
        color: Theme.of(context).backgroundColor,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(initialItem: selected),
          itemExtent: 30,
          onSelectedItemChanged: (val) => _setAttribute(key, val),
          children: List.generate(
            list.length,
            (index) => Center(
              child: Text(
                list[index],
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> defaultCurrency = kAdvanceConfig['DefaultCurrency'];
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).accentColor, width: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 15),
              Text(
                S.of(context).active,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: widget.variation.isActive,
                  onChanged: (val) => _setEnable(),
                  activeColor: ColorsConfig.activeCheckedBoxColor,
                ),
              ),
              const Expanded(
                child: SizedBox(
                  width: 1,
                ),
              ),
              Text(
                S.of(context).manageStock,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: widget.variation.isManageStock,
                  onChanged: (val) =>
                      widget.variation.isActive ? _setManageStock() : null,
                  activeColor: widget.variation.isActive
                      ? ColorsConfig.activeCheckedBoxColor
                      : Colors.grey,
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  keys.length,
                  (index) {
                    final attrKey = widget.productAttributes[keys[index]]
                            ['default']
                        ? 'pa_${keys[index].toLowerCase()}'
                        : '${keys[index].toLowerCase()}';

                    return InkWell(
                      onTap: () => widget.variation.isActive
                          ? _showAttributeOption(keys[index],
                              widget.productAttributes[keys[index]]['options'])
                          : null,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: widget.variation.isActive
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(15.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          children: [
                            Text(
                              (widget.variation.attributes[attrKey] == null ||
                                      widget.variation.attributes[attrKey]
                                          .isEmpty)
                                  ? keys[index].toUpperCase()
                                  : widget.variation.attributes[attrKey]
                                      .toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 2),
                            const SizedBox(
                                width: 22,
                                height: 22,
                                child: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          EditProductInfoWidget(
            controller: _regularPriceController,
            label: S.of(context).regularPrice,
            keyboardType: TextInputType.number,
            enable: widget.variation.isActive,
            prefixIcon: Container(
                width: 1,
                height: 1,
                padding: const EdgeInsets.only(bottom: 4.0, right: 5.0),
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                decoration: const BoxDecoration(
                  border:
                      Border(right: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Center(
                    child: Text(
                  defaultCurrency['symbol'],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: widget.variation.isActive ? null : Colors.grey),
                ))),
          ),
          EditProductInfoWidget(
            controller: _salePriceController,
            label: S.of(context).salePrice,
            keyboardType: TextInputType.number,
            enable: widget.variation.isActive,
            prefixIcon: Container(
                width: 1,
                height: 1,
                padding: const EdgeInsets.only(bottom: 4.0, right: 5.0),
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                decoration: const BoxDecoration(
                  border:
                      Border(right: BorderSide(color: Colors.grey, width: 0.5)),
                ),
                child: Center(
                    child: Text(
                  defaultCurrency['symbol'],
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: widget.variation.isActive ? null : Colors.grey),
                ))),
          ),
          if (widget.variation.isManageStock)
            EditProductInfoWidget(
              controller: _stockController,
              label: S.of(context).stockQuantity,
              keyboardType: TextInputType.number,
              enable: widget.variation.isActive,
            ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                _regularPriceController.clear();
                _salePriceController.clear();
                _stockController.clear();
                widget.onDelete();
              },
              child: Text(
                S.of(context).remove,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
