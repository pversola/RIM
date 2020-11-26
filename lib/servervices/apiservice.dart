import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pcpc_shredding/models/company.dart';

//const baseUrl = "https://jsonplaceholder.typicode.com";
const baseUrl = "http://localhost:20000";
   String _mainBankCode = "";

class GETAPI {
  //Get Shreding All
  /*  static Future getShreding() async { */
  //  var url = baseUrl + "/users";
  /*  var url = baseUrl + "/api/v1/StkShredding";
    return await http.get(
      url,
    ); */

  /*  } */

  static Future getCompany() async {
    var url = baseUrl + "/api/v1/MstCompanyProfile";
    return await http.get(
      url,
    );
  }

  static Future getShreding() async {
    var url = baseUrl + "/api/v1/StkShredding/getshreddingall";
    print("Bank Code: " + _mainBankCode);
    var body = jsonEncode({
      'bankCode': _mainBankCode,
    });
    return await http
        .post(url, headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
           print("Response body: ${response.contentLength}");
      return response;
      /* print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request); */
    });
  }



  static Future getRecodebill(String _url,String _body ) async {
   var url = _url;   
    var body = jsonEncode({
      'projectid': _body,
    });
 
    return await http
        .post(url, headers: {"Content-Type": "application/json"},body: body )
        .then((http.Response response) {
           print("Response body: ${response.contentLength}");
      return response;
      /* print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request); */
    });
  }


  static Future getShredingDetail(String jobno) async {
    var url = baseUrl + "/api/v1/StkShredding/stkshreddingdetail";
    var body = jsonEncode({'bankCode': _mainBankCode, 'shreddingJob': jobno});
    return await http
        .post(url, headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      return response;
    });

    /*  var url = baseUrl + "/api/v1/StkShredding/stkshreddingdetail?id=" + jobno;
    return await http.get(
      url,
    ); */
  }

  static Future getBoxDetail(String boxno) async {
    var url = baseUrl + "/api/v1/StkChqItem/getchqbyboxsetno";
    var body = jsonEncode({'bankCode': _mainBankCode, 'boxSetNo': boxno});
    return await http
        .post(url, headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      return response;
    });
    /*  var url = baseUrl + "/api/v1/StkChqItem/getchqbyboxsetno?boxSetNo=" + boxno;
    return await http.get(
      url,
    ); */
  }

// Get Shreding by ID
  static Future getShredingId() async {
    var url = baseUrl + "/api/v1/StkShredding/CSP20200817-1";
    return await http.get(
      url,
    );
  }

  static Future getShredingdetails() async {
    var url = baseUrl + "/api/v1/StkShredding";
    return await http.get(
      url,
    );
  }
}

class POSTAPI {
  static Future postShreding(String name) async {
    var url = baseUrl + "/api/v1/StkShredding/createshredding";
    var body = jsonEncode({
      'bankCode': _mainBankCode,
      'shreddingJob': name,
      'createUser': 'KOB',
      'createDetail': 'TEST TEST',
    });
    return await http
        .post(url, headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
    });
  }

  static Future postShredingDetails(String jobno, String boxno) async {
    var url = baseUrl + "/api/v1/StkShredding/createshreddingdetail";
    var body = jsonEncode({
      'bankCode': _mainBankCode,
      'shreddingJob': jobno,
      'boxSetNo': boxno,
    });
    return await http
        .post(url, headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      return response;
      /*  print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request) */
    });
  }
}

class DELETEAPI {
  static Future deleteShredingDetails(String jobno, String boxno) async {
    var url = baseUrl + "/api/v1/StkShredding/delshreddingdetail";
    var body = jsonEncode({
      'bankCode': _mainBankCode,
      'shreddingJob': jobno,
      'boxSetNo': boxno,
    });
    return await http
        .post(url,
            headers: {
              "Content-Type": "application/json",
            },
            body: body)
        .then((http.Response response) {
      return response.contentLength;
    });
  }

  static Future deleteShreding(String jobno) async {
    var url = baseUrl + "/api/v1/StkShredding/delshredding";
    var body = jsonEncode({
      'bankCode': _mainBankCode,
      'shreddingJob': jobno,
    });
    return await http
        .post(url,
            headers: {
              "Content-Type": "application/json",
            },
            body: body)
        .then((http.Response response) {
      return response.contentLength;
    });
  }
}

class PATCHAPI {
  static Future patchShreding(
      String name, bool statusShredding, bool statusExport) {
    var url = baseUrl + "/api/v1/StkShredding/updateshredding";
    var body = jsonEncode({
      'bankCode': _mainBankCode,
      "shreddingJob": name,
      "statusShredding": statusShredding,
      "statusExport": statusExport, 
    });
    return http
        .post(url, headers: {"Content-Type": "application/json"}, body: body)
        .then((http.Response response) {
      return response.contentLength;
    });
  }
}

class ServerStatus {
  static int newestBinary;
  static bool appfirstload = true;
  static List<CompanyModel> companylist = List();
  static String bankName = "";
  static String bankCode = "";
  static String bankNameTh="";
  static String bankAdd="";
  static String imageUrl = "http://localhost:7777/assets/assets/images/";
}

class SetBank {
   static setBank(String bankcode) {
      _mainBankCode = bankcode;
      
      ServerStatus.bankCode=_mainBankCode;
  }
}

/* class IdRepository {
  final Storage _localStorage = window.localStorage;

  Future save(String id) async {
    _localStorage['selected_id'] = id;
  }

  Future<String> getId() async => _localStorage['selected_id'];

  Future invalidate() async {
    _localStorage.remove('selected_id');
  }
}
 */
