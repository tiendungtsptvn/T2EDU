
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:t4edu_source_source/domain/models/access_token.dart';
import 'package:t4edu_source_source/domain/repository/auth_repository.dart';
import 'package:t4edu_source_source/instance/Session.dart';
import 'package:t4edu_source_source/source/api/api_error.dart';
import 'package:t4edu_source_source/source/api/client/rest/auth_client.dart';

const String resendOTPPath = '/auth/forgot-password';

const String registerPath = '/auth/register';
const otpConfirmedPath = '/auth/confirm-code';

class AuthRepositoryIml extends AuthRepository {
  ClientAuth _clientAuth = GetIt.I<ClientAuth>();
  // FirebaseAuth _firebaseAuth;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthRepositoryIml(this._clientAuth);

  @override
  Future<Map> userLogin(String username, String password) async {
    try {
      String path = "/auth/login";

      final dynamic response = await _clientAuth.post(path,
          data: <String, dynamic>{
            'emailOrPhone': username,
            'password': password
          },
          mapDataError: [
            "emailOrPhone",
            "password"
          ]);

      if (response is Map) {
        Token token = Token.fromJson(response as Map<String, dynamic>);

        if (token != null) {
          Session.instance()
            ..setAccessToken(token.accessToken)
            ..setRefreshToken(token.refreshToken);
          return response;
        }
      }
      throw ApiError.fromResponse(response);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<Map> registerAccount(String emailOrPhone, String firstName,
      String lastName, String pass) async {
    try {
      final dynamic response =
          await _clientAuth.post(registerPath, data: <String, dynamic>{
        "emailOrPhoneNumber": emailOrPhone,
        "firstName": firstName,
        "lastName": lastName,
        "password": pass,
      }, mapDataError: [
        "emailOrPhoneNumber",
        "firstName",
        "lastName",
        "password"
      ]);
      if (response is Map) {
        return response;
      }
      throw ApiError.fromResponse(response);
    } catch (error) {
      throw error;
    }
  }

  //OTp register confirm from branch develop 31/07/2021
  @override
  Future resendOTP(String emailOrPhone) async {
    try {
      await _clientAuth.post(resendOTPPath, data: <String, dynamic>{
        "emailOrPhoneNumber": emailOrPhone,
      }, mapDataError: [
        "emailOrPhoneNumber",
      ]);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future otpRegisterConfirm(String emailOrPhone, String code) async {
    try {
      await _clientAuth.post(otpConfirmedPath, data: <String, dynamic>{
        "code": code,
        "emailOrPhoneNumber": emailOrPhone,
      }, mapDataError: [
        "code",
        "emailOrPhoneNumber"
      ]);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<String> userConfirmCodeForPass(String code, String username) async {
    try {
      String path = "/auth/confirm-code-forgot-password";

      final dynamic response =
          await _clientAuth.post(path, data: <String, dynamic>{
        'code': code,
        'emailOrPhoneNumber': username,
      }, mapDataError: [
        'code',
        "emailOrPhoneNumber",
      ]);
      if (response is String) {
        return response;
      }
      throw ApiError.fromResponse(response);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> userForgotPassword(String username) async {
    try {
      String path = "/auth/forgot-password";

      await _clientAuth.post(path, data: <String, dynamic>{
        'emailOrPhoneNumber': username,
      }, mapDataError: [
        "emailOrPhoneNumber",
      ]);
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> userResetPassword(String password, String token) async {
    try {
      String path = "/auth/reset-password";

      await _clientAuth.post(path, data: <String, dynamic>{
        "password": password,
        "token": token,
      }, mapDataError: [
        'password',
        "token",
      ]);
    } catch (error) {
      throw error;
    }
  }


  Future<GoogleSignInAccount> signInWithGoogle() async {
    try{
      final GoogleSignInAccount googleSignInAccount =
      await _googleSignIn.signIn();
      return googleSignInAccount;
    }
    catch(e){
      throw e;
    }
  }

  Future<Map> signInWithFacebook() async {
    Map userData;
    try{
      var result = await FacebookAuth.i.login(
        permissions: ["public_profile", "email"],
      );
      if(result.status == LoginStatus.success){
        final responseData = await FacebookAuth.i.getUserData(
          fields: "email, name, picture",
        );
        userData = responseData;
        return userData;
      }
      return null;
    }
    catch(e){
      throw e;
    }
  }

}
