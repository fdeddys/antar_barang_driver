
class ChangePassDto {
    final int driverId;
    final String password;
    final String oldPassword;

    ChangePassDto(this.driverId, this.password, this.oldPassword);

    ChangePassDto.fromJson(Map jsonMap): 
        driverId = jsonMap['driverId'],
        password = jsonMap['password'],
        oldPassword = jsonMap['oldPassword'];

    Map toJson() => {
            'driverId': driverId,
            'password': password,
            'oldPassword': oldPassword,
        };
}


class ChangePassResultDto {
    final String contents;
    final String errCode;
    final String errDesc;

    ChangePassResultDto( this.contents, this.errCode, this.errDesc);

    ChangePassResultDto.fromJson(Map jsonMap)
        : contents = jsonMap['contents'],
            errCode = jsonMap['errCode'],
            errDesc = jsonMap['errDesc'];

    Map toJson() => {
            'contents': contents,
            'errCode': errCode,
            'errDesc': errDesc,
        };
}
