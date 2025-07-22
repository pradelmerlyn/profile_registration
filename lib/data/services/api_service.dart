import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:sprint1_activity/domain/model/registration/user_entity.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/registerUser")
  Future<UserEntity> registerUser(@Body() UserEntity user);

  @GET("/getUsers")
  Future<List<UserEntity>> getUsers();

  @GET("/errorEndpoint")
  Future<void> triggerError();
}
