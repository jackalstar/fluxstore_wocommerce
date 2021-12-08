part of '../utils.dart';

class ConfigurationUtils {
  static Map loadAdConfig(Map data) {
    final dataAdConfig = List.from([data]);
    if (data?.isNotEmpty ?? false) {
      kAdType.values.forEach((e) {
        if (describeEnum(e) == dataAdConfig[0]['type']) {
          dataAdConfig[0]['type'] = e;
        }
      });
      return dataAdConfig[0];
    }
    return data;
  }

  static List<Map> loadSmartChat(List<Map> data) {
    var dataSmartChat = List<Map<String, dynamic>>.from(data);
    for (var i = 0; i < dataSmartChat.length; i++) {
      var newdata = Map<String, dynamic>.from(dataSmartChat[i]);
      newdata['iconData'] = awesomeIcon[newdata['iconData']];
      dataSmartChat[i] = Map<String, dynamic>.from(newdata);
    }
    return dataSmartChat;
  }

  static Map loadAdvanceConfig(Map data) {
    final dataAvance = List.from([data]);
    dataAvance[0].update(
      'DetailedBlogLayout',
      (value) => kBlogLayout.values.firstWhere(
          (element) => describeEnum(element) == value,
          orElse: () => kBlogLayout.simpleType),
      ifAbsent: () {
        data['DetailedBlogLayout'] = kBlogLayout.simpleType;
      },
    );

    return dataAvance[0];
  }
}
