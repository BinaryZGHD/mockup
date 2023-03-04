
class Languages {
  String id;
  String code;
  String name;
  String aliasCode;
  String iconFontClass;
  int seqNo;
  bool selected;

  Languages({
    required this.id,
    required this.code,
    required this.name,
    required this.aliasCode,
    required this.iconFontClass,
    required this.seqNo,
    required this.selected
  });

  Languages.fromJson(Map<String, dynamic> json)
      : id = json['id'] ,
        code = json['code'] ,
        name = json['name'] ,
        aliasCode = json['aliasCode'] ,
        iconFontClass = json['iconFontClass'] ,
        seqNo = json['seqNo'] ,
        selected = json['selected'] ;

  Map<String, dynamic> toJson() => {
    'id': id,
    'code': code,
    'name': name,
    'aliasCode': aliasCode,
    'iconFontClass': iconFontClass,
    'seqNo': seqNo,
    'selected': selected,
  };
}