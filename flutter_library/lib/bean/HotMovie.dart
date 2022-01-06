class HotMovie {
  int id;
  bool haspromotionTag;
  String img;
  String version;
  String nm;
  bool preShow;
  var sc;
  bool globalReleased;
  int wish;
  String star;
  String rt;
  String showInfo;
  int showst;
  int wishst;
  String comingTitle;

  HotMovie(
      { this.id,
        this.haspromotionTag,
        this.img,
        this.version,
        this.nm,
        this.preShow,
        this.sc,
        this.globalReleased,
        this.wish,
        this.star,
        this.rt,
        this.showInfo,
        this.showst,
        this.wishst,
        this.comingTitle});

  HotMovie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    haspromotionTag = json['haspromotionTag'];
    img = json['img'];
    version = json['version'];
    nm = json['nm'];
    preShow = json['preShow'];
    sc = json['sc'];
    globalReleased = json['globalReleased'];
    wish = json['wish'];
    star = json['star'];
    rt = json['rt'];
    showInfo = json['showInfo'];
    showst = json['showst'];
    wishst = json['wishst'];
    comingTitle = json['comingTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['haspromotionTag'] = this.haspromotionTag;
    data['img'] = this.img;
    data['version'] = this.version;
    data['nm'] = this.nm;
    data['preShow'] = this.preShow;
    data['sc'] = this.sc;
    data['globalReleased'] = this.globalReleased;
    data['wish'] = this.wish;
    data['star'] = this.star;
    data['rt'] = this.rt;
    data['showInfo'] = this.showInfo;
    data['showst'] = this.showst;
    data['wishst'] = this.wishst;
    data['comingTitle'] = this.comingTitle;
    return data;
  }
}
