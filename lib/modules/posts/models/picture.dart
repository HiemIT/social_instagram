class Picture {
  String? id;
  String? url;
  int? orgWidth;
  int? orgHeight;
  String? orgUrl;
  String? cloudName;
  String? dominantColor;
  int? fileSize;

  Picture(
      {this.id,
      this.url,
      this.orgWidth,
      this.orgHeight,
      this.orgUrl,
      this.cloudName,
      this.dominantColor,
      this.fileSize});

  Picture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    orgWidth = json['org_width'];
    orgHeight = json['org_height'];
    orgUrl = json['org_url'];
    cloudName = json['cloud_name'];
    dominantColor = json['dominant_color'];
    fileSize = json['file_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['org_width'] = this.orgWidth;
    data['org_height'] = this.orgHeight;
    data['org_url'] = this.orgUrl;
    data['cloud_name'] = this.cloudName;
    data['dominant_color'] = this.dominantColor;
    data['file_size'] = this.fileSize;
    return data;
  }
}
