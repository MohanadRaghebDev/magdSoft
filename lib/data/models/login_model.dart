class LoginModel {
  int? status;
  List<Account>? account;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['account'] != null) {
      account = <Account>[];
      json['account'].forEach((v) {
        account!.add(Account.fromJson(v));
      });
    }
  }
}

class Account {
  int? id;
  String? name;
  String? email;
  dynamic password;
  dynamic phone;

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
  }
}
