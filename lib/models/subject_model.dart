import 'dart:convert';
 
import 'package:http/http.dart' as http;
import 'package:pcpc_shredding/servervices/const.dart';

/// Course
class SubjectModel {
  final String objid;
  final String owner;
  final String name;
  final String detail;
  final String subjecttype;
  final int credit;
  final String imageurl;
  SubjectModel._({
    this.objid,
    this.owner,
    this.name,
    this.detail,
    this.subjecttype,
    this.credit,
    this.imageurl,
  });
  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return new SubjectModel._(
      objid: json['_id'],
      owner: json['owner'],
      name: json['name'],
      detail: json['detail'],
      imageurl: json['image_url'],
      subjecttype: json['subjecttype'],
      credit: json['credit'],
    );
  }
}

class SubjectViewModel {
  static List<SubjectModel> subjects;
  static fetchData(String sublink, String jsonpars) async {
    var url = Constants.ip + sublink;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        subjects = new List<SubjectModel>();
        Map parsedJson = json.decode(response.body);
        var categoryJson = parsedJson[jsonpars] as List;
        for (int i = 0; i < categoryJson.length; i++) {
          subjects.add(new SubjectModel.fromJson(categoryJson[i]));
        }
      } catch (e) {
        print(e);
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }
}

class UsersModel {
  final String objid;
  final String phone;
  final String name;
  final String detail;
  final String imageurl;
  UsersModel._({
    this.objid,
    this.phone,
    this.name,
    this.detail,
    this.imageurl,
  });
  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return new UsersModel._(
      objid: json['_id'],
      phone: json['phone'],
      name: json['name'],
      detail: json['detail'],
      imageurl: json['userImage'],
    );
  }
}

class UsersViewModel {
  static List<UsersModel> users;
  static fetchData(String sublink, String jsonpars) async {
    var url = Constants.ip + sublink;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        users = new List<UsersModel>();
        Map parsedJson = json.decode(response.body);
        var categoryJson = parsedJson[jsonpars] as List;
        for (int i = 0; i < categoryJson.length; i++) {
          users.add(new UsersModel.fromJson(categoryJson[i]));
        }
      } catch (e) {
        print(e);
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }
}

class ChecklistModel {
 /*  final String objid;
  final String classroomid;
  final String detail;
  final String projectid;
  final bool notify;
  final bool actived;
  final String objdate; */
   final   objid;
  final  classroomid;
  final   detail;
  final   projectid;
  final   notify;
  final   actived;
  final   objdate;
  ChecklistModel._(
      {this.objid,
      this.classroomid,
      this.actived,
      this.projectid,
      this.detail,
      this.notify,
      this.objdate});
  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return new ChecklistModel._(
      objid: json['_id'],
      projectid:json['projectid'],
      classroomid: json['classroomid'],
      actived: json['actived'],
      detail: json['detail'],
      notify: json['notify'],
      objdate: json['createdAt'],
    );
  }
}

/* "_id": "5ef98b24942994b35022efcb",
            "projectid": "5ec49f6b87da1a355c72d705",
            "levelid": "5ef96dd5942994b35022efb7",
            "name": "ห้อง Deluxe",
            "detail": "ทดสอบสร้างห้อง",
            "noti": 0,
            "status": true,
            "statusclose": false,
            "image_url": "uploads\\2020-06-29T06-33-08.573Zscaled_image_picker7464839207275409881.jpg", */

class RoomModel {
  final String id;
  final String projectid;
  final String levelid;
  final String name;
  final String detail;
  final int noti;
  final bool status;
  final bool statusclose;
  final String imageurl;
  final int water;
  RoomModel._({
    this.id,
    this.projectid,
    this.levelid,
    this.name,
    this.detail,
    this.noti,
    this.status,
    this.statusclose,
    this.imageurl,
    this.water,
  });
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return new RoomModel._(
      id: json['_id'],
      projectid: json['levelid'],
      levelid: json['levelid'],
      name: json['name'],
      detail: json['detail'],
      noti: json['noti'],
      status: json['status'],
      statusclose: json['stastatusclosetus'],
      imageurl: json['image_url'],
       water: json['water'],
      
    );
  }
}
