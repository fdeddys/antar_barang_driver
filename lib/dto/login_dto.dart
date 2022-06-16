class LoginDto {
    final String kode;
    final String password;

    LoginDto(this.kode, this.password);

    LoginDto.fromJson(Map jsonMap)
        : kode = jsonMap['kode'],
            password = jsonMap['password'];

    Map toJson() => {
            'kode': kode,
            'password': password,
        };
}


class LoginResultDto {
    // final bool isSuccess;
    final String token;
    final String errCode;
    final String errDesc;

    LoginResultDto( this.token, this.errCode, this.errDesc);

    LoginResultDto.fromJson(Map jsonMap)
        : token = jsonMap['token'],
            errCode = jsonMap['errCode'],
            errDesc = jsonMap['errDesc'];

    Map toJson() => {
            'token': token,
            'errCode': errCode,
            'errDesc': errDesc,
        };
}
