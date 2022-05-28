class Driver {
    
    final int id;
    final String kode;
    final String photo;
    final String alamat;
    final String hp;
    final String nama;
    final int status;
    final String lastUpdateStr;
    final String lastUpdateBy;

    Driver(this.id, this.kode, this.photo,  this.alamat,this.hp, this.nama, this.status, this.lastUpdateStr, this.lastUpdateBy);
   
    Driver.fromJson(Map jsonMap)
        : id = jsonMap['id'], 
        kode = jsonMap['kode'],
        photo = jsonMap['photo'],
        alamat = jsonMap['alamat'],
        hp = jsonMap['hp'],
        nama = jsonMap['nama'],
        status = jsonMap['status'],
        lastUpdateStr = jsonMap['lastUpdateStr'],
        lastUpdateBy = jsonMap['lastUpdateBy']
        ;

    Map toJson() => {
        'id': id,
        'kode': kode,
        'photo': photo,
        'alamat': alamat,
        'hp' : hp,
        'nama': nama,
        'status':status,
        'lastUpdateStr' : lastUpdateStr,
        'lastUpdateBy':lastUpdateBy
    };


}