import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final SECURE_STORAGE = FlutterSecureStorage();

const ACCESS_TOKEN_LOCAL_KEY = "ACESSTOKEN";
const REFRESH_TOKEN_LOCAL_KEY = "RELASHTOKEN";

final dio = Dio();
final simulatorIp = "127.0.0.1:3000";
final emulatorIp = "10.0.2.2:3000";

final ip = Platform.isIOS ? simulatorIp : emulatorIp;
