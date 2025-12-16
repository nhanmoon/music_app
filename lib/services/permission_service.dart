import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestStorage() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }
}
