class ShreddingDetailModel {
  String shreddingjob;
  String boxsetno;
  bool statuscheck;
  int totalchq;
  double totalreq;
  double totalvalue;

  ShreddingDetailModel(int id, String name, String email) {
    this.shreddingjob = shreddingjob;
    this.boxsetno = boxsetno;
    this.statuscheck = statuscheck;
    this.totalchq = totalchq;
    this.totalreq = totalreq;
    this.totalvalue = totalvalue;
  }

  ShreddingDetailModel.fromJson(Map json)
      : shreddingjob = json['shreddingJob'],
        boxsetno = json['boxSetNo'],
        statuscheck = json['statusCheck'],
        totalchq = json['totalChq'],
        totalreq = json['totalReq'],
        totalvalue = json['totalValue'];

  Map toJson() {
    return {
      'shreddingjob': shreddingjob,
      'boxsetno': boxsetno,
      'statuscheck': statuscheck,
      'totalchq': totalchq,
      'totalreq': totalreq,
      'totalvalue': totalvalue
    };
  }
}
