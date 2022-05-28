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
    final bool isSuccess;
    final String content;

    LoginResultDto(this.isSuccess, this.content);

    LoginResultDto.fromJson(Map jsonMap)
        : isSuccess = jsonMap['isSuccess'],
            content = jsonMap['content'];

    Map toJson() => {
            'isSuccess': isSuccess,
            'content': content,
        };
}
