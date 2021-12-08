import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspireui/widgets/coupon_card.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../common/tools.dart';
import '../../generated/l10n.dart';
import '../../models/entities/coupon.dart';
import '../../models/index.dart' show AppModel, UserModel;
import '../../services/index.dart';
import '../base.dart';

class CouponList extends StatefulWidget {
  final String couponCode;
  final Coupons coupons;
  final Function onSelect;
  final bool isFromCart;

  const CouponList({
    Key key,
    this.couponCode,
    this.coupons,
    this.onSelect,
    this.isFromCart = false,
  }) : super(key: key);

  @override
  _CouponListState createState() => _CouponListState();
}

class _CouponListState extends BaseScreen<CouponList> {
  final services = Services();
  final List<Coupon> _coupons = [];
  final TextEditingController _couponTextController = TextEditingController();

  List<Coupon> _newCoupons;
  String email;
  bool isFetching = false;

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.couponCode != null) {
      setState(() {
        _couponTextController.text = widget.couponCode;
      });
    }

    email = Provider.of<UserModel>(context, listen: false).user?.email;
    _displayCoupons(context);

    /// Fetch new coupons.
    setState(() {
      isFetching = true;
    });
    services.api.getCoupons().then((coupons) {
      _newCoupons = coupons.coupons;
      setState(() {
        isFetching = false;
      });
      _displayCoupons(context);
    });
  }

  void _displayCoupons(BuildContext context) {
    _coupons.clear();
    _coupons.addAll(List.from(_newCoupons ?? widget.coupons?.coupons ?? []));

    final bool showAllCoupons = kAdvanceConfig['ShowAllCoupons'] ?? false;
    final bool showExpiredCoupons =
        kAdvanceConfig['ShowExpiredCoupons'] ?? false;

    final searchQuery = _couponTextController.text.toLowerCase();

    _coupons.retainWhere((c) {
      var shouldKeep = true;

      /// Hide expired coupons
      if (!showExpiredCoupons && c.dateExpires != null) {
        shouldKeep &= c.dateExpires.isAfter(DateTime.now());
      }

      /// Search for coupons using code & description
      /// Users can search for any coupons by entering
      /// any part of code or description when showAllCoupons is true.
      if (showAllCoupons && searchQuery.isNotEmpty) {
        shouldKeep &= ('${c.code}'.toLowerCase().contains(searchQuery) ||
            '${c?.description ?? ''}'.toLowerCase().contains(searchQuery));
      }

      /// Search for coupons using exact code.
      /// Users can search for hidden coupons by entering
      /// exact code when showAllCoupons is false.
      if (!showAllCoupons && searchQuery.isNotEmpty) {
        shouldKeep &= '${c.code}'.toLowerCase() == searchQuery;
      }

      /// Show only coupons which is restricted to user.
      if (!showAllCoupons && searchQuery.isEmpty) {
        shouldKeep &= c.emailRestrictions.contains(email);
      }

      /// Hide coupons which is restricted to other users.
      if (showAllCoupons &&
          searchQuery.isEmpty &&
          c.emailRestrictions.isNotEmpty) {
        shouldKeep &= c.emailRestrictions.contains(email);
      }

      return shouldKeep;
    });

    // _coupons.sort((a, b) => b.emailRestrictions.contains(email) ? 0 : -1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;
    final model = Provider.of<AppModel>(context);

    return Scaffold(
      backgroundColor: isDarkTheme ? theme.backgroundColor : theme.cardColor,
      appBar: AppBar(
        backgroundColor: isDarkTheme ? theme.backgroundColor : theme.cardColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
          ),
        ),
        titleSpacing: 0.0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.only(left: 24),
          margin: const EdgeInsets.only(right: 24.0),
          child: TextField(
            onChanged: (_) {
              _displayCoupons(context);
            },
            controller: _couponTextController,
            onSubmitted: (_) {
              if (_coupons?.isEmpty ?? true) {
                showCupertinoDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                    title: const Text('Notice'),
                    content: Text(S.of(context).couponInvalid),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        isDefaultAction: true,
                        onPressed: () => Navigator.of(ctx).pop(),
                      )
                    ],
                  ),
                );
              }
            },
            decoration: InputDecoration(
              fillColor: Theme.of(context).accentColor,
              border: InputBorder.none,
              hintText: S.of(context).couponCode,
              focusColor: Theme.of(context).accentColor,
              suffixIcon: IconButton(
                onPressed: () {
                  _couponTextController.clear();
                  _displayCoupons(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Theme.of(context).accentColor.withOpacity(0.7),
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color:
                  isDarkTheme ? theme.backgroundColor : theme.primaryColorLight,
              child: (isFetching && (_coupons?.isEmpty ?? true))
                  ? kLoadingWidget(context)
                  : ListView.builder(
                      itemCount: _coupons?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final coupon = _coupons[index];
                        if (coupon == null || coupon?.code == null) {
                          return const SizedBox();
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 8.0,
                          ),
                          child: CouponItem(
                            translate: CouponTrans(context),
                            getCurrencyFormatted: (data) {
                              return Tools.getCurrencyFormatted(
                                data,
                                model.currencyRate,
                                currency: model.currency,
                              );
                            },
                            coupon: coupon,
                            onSelect: widget.onSelect,
                            email: email,
                            isFromCart: widget.isFromCart,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
