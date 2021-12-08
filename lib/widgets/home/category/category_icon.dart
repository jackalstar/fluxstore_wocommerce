import 'package:flutter/material.dart';

import '../../../common/tools.dart';
import '../../../models/config/category_icon_config.dart';
import '../../flux_image.dart';

class CategoryIcon extends StatelessWidget {
  final double iconSize;
  final String name;
  final bool originalColor;
  final double borderWidth;
  final double radius;
  final bool noBackground;
  final Map<String, dynamic> boxShadow;
  final Function onTap;
  final CategoryIconConfig categoryIconConfig;

  CategoryIcon({
    this.iconSize,
    this.name,
    this.originalColor,
    this.borderWidth,
    this.radius,
    this.noBackground,
    this.onTap,
    this.categoryIconConfig,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final disableBackground =
        ((noBackground ?? false) || (originalColor ?? false));

    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        constraints: BoxConstraints(maxWidth: iconSize * 1.2),
        decoration: borderWidth != null
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: borderWidth,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  right: BorderSide(
                    width: borderWidth,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: !disableBackground
                    ? categoryIconConfig.getBackgroundColor
                    : null,
                gradient: !disableBackground
                    ? categoryIconConfig.getGradientColor
                    : null,
                boxShadow: [
                  if (boxShadow != null)
                    BoxShadow(
                      blurRadius: radius,
                      color: Theme.of(context).accentColor.withOpacity(0.5),
                      offset: Offset(Tools.formatDouble(boxShadow['x'] ?? 0.0),
                          Tools.formatDouble(boxShadow['y'] ?? 0.0)),
                    )
                ],
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Container(
                margin: const EdgeInsets.all(12),
                child: FluxImage(
                  imageUrl: categoryIconConfig.imageUrl,
                  color: (originalColor ?? false)
                      ? null
                      : categoryIconConfig.colors.first,
                  width: iconSize,
                  height: iconSize,
                ),
              ),
            ),
            if (name?.isNotEmpty ?? false) ...[
              const SizedBox(height: 6),
              Text(
                name,
                style: Theme.of(context).textTheme.subtitle2,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
