class ShreddingModel {
  String shreddingjob;
  String createdate;
  String createuser;
  bool statusshredding;
  int totalBox;
  int totalChq;

  ShreddingModel(int id, String name, String email) {
    this.shreddingjob = shreddingjob;
    this.createdate = createdate;
    this.createuser = createuser;
    this.statusshredding = statusshredding;
    this.totalBox = totalBox;
    this.totalChq = totalChq;
  }

  ShreddingModel.fromJson(Map json)
      : shreddingjob = json['shreddingJob'],
        createdate = json['createDate'],
        createuser = json['createUser'],
        statusshredding = json['statusShredding'],
        totalBox = json['totalBox'],
        totalChq = json['totalChq'];

  Map toJson() {
    return {
      'shreddingjob': shreddingjob,
      'createdate': createdate,
      'createuser': createuser,
      'statusshredding': statusshredding,
      'totalBox': totalBox,
      'totalChq': totalChq,
    };
  }
}
