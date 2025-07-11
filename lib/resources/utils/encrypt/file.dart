import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static const _base64Key = 'B34nhbgRILjQH7hI2Lie0sYzjh6v9aV1'; // 32-byte base64 key
  static const _base64IV = 'wGiHplamyXlVB11UXWol8g==';         // 16-byte base64 IV
  static String encryptDataFromJsonString(String jsonString) {
    final key = encrypt.Key.fromBase64(_base64Key);
    final iv = encrypt.IV.fromBase64(_base64IV);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
    );
    final encrypted = encrypter.encrypt(jsonString, iv: iv);
    return encrypted.base64;
  }
  static String decryptData(String base64Encrypted) {
    final key = encrypt.Key.fromBase64(_base64Key);
    final iv = encrypt.IV.fromBase64(_base64IV);
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
    );
    return encrypter.decrypt64(base64Encrypted, iv: iv); // decrypt the base64-encoded string
  }
}