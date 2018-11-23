package myyoucloud;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.spec.AlgorithmParameterSpec;
import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

public class JavaDesEncryption {

    private static Cipher encrypt;
    private static Cipher decrypt;
    private static final byte[] initialization_vector = {22, 33, 11, 44, 55, 99, 66, 77};

    //public static void main(String[] args) {
    public void initDes(String filename, String email) {
        String clearFile = filename;
        String encryptedFile = filename;
        String decryptedFile = filename;
        int cnt = 0;
        try {

            //   session.setAttribute("key", secret_key);
            AlgorithmParameterSpec alogrithm_specs = new IvParameterSpec(
                    initialization_vector);
            // KeyStoreYouCloud keyStore = new KeyStoreYouCloud();
            // SecretKey secret_key = keyStore.checkKeyStore();
            String key = "Ankush@02";
            DESKeySpec dks = new DESKeySpec(key.getBytes());
            SecretKeyFactory skf = SecretKeyFactory.getInstance("DES");
            SecretKey secret_key = skf.generateSecret(dks);
            System.out.println("Calc secret key : " + secret_key);
            // set encryption mode ...
            encrypt = Cipher.getInstance("DES/CBC/PKCS5Padding");
            encrypt.init(Cipher.ENCRYPT_MODE, secret_key, alogrithm_specs);

            // set decryption mode
            decrypt = Cipher.getInstance("DES/CBC/PKCS5Padding");
            decrypt.init(Cipher.DECRYPT_MODE, secret_key, alogrithm_specs);

            // encrypt file
            encrypt(new FileInputStream(clearFile), new FileOutputStream(
                    encryptedFile));
            //decrypt file
      //      decrypt(new FileInputStream(encryptedFile), new FileOutputStream(
        //            decryptedFile));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void encrypt(InputStream input, OutputStream output)
            throws IOException {
        output = new CipherOutputStream(output, encrypt);
        writeBytes(input, output);
        System.out.println("Encryption is working ");
    }

    public void decrypt(InputStream input, OutputStream output)
            throws IOException {
        input = new CipherInputStream(input, decrypt);
        writeBytes(input, output);
        System.out.println("Decryption is working");
    }

    public void writeBytes(InputStream input, OutputStream output)
            throws IOException {
        byte[] writeBuffer = new byte[512];
        int readBytes = 0;

        while ((readBytes = input.read(writeBuffer)) >= 0) {
            output.write(writeBuffer, 0, readBytes);
        }

        output.close();
        input.close();

    }
}