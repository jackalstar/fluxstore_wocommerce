import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/constants.dart';
import '../common/firebase_services.dart';
import '../common/tools.dart';
import '../generated/l10n.dart';
import 'utils.dart';

part 'config/advertise.dart';
part 'config/configurations.dart';
part 'config/data_mapping.dart';
part 'config/default_env.dart';
part 'config/dynamic_link.dart';
part 'config/general.dart';
part 'config/languages.dart';
part 'config/loading.dart';
part 'config/onboarding.dart';
part 'config/payments.dart';
part 'config/products.dart';
part 'config/smartchat.dart';
part 'config/vendor.dart';

Map get serverConfig => Configurations.serverConfig;
