import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:sprint1_activity/domain/entities/registration/user_entity.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("users/{id}")
  Future<UserEntity> getUser(@Path("id") int id);
}
