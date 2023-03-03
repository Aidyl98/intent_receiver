class SendData {
  String? package;
  String? JSON;

  SendData({
    this.package,
    this.JSON,
  });

  SendData.fromJson(Map<String, dynamic> json)
      : package = json['package'],
        JSON = json['JSON'];
}
