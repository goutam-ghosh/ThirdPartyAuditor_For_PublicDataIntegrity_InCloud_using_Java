package myyoucloud;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

//import package for the cryptography
import javax.crypto.Cipher;
import javax.crypto.CipherInputStream;
import javax.crypto.CipherOutputStream;
import javax.crypto.spec.SecretKeySpec;

public class FileEncryption1 {

    private String algorithm;
    private File file;

    public FileEncryption1(String algorithm, String path) {
        this.algorithm = algorithm;
        this.file = new File(path);
    }

    public void encrypt() throws Exception {
        FileInputStream fis = new FileInputStream(file);
//file=new File(file.getAbsolutePath()+".enc");
        FileOutputStream fos = new FileOutputStream(file);

//generating key
        byte k[] = "Aparajit".getBytes();
        SecretKeySpec key = new SecretKeySpec(k, "DES");

//creating and initialising cipher and cipher streams
        Cipher encrypt = Cipher.getInstance(algorithm);
        encrypt.init(Cipher.ENCRYPT_MODE, key);
        CipherOutputStream cout = new CipherOutputStream(fos, encrypt);

        byte[] buf = new byte[1024];
        int read;

        while ((read = fis.read(buf)) != -1) //reading data
        {
            cout.write(buf, 0, read); //writing encrypted data
        }//closing streams
        fis.close();
        cout.flush();
        cout.close();
    }

    public void decrypt() throws Exception {
//opening streams
        FileInputStream fis = new FileInputStream(file);
//file=new File(file.getAbsolutePath());
        FileOutputStream fos = new FileOutputStream(file);

//generating same key
        byte k[] = "Aparajit".getBytes();
        SecretKeySpec key = new SecretKeySpec(k, "DES");

//creating and initialising cipher and cipher streams
        Cipher decrypt = Cipher.getInstance(algorithm);
        decrypt.init(Cipher.DECRYPT_MODE, key);
        CipherInputStream cin = new CipherInputStream(fis, decrypt);

        byte[] buf = new byte[1024];
        int read = 0;

        while ((read = cin.read(buf)) != -1) //reading encrypted data
        {
            fos.write(buf, 0, read); //writing decrypted data
        }

//closing streams
        cin.close();
        fos.flush();
        fos.close();
    }

    public static void main(String[] args) throws Exception {
//create a file name called test.txt then execute it else Excpetion occurs
        new FileEncryption1("DES/ECB/PKCS5Padding", "H:\\YouCloud\\build\\web\\uploads\\diabetes.arff").encrypt();
//new FileEncryption1("DES/ECB/PKCS5Padding","H:\\YouCloud\\build\\web\\uploads\\TextFile.txt").decrypt();
    }
}