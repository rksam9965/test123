class GetNewData {
  int? userId;
  int? id;
  String? title;
  String? body;

  GetNewData({this.userId, this.id, this.title, this.body});

  GetNewData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}


class GetNewDataLister {
  List<GetNewData>? listDatum;

  GetNewDataLister({ this.listDatum});

  factory GetNewDataLister.fromJson(List<dynamic> json) {
    return GetNewDataLister(
      listDatum: json.map((e) => GetNewData.fromJson(e)).toList(),
    );
  }
}