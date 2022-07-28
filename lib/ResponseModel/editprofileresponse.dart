class editprofileresponse {
  String? _msg;
  EditProfileR? _data;
  bool? _success;

  editprofileresponse({String? msg, EditProfileR? data, bool? success}) {
    this._msg = msg;
    this._data = data;
    this._success = success;
  }

  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;
  EditProfileR? get data => _data;
  set data(EditProfileR? data) => _data = data;
  bool? get success => _success;
  set success(bool? success) => _success = success;

  editprofileresponse.fromJson(Map<String, dynamic> json) {
    _msg = json['msg'];
    _data = json['data'] != null ? new EditProfileR.fromJson(json['data']) : null;
    _success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this._msg;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    data['success'] = this._success;
    return data;
  }
}

class EditProfileR {
  int? _id;
  String? _name;
  String? _image;
  String? _email;
  int? _otp;
  Null _addedBy;
  Null _emailVerifiedAt;
  String? _code;
  String? _phone;
  int? _status;
  int? _role;
  int? _verify;
  String? _deviceToken;
  int? _notification;
  int? _mail;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;
  String? _salonName;

  EditProfileR(
      {int? id,
        String? name,
        String? image,
        String? email,
        int? otp,
        Null addedBy,
        Null emailVerifiedAt,
        String? code,
        String? phone,
        int? status,
        int? role,
        int? verify,
        String? deviceToken,
        int? notification,
        int? mail,
        String? createdAt,
        String? updatedAt,
        String? imagePath,
        String? salonName}) {
    this._id = id;
    this._name = name;
    this._image = image;
    this._email = email;
    this._otp = otp;
    this._addedBy = addedBy;
    this._emailVerifiedAt = emailVerifiedAt;
    this._code = code;
    this._phone = phone;
    this._status = status;
    this._role = role;
    this._verify = verify;
    this._deviceToken = deviceToken;
    this._notification = notification;
    this._mail = mail;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._imagePath = imagePath;
    this._salonName = salonName;
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;
  String? get email => _email;
  set email(String? email) => _email = email;
  int? get otp => _otp;
  set otp(int? otp) => _otp = otp;
  Null get addedBy => _addedBy;
  set addedBy(Null addedBy) => _addedBy = addedBy;
  Null get emailVerifiedAt => _emailVerifiedAt;
  set emailVerifiedAt(Null emailVerifiedAt) =>
      _emailVerifiedAt = emailVerifiedAt;
  String? get code => _code;
  set code(String? code) => _code = code;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  int? get status => _status;
  set status(int? status) => _status = status;
  int? get role => _role;
  set role(int? role) => _role = role;
  int? get verify => _verify;
  set verify(int? verify) => _verify = verify;
  String? get deviceToken => _deviceToken;
  set deviceToken(String? deviceToken) => _deviceToken = deviceToken;
  int? get notification => _notification;
  set notification(int? notification) => _notification = notification;
  int? get mail => _mail;
  set mail(int? mail) => _mail = mail;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get imagePath => _imagePath;
  set imagePath(String? imagePath) => _imagePath = imagePath;
  String? get salonName => _salonName;
  set salonName(String? salonName) => _salonName = salonName;

  EditProfileR.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _email = json['email'];
    _otp = json['otp'];
    _addedBy = json['added_by'];
    _emailVerifiedAt = json['email_verified_at'];
    _code = json['code'];
    _phone = json['phone'];
    _status = json['status'];
    _role = json['role'];
    _verify = json['verify'];
    _deviceToken = json['device_token'];
    _notification = json['notification'];
    _mail = json['mail'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
    _salonName = json['salonName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['image'] = this._image;
    data['email'] = this._email;
    data['otp'] = this._otp;
    data['added_by'] = this._addedBy;
    data['email_verified_at'] = this._emailVerifiedAt;
    data['code'] = this._code;
    data['phone'] = this._phone;
    data['status'] = this._status;
    data['role'] = this._role;
    data['verify'] = this._verify;
    data['device_token'] = this._deviceToken;
    data['notification'] = this._notification;
    data['mail'] = this._mail;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['imagePath'] = this._imagePath;
    data['salonName'] = this._salonName;
    return data;
  }
}