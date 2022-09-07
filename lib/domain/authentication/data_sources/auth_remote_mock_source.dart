import 'package:ota/domain/authentication/models/login_detail.dart';
import 'package:ota/domain/authentication/models/logout_detail.dart';
import 'package:ota/domain/authentication/models/refresh_detail.dart';

import 'auth_remote_data_source.dart';

class AuthMockDataSourceImpl implements AuthRemoteDataSource {
  AuthMockDataSourceImpl();
  @override
  Future<LoginDetail> getLoginDetail(
      {required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    return LoginDetail.fromJson(_responseMock);
  }

  @override
  Future<LogoutDetail> logOut(String username) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return LogoutDetail.fromJson(_responseMockLogout);
  }

  @override
  Future<RefreshDetail> refreshToken(String refreshToken) async {
    await Future.delayed(const Duration(milliseconds: 10));
    return RefreshDetail.fromJson(_responseRefreshMock);
  }
}

var _responseMock = """
  {
    "getLoginDetails": {
      "data": {
        "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJiakF4OEp0NXVvUXJHaHpvR2dybVU1NXRWSXRNNFZtY3F4UTZXZjZLdmJFIn0.eyJleHAiOjE2Mjk5NzAyNDgsImlhdCI6MTYyOTk2OTE2OCwianRpIjoiYWRiM2Q3MmEtMmJjNi00ZjVkLThhYmEtN2IzZDBiNWQxMDNkIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay1pbnRlcm5hbC5ucC5hZWxsYS50ZWNoL2F1dGgvcmVhbG1zL09UQS1kZXYiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMjVkNWM1YmUtOWM0OC00YWJiLTliMzctYTcwNmFhYTlkOWZhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoib3RhLXVzZXIiLCJzZXNzaW9uX3N0YXRlIjoiY2U3Yzg4ZDEtZTEzYy00NzlkLTg0NTYtZDY0ZGM1ZTIzMjFhIiwiYWNyIjoiMSIsInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicHJlZmVycmVkX3VzZXJuYW1lIjoib3RhZGV2dXNlciJ9.bZV3lS4arxI3hENb3i1sJF0gALr7YWRL6h01RYng2A2NuQtGaotjaJAAkINWB4RbOlyweCGhxRpIKUqZWp4GdfSQNyYM73te50BJU0d2-FMXq0X4WolZnrqjjW9g_ufjNmBzTANiVDF5CNcRJ9Ulvwl0blU3F2x3-qRN39Jgcf2BkyG-VOEIG9dRvVJ9yt1wugFwqX4uUSKoFwZh6V0C1oEKWxTATvobe2_OMtni6k44WXGZIYFyOfb1q1iPU8r8W9js9aN3QL6wsYnkb5_C2n1iFlm6sD2-NKx05nP2fgQe49jdy_ULjqgskeOpkL61oY7EJid-lPVdIO31m34nXg",
        "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI2MzhmNTU2ZS1hOTAyLTQyMTgtOGNhMi1mYjk2NWI3OWYyYzQifQ.eyJleHAiOjE2Mjk5NzA5NjgsImlhdCI6MTYyOTk2OTE2OCwianRpIjoiNWIzYTkzMjQtNjg5My00OWIyLWFjYTMtMDY1MTU3MzY4ZGZiIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay1pbnRlcm5hbC5ucC5hZWxsYS50ZWNoL2F1dGgvcmVhbG1zL09UQS1kZXYiLCJhdWQiOiJodHRwczovL2tleWNsb2FrLWludGVybmFsLm5wLmFlbGxhLnRlY2gvYXV0aC9yZWFsbXMvT1RBLWRldiIsInN1YiI6IjI1ZDVjNWJlLTljNDgtNGFiYi05YjM3LWE3MDZhYWE5ZDlmYSIsInR5cCI6IlJlZnJlc2giLCJhenAiOiJvdGEtdXNlciIsInNlc3Npb25fc3RhdGUiOiJjZTdjODhkMS1lMTNjLTQ3OWQtODQ1Ni1kNjRkYzVlMjMyMWEiLCJzY29wZSI6Im9wZW5pZCBlbWFpbCBwcm9maWxlIn0.IgwKbFaoBnzaxO9GNoquhArGJPBCaSqbNrjfdbefTLw",
        "expiresIn": 1080,
        "refreshExpiresIn": 1800,
        "scope": "openid email profile",
        "idToken": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJiakF4OEp0NXVvUXJHaHpvR2dybVU1NXRWSXRNNFZtY3F4UTZXZjZLdmJFIn0.eyJleHAiOjE2Mjk5NzAyNDgsImlhdCI6MTYyOTk2OTE2OCwiYXV0aF90aW1lIjowLCJqdGkiOiJjNzBmZmQ0My05NGZjLTRjYWEtYjJmNC1hNjhlMjgyNTEyNWMiLCJpc3MiOiJodHRwczovL2tleWNsb2FrLWludGVybmFsLm5wLmFlbGxhLnRlY2gvYXV0aC9yZWFsbXMvT1RBLWRldiIsImF1ZCI6Im90YS11c2VyIiwic3ViIjoiMjVkNWM1YmUtOWM0OC00YWJiLTliMzctYTcwNmFhYTlkOWZhIiwidHlwIjoiSUQiLCJhenAiOiJvdGEtdXNlciIsInNlc3Npb25fc3RhdGUiOiJjZTdjODhkMS1lMTNjLTQ3OWQtODQ1Ni1kNjRkYzVlMjMyMWEiLCJhY3IiOiIxIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJvdGFkZXZ1c2VyIn0.mY6BVcytlmZk0814KFxMZoBYFNV6HpYWOcZsokCoiriaDQixCRVQG3xvW_RLyewNtu__Q9u77LqB7GnzLO8oPujlUtWL3VhQuNo3AaghmZKm15a4ZCduOMtUHofFeI5wbQ5Bw4ts4fu7n26bmW7TSh57QB5cJz5QwKGYcmut5kMakFD1b2ClFZibqNn8xFAoP-eeyuPUTdAeCSh8uditSDdFTVfXprNDjLRLcSV_tX2_5kL6G76Kz3N26CpXtVFGQJ1QYIaMwL3IH_W9jGvRJb93flEuf83oMVE8lFIosXETqjpGxRSl2o17QHU67QQ4le6rroGJ8oFXIG1wNE6PzQ"
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": "User signed in successfully"
      }
    }
  }
""";

