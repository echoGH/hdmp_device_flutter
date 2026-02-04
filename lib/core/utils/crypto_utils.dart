import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

/// AES加密工具（完全沿用Android项目的加密逻辑）
class CryptoUtils {
  CryptoUtils._();

  /// AES密钥（与Android项目一致）
  static const String _aesKey = 'XXQp47AnIRcnvHeFaUUBlw==';

  /// AES加密（ECB模式，PKCS5Padding）
  /// 对应Android的: CryptoUtils.encryptSymmetrically
  static String encryptAES(String plainText) {
    try {
      // 解码Base64密钥
      final keyBytes = base64.decode(_aesKey);
      final key = encrypt.Key(keyBytes);

      // ECB模式加密
      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          key,
          mode: encrypt.AESMode.ecb,
          padding: 'PKCS7', // PKCS7等同于PKCS5
        ),
      );

      // 加密并返回Base64字符串
      final encrypted = encrypter.encrypt(plainText);
      return encrypted.base64;
    } catch (e) {
      throw Exception('AES加密失败: $e');
    }
  }

  /// AES解密（ECB模式，PKCS5Padding）
  static String decryptAES(String cipherText) {
    try {
      // 解码Base64密钥
      final keyBytes = base64.decode(_aesKey);
      final key = encrypt.Key(keyBytes);

      // ECB模式解密
      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          key,
          mode: encrypt.AESMode.ecb,
          padding: 'PKCS7',
        ),
      );

      // 解密
      final decrypted = encrypter.decrypt64(cipherText);
      return decrypted;
    } catch (e) {
      throw Exception('AES解密失败: $e');
    }
  }
}
