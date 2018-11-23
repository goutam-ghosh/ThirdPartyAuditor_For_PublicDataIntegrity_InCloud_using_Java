package myyoucloud;

import java.security.NoSuchAlgorithmException;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

public class SecKey {

    public static void main(String[] args) {
        try {
            String algorithm = "DESede";
            // create a key generator
            KeyGenerator keyGen = KeyGenerator.getInstance(algorithm);
            // generate a key
            SecretKey key = keyGen.generateKey();
            // get the raw key bytes
            byte[] keyBytes = key.getEncoded();
            System.out.println("Key before: " + keyBytes + " : " + key);
            // construct a secret key from the given byte array
            SecretKey keyFromBytes = new SecretKeySpec(keyBytes, algorithm);
            System.out.println("Key After: " + keyFromBytes);
            System.out.println("Are equal: " + key.equals(keyFromBytes));
        } catch (NoSuchAlgorithmException e) {
            System.out.println("No Such Algorithm:" + e.getMessage());
            return;
        }
    }
}