var _responseRefreshMock = """
  {
    "getRefreshToken": {
      "data": {
        "accessToken": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJiakF4OEp0NXVvUXJHaHpvR2dybVU1NXRWSXRNNFZtY3F4UTZXZjZLdmJFIn0.eyJleHAiOjE2Mjk5NzAyNDgsImlhdCI6MTYyOTk2OTE2OCwianRpIjoiYWRiM2Q3MmEtMmJjNi00ZjVkLThhYmEtN2IzZDBiNWQxMDNkIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay1pbnRlcm5hbC5ucC5hZWxsYS50ZWNoL2F1dGgvcmVhbG1zL09UQS1kZXYiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMjVkNWM1YmUtOWM0OC00YWJiLTliMzctYTcwNmFhYTlkOWZhIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoib3RhLXVzZXIiLCJzZXNzaW9uX3N0YXRlIjoiY2U3Yzg4ZDEtZTEzYy00NzlkLTg0NTYtZDY0ZGM1ZTIzMjFhIiwiYWNyIjoiMSIsInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJvcGVuaWQgZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicHJlZmVycmVkX3VzZXJuYW1lIjoib3RhZGV2dXNlciJ9.bZV3lS4arxI3hENb3i1sJF0gALr7YWRL6h01RYng2A2NuQtGaotjaJAAkINWB4RbOlyweCGhxRpIKUqZWp4GdfSQNyYM73te50BJU0d2-FMXq0X4WolZnrqjjW9g_ufjNmBzTANiVDF5CNcRJ9Ulvwl0blU3F2x3-qRN39Jgcf2BkyG-VOEIG9dRvVJ9yt1wugFwqX4uUSKoFwZh6V0C1oEKWxTATvobe2_OMtni6k44WXGZIYFyOfb1q1iPU8r8W9js9aN3QL6wsYnkb5_C2n1iFlm6sD2-NKx05nP2fgQe49jdy_ULjqgskeOpkL61oY7EJid-lPVdIO31m34nXg",
        "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI2MzhmNTU2ZS1hOTAyLTQyMTgtOGNhMi1mYjk2NWI3OWYyYzQifQ.eyJleHAiOjE2Mjk5NzA5NjgsImlhdCI6MTYyOTk2OTE2OCwianRpIjoiNWIzYTkzMjQtNjg5My00OWIyLWFjYTMtMDY1MTU3MzY4ZGZiIiwiaXNzIjoiaHR0cHM6Ly9rZXljbG9hay1pbnRlcm5hbC5ucC5hZWxsYS50ZWNoL2F1dGgvcmVhbG1zL09UQS1kZXYiLCJhdWQiOiJodHRwczovL2tleWNsb2FrLWludGVybmFsLm5wLmFlbGxhLnRlY2gvYXV0aC9yZWFsbXMvT1RBLWRldiIsInN1YiI6IjI1ZDVjNWJlLTljNDgtNGFiYi05YjM3LWE3MDZhYWE5ZDlmYSIsInR5cCI6IlJlZnJlc2giLCJhenAiOiJvdGEtdXNlciIsInNlc3Npb25fc3RhdGUiOiJjZTdjODhkMS1lMTNjLTQ3OWQtODQ1Ni1kNjRkYzVlMjMyMWEiLCJzY29wZSI6Im9wZW5pZCBlbWFpbCBwcm9maWxlIn0.IgwKbFaoBnzaxO9GNoquhArGJPBCaSqbNrjfdbefTLw",
        "expiresIn": 1080,
        "refreshExpiresIn": 1800,
        "scope": "openid email profile",
        "idToken": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJiakF4OEp0NXVvUXJHaHpvR2dybVU1NXRWSXRNNFZtY3F4UTZXZjZLdmJFIn0.eyJleHAiOjE2Mjk5NzAyNDgsImlhdCI6MTYyOTk2OTE2OCwiYXV0aF90aW1lIjowLCJqdGkiOiJjNzBmZmQ0My05NGZjLTRjYWEtYjJmNC1hNjhlMjgyNTEyNWMiLCJpc3MiOiJodHRwczovL2tleWNsb2FrLWludGVybmFsLm5wLmFlbGxhLnRlY2gvYXV0aC9yZWFsbXMvT1RBLWRldiIsImF1ZCI6Im90YS11c2VyIiwic3ViIjoiMjVkNWM1YmUtOWM0OC00YWJiLTliMzctYTcwNmFhYTlkOWZhIiwidHlwIjoiSUQiLCJhenAiOiJvdGEtdXNlciIsInNlc3Npb25fc3RhdGUiOiJjZTdjODhkMS1lMTNjLTQ3OWQtODQ1Ni1kNjRkYzVlMjMyMWEiLCJhY3IiOiIxIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJvdGFkZXZ1c2VyIn0.mY6BVcytlmZk0814KFxMZoBYFNV6HpYWOcZsokCoiriaDQixCRVQG3xvW_RLyewNtu__Q9u77LqB7GnzLO8oPujlUtWL3VhQuNo3AaghmZKm15a4ZCduOMtUHofFeI5wbQ5Bw4ts4fu7n26bmW7TSh57QB5cJz5QwKGYcmut5kMakFD1b2ClFZibqNn8xFAoP-eeyuPUTdAeCSh8uditSDdFTVfXprNDjLRLcSV_tX2_5kL6G76Kz3N26CpXtVFGQJ1QYIaMwL3IH_W9jGvRJb93flEuf83oMVE8lFIosXETqjpGxRSl2o17QHU67QQ4le6rroGJ8oFXIG1wNE6PzQ"
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": "User signed in successfully"
      }
    }
  }
""";

var _responseMockLogout = """
   {
  		"getLogoutDetails": {
  			"status": {
  				"description": null,
  				"header": "Success",
  				"code": "1000"
  			}
  		}
  }
""";
