
class PaynahUser {
    final String? lName;
    final String? fName;
    final String? uuid;
    final String? email;

    PaynahUser({
        this.lName,
        this.fName,
        this.uuid,
        this.email,
    });

    factory PaynahUser.fromJson(Map<String, dynamic>? json) => PaynahUser(
        lName: json?["l_name"],
        fName: json?["f_name"],
        uuid: json?["uuid"],
        email: json?["email"],
    );

    Map<String, dynamic> toJson() => {
        "l_name": lName,
        "f_name": fName,
        "uuid": uuid,
        "email": email,
    };
}
