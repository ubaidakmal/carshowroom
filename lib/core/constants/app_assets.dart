/// Central paths for bundled assets. Add files under [assets/images/] and
/// reference them here only (no string literals scattered in widgets).
abstract final class AppAssets {
  AppAssets._();

  static const String _images = 'assets/images';

  static const String logo = '$_images/logo.png';
  static const String onboardImage1 = '$_images/1.png';
  static const String onboardImage2 = '$_images/2.png';
  static const String onboardImage3 = '$_images/3.png';
  static const String steering = '$_images/staring.png';
  static const String arrow = '$_images/arrows.png';
  static const String splashBackground = '$_images/splash_background.png';

  static const String profileAvatar = '$_images/profile_avatar.png';
  static const String carBmw = '$_images/car_bmw.png';

  static const String car1 = '$_images/car1.png';
  static const String car2 = '$_images/car2.png';
  static const String car3 = '$_images/car3.png';
  static const String car4 = '$_images/car4.png';

  static const String bmwModel3D = '$_images/bmw.glb';
  static const String bmwModel3D2 = '$_images/bmw4.glb';
}
