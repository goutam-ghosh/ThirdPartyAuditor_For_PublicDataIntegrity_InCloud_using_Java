package myyoucloud;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.PKCS8EncodedKeySpec;
import java.sql.*;
import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.DESedeKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.servlet.http.HttpSession;

public class JavaDesDecryption {

    private static Cipher decrypt;
    private static final byte[] initialization_vector = {22, 33, 11, 44, 55, 99, 66, 77};

    //public static void main(String[] args) {
    public void initDes(String filename, SecretKey skey) {
        String encryptedFile = filename;
        try {

            AlgorithmParameterSpec alogrithm_specs = new IvParameterSpec(
                    initialization_vector);

            // set decryption mode
            decrypt = Cipher.getInstance("DES/CBC/PKCS5Padding");
            decrypt.init(Cipher.DECRYPT_MODE, skey, alogrithm_specs);

            //decrypt file
            decrypt(new FileInputStream(encryptedFile), new FileOutputStream(
                    encryptedFile));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void decrypt(InputStream input, OutputStream output)
            throws IOException {
        System.out.println("Decryption is working");
        input = new CipherInputStream(input, decrypt);
        writeBytes(input, output);

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