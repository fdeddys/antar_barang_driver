import 'dart:core';

class Transaksi {
    final int id;
    final String transaksiDateStr;
    final String tanggalRequestAntarStr;
    final String jamRequestAntar;
    final String namaProduct;
    final String coordinateTujuan;
    final String keterangan;
    final String photoAmbil;
    final String tanggalAmbilStr;
    final String photoSampai;
    final String tanggalSampaiStr;
    final int idSeller;
    final String sellerName;
    final String sellerAddress;
    final String sellerHp;
    final int idDriver;
    final String  driverName;
    final int idCustomer;
    final String customerName;
    final String customerAddress;
    final String customerHp;
    final int status;
    final String statusName;
    final String lastUpdateBy;
    final String lastUpdateStr;


    Transaksi(
        this.id, 
        this.transaksiDateStr, 
        this.tanggalRequestAntarStr, 
        this.jamRequestAntar, 
        this.namaProduct, 
        this.coordinateTujuan, 
        this.keterangan, 
        this.photoAmbil, 
        this.tanggalAmbilStr, 
        this.photoSampai, 
        this.tanggalSampaiStr, 
        this.idSeller, 
        this.sellerName,
        this.sellerAddress,
        this.sellerHp, 
        this.idDriver, 
        this.driverName, 
        this.idCustomer, 
        this.customerName, 
        this.customerAddress,
        this.customerHp,
        this.status, 
        this.statusName,
        this.lastUpdateBy, 
        this.lastUpdateStr);
    
    Transaksi.fromJson(Map jsonMap)
        : id = jsonMap['id'], 
        transaksiDateStr = jsonMap['transaksiDateStr'],
        tanggalRequestAntarStr = jsonMap['tanggalRequestAntarStr'],
        jamRequestAntar = jsonMap['jamRequestAntar'],
        namaProduct = jsonMap['namaProduct'],
        coordinateTujuan = jsonMap['coordinateTujuan'],
        keterangan = jsonMap['keterangan'],
        photoAmbil = jsonMap['photoAmbil'],
        tanggalAmbilStr = jsonMap['tanggalAmbilStr'],
        photoSampai = jsonMap['photoSampai'],
        tanggalSampaiStr = jsonMap['tanggalSampaiStr'],
        idSeller = jsonMap['idSeller'],
        sellerName = jsonMap['sellerName'],
        sellerAddress = jsonMap['sellerAddress'],
        sellerHp = jsonMap['sellerHp'],
        idDriver = jsonMap['idDriver'],
        driverName = jsonMap['driverName'],
        idCustomer = jsonMap['idCustomer'],
        customerName = jsonMap['customerName'],
        customerAddress = jsonMap['customerAddress'],
        customerHp = jsonMap['customerHp'],
        status = jsonMap['status'],
        statusName = jsonMap['statusName'],
        lastUpdateStr = jsonMap['lastUpdateStr'],
        lastUpdateBy = jsonMap['lastUpdateBy'];
    
    Map toJson() => {
        'id': id,
        'transaksiDateStr': transaksiDateStr,
        'tanggalRequestAntarStr': tanggalRequestAntarStr,
        'jamRequestAntar': jamRequestAntar,
        'namaProduct' : namaProduct,
        'coordinateTujuan': coordinateTujuan,
        'keterangan': keterangan,
        'photoAmbil': photoAmbil,
        'tanggalAmbilStr': tanggalAmbilStr,
        'photoSampai': photoSampai,
        'tanggalSampaiStr': tanggalSampaiStr,
        'idSellera': idSeller,
        'sellerName': sellerName,
        'sellerAddress': sellerAddress,
        'sellerHp': sellerHp,
        'idDriver': idDriver,
        'driverName': driverName,
        'idCustomer': idCustomer,
        'customerName': customerName,
        'customerAddress': customerAddress,
        'customerHp': customerHp,
        'status':status,
        'statusName':statusName,
        'lastUpdateStr' : lastUpdateStr,
        'lastUpdateBy':lastUpdateBy
    };

}

	

