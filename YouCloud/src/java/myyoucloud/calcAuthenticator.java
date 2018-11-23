/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package myyoucloud;

import java.io.File;
import java.io.FileInputStream;
import java.security.MessageDigest;

public class calcAuthenticator {

    //public static void main(String[] args) throws Exception {
    public String getAuth(String path, String filename) throws Exception {
        MessageDigest md = MessageDigest.getInstance("MD5");

        FileInputStream fis = new FileInputStream(path+"/"+filename);
        System.out.print(path);

        byte[] dataBytes = new byte[1024];

        int nread = 0;
        while ((nread = fis.read(dataBytes)) != -1) {
            md.update(dataBytes, 0, nread);
        };
        byte[] mdbytes = md.digest();

        //convert the byte to hex format method 1
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < mdbytes.length; i++) {
            sb.append(Integer.toString((mdbytes[i] & 0xff) + 0x100, 16).substring(1));
        }

        System.out.println("Digest(in hex format):: " + sb.toString());

        return sb.toString();
    }
}