import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(useConstantCase: true)
abstract class Env {
  @EnviedField()
  static String accessToken = _Env.accessToken;

  @EnviedField()
  static String baseUrl = _Env.baseUrl;
}
