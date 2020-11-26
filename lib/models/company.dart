class CompanyModel {
  String companyCd;
  String companyAbbr;
  String companyNameTh;
  String companyNameEn;
  String companyAddress;
  String companyLogo;
  CompanyModel() {
    this.companyCd = companyCd;
    this.companyAbbr = companyAbbr;
    this.companyNameTh = companyNameTh;
    this.companyNameEn = companyNameEn;
    this.companyAddress = companyAddress;
    this.companyLogo = companyLogo;
  }

  CompanyModel.fromJson(Map json)
      : companyCd = json['companyCd'],
        companyAbbr = json['companyAbbr'],
        companyNameTh = json['companyNameTh'],
        companyNameEn = json['companyNameEn'],
        companyAddress = json['companyAddress'],
        companyLogo = json['companyLogo'];

  Map toJson() {
    return {
      'companyCd': companyCd,
      'companyAbbr': companyAbbr,
      'companyNameTh': companyNameTh,
      'companyNameEn': companyNameEn,
      'companyAddress': companyAddress,
      'companyLogo': companyLogo,
    };
  }
}
