class CheckInfoModel {
  String curBoxSetNo;
  String itmId;
  String companyCd;

  /*
     "curBoxSetNo": "TBA2012112602",   
      "itmId": "2012101106502539000049",
      "companyCd": "011",
      "clearingDate": "2012-10-11T00:00:00",
      "itmTypeCd": "OC-IBK",
      "seqNo": 3854,
      "batchNo": 1,
      "uid": "2012101106502539000049",
      "realCodeline": "0565951060080086099752",
      "sendingBankCd": "011",
      "sendingBranchCd": "0001",
      "payingBankCd": "006",
      "payingBranchCd": "0008",
      "segmentNo": "N06520121123_04",
      "segmentOrderNo": 4248,     
      "curBoxItmOrderNo": 539, 
      "statusFlag": "I",      
      "purgeFlag": "0",      
      "creationDtm": "2012-10-18T08:51:25",
      "creationBy": "daoreung",
      "lastUpdateDtm": "2012-11-26T09:12:09",
      "lastUpdateBy": "daoreung",
      "lastProgCd": "Stk_ConfirmCheckIn",
      "clearingDateInt": 20121011, */

  CheckInfoModel(int id, String name, String email) {
    this.curBoxSetNo = curBoxSetNo;
    this.itmId = itmId;
    this.companyCd = companyCd;
  }

  CheckInfoModel.fromJson(Map json)
      : curBoxSetNo = json['curBoxSetNo'],
        itmId = json['itmId'],
        companyCd = json['companyCd'];

  Map toJson() {
    return {
      'curBoxSetNo': curBoxSetNo,
      'itmId': itmId,
      'companyCd': companyCd,
    };
  }
}
