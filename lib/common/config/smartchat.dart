part of '../config.dart';

Map get kConfigChat => Configurations.configChat;

/// config for the chat app
/// config Whatapp: https://faq.whatsapp.com/en/iphone/23559013
List<Map> get smartChat => Configurations.smartChat;
String get adminEmail => Configurations.adminEmail;
String get adminName => Configurations.nameDefault;

Map awesomeIcon = {
  'whatsapp': FontAwesomeIcons.whatsapp,
  'phone': FontAwesomeIcons.phone,
  'sms': FontAwesomeIcons.sms,
  'google': FontAwesomeIcons.google,
  'facebookMessenger': FontAwesomeIcons.facebookMessenger,
};
