import 'dart:developer';
import 'dart:io';

import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

// Endpoints to hit
const GET_QUIZZES_URL =
    "https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/datastore_fetch_quizzes?username=";
const POST_QUIZZES_URL =
    "https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/quiz";
const ACCOUNT_URL =
    "https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/account?username=";
const GET_VISION_URL =
    "https://studyq-backend-6cmwkb4jva-ue.a.run.app/studyQ/vision-api?image-gcs=gs://studyq_images/";

// gcp stuff
const CLOUD_STORAGE_BUCKET = "studyq_images";
const CLOUD_PROJECT_ID = "studyq-266906";

class NetworkService {
  static Future<String> getQuizItemsForAccount(String userName) async {
    var url = GET_QUIZZES_URL + userName;
    log(url);
    var response = await http.get(url);
    log('Response status: ${response.statusCode}');

    return response.body;
  }

  static newQuizItem(String userName, String quiz) async {
    var url = POST_QUIZZES_URL + "?username=$userName";
    log(url);
    var response = await http.post(url, body: {"quiz": quiz});
    log('Response status: ${response.statusCode}');

    return;
  }

  static putAccount(String userName) async {
    var url = ACCOUNT_URL + userName;
    log(url);
    var response = await http.post(url);
    log('Response status: ${response.statusCode}');

    return response.body;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<String> uploadCloudFile(File file) async {
    // Read the service account credentials from the file.
    final path = await _localPath;
    var jsonCredentials = {
      "type": "service_account",
      "project_id": "studyq-266906",
      "private_key_id": "88a65ce1b08deb917db5e3f92e9394da40157046",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCjNNe0AU6aYSIz\nk81/coTlt3vU1ZPCGnOHxWriv6OjiRB7UkCvxnUkjZKpFOkHYye3fIXfSUaLOomN\nAbZIHko7LCcAWJ95ItBrW1PgQIiB7ZsHtdJK4i/z25Yok3nrQXd4WPQ8VheY6R1P\nL53Ih1vHpai0SNGQYfghLYj5aq8DJh/8kRmgOULlelF4c8mh7vzVfO+nIyl5Vmoc\n0KZY25VgMOD0jeTjMcAJa1UK/69pgZo8FJk8vl8mFgj8iB/g4F2N0Rz8Ti9S4+S1\neIsaR8ArGqMCKkstUZ1K9KOZRoKoQ6OxnrZQKnynuYNOha9qDwPVJTPIbmRWMwGu\nh4ZFTyCLAgMBAAECgf95fTpp7znPoLH/odv5UAp7oIkvu0RtMKnxtFBLem2ieW32\nGrNy0B3r7TLhiFFmrmBzYJxpGoCkihljCHRKf1LTuXkswENLWB8R7a5Xnn8QWwsV\nEBlhC1QNO6Rg5WcpFps2R84yCtMws6x7koeU6S3pAT1pf1PV6vWfmtbs9bkelTsW\n9+FMi7hruW+7v69Ad0xWsZcSui7GE1YdsW3vN9BNTDcIp+DugfHnQdauPV0NzbWz\nyjBEnY/LqO3bWo4C2xyOTGwRufa82KIONkCCqsFgU4QXnpw/i5vBaSD1P14vvw/I\njWrOSxrn3KLjdAlI26NoNJZoH0olHizxwoOro1ECgYEA5VyU7RyEakBR8rBHgx3v\n7pE0d6Aty452XDWDVuow+1tWf3s7KBRM4cHKx3p7OMUKYCx/uGV8c6mTvTkkzYDX\n0ce/hfcsew96BvmEjAgdXG/HnUz3aQDEAaLjGbqvuXh+q3zK7tWw5gw/5gt8AB/J\nsZfmiHbPT0h42IULrScMAPsCgYEAtilSl7bDpFf9FPQqXt/b7UIweTxmoHUS3VR6\nS/KFU2u9QHlzuQTTexSIIxMfEeYcX++QueUto9NZyGedVuZx4T2R0ivYRHRMZXTI\nuuNBuHCRizaPwEZnvRrme4mhf3rYHWwcL4K+qs3C3FUNjBaDqtBUNw6TFiColHUz\nrOz66bECgYBmPbTtVY75Rh7Bji7ylb/EmtnGkZKYcLL2O6yGa/LVuUt/nFEsdpAm\n+poH/eM71Sng4TU135dwf6Ep8nUjXlHWY7JOZ3ZejPGadlPNkDh2YiWbSxnmpr64\n9AFEEOIQTVQ54XEcsgkfI0rAo1HtRD5Gei37muqiru2fpv8jeopxTQKBgFeh+YHT\nAruFONNjwx5xQzQYq4knbZezuqePhGYU/d7r7deelfVkRPjpH7T/9ep+cRgV/+Hu\nRs6RVpf6gM7VfeOF4yjgvuHvsPD+BbMisPMx9FKspOsy86Ud09OKmo7hYiaFY+nX\nVDKHWj71C9dg3WbHYjw6Xrg+bds9puaB+xOBAoGBAOQuHaPJcj9Zj16hIy9WRFW1\np+amwvHQKkynT5unIfENGD1jsfRVAHq1VvNK8UG3OQSqnkDQk8Jj8MXauntY3p7Y\nmqxtwsvnqwJZdS9yhxqYU7suTQpZqlj4strOmmNJmSJTg0+xjBZBusZp4a0iN8f0\nkkbhuBRciJ3enuyjOUjg\n-----END PRIVATE KEY-----\n",
      "client_email": "studyq-datastore@studyq-266906.iam.gserviceaccount.com",
      "client_id": "111853163988247190770",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/studyq-datastore%40studyq-266906.iam.gserviceaccount.com"
    };
    var credentials =
        new auth.ServiceAccountCredentials.fromJson(jsonCredentials);

    // Get an HTTP authenticated client using the service account credentials.
    List<String> scopes = []..addAll(Storage.SCOPES);
    var client = await auth.clientViaServiceAccount(credentials, scopes);

    // Instantiate objects to accesss Cloud Storage
    var storage = new Storage(client, CLOUD_PROJECT_ID);
    var bucket = storage.bucket(CLOUD_STORAGE_BUCKET);
    var imageID = Uuid().v4();
    await file.openRead().pipe(bucket.write(imageID));

    //  call backend to inform them of changes
    var url = GET_VISION_URL + imageID;
    log(url);
    var response = await http.get(url);
    log('Response status: ${response.statusCode}');

    return response.body;
  }
}
