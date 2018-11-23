package myyoucloud;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class MergeFileExample {

    public static final byte[] initialization_vector = {22, 33, 11, 44, 55, 99, 66, 77};
    private static String FILE_NAME = "H:\\YouCloud\\build\\web\\uploads\\Short Term Goal.txt";

    public static void main(String[] args) {

        File ofile = new File(FILE_NAME);
        FileOutputStream fos;
        FileInputStream fis;
        byte[] fileBytes;
        int bytesRead = 0;
        List<File> list = new ArrayList<File>();

        list.add(
                new File(FILE_NAME + ".part0"));
        list.add(
                new File(FILE_NAME + ".part1"));
        list.add(
                new File(FILE_NAME + ".part2"));
        list.add(
                new File(FILE_NAME + ".part3"));
        list.add(
                new File(FILE_NAME + ".part4"));
        list.add(
                new File(FILE_NAME + ".part5"));
        list.add(
                new File(FILE_NAME + ".part6"));
        list.add(
                new File(FILE_NAME + ".part7"));
        list.add(
                new File(FILE_NAME + ".part8"));
        list.add(
                new File(FILE_NAME + ".part9"));
        try {
//            Class.forName("com.mysql.jdbc.Driver");
//            DBConnector dbc = new DBConnector();
//            Connection con = DriverManager.getConnection(dbc.getConstr());
//            PreparedStatement pst = con.prepareStatement("select deskey from users where email=?;");
//            pst.setString(1, "ankush.r.nistane@gmail.com");
//            ResultSet rs = pst.executeQuery();
//            while (rs.next()) {
//                secret_key = rs.getString("deskey");
//            }


//            byte[] encodedKey = Base64.decode(secret_key);
//            SecretKey skey1 = new SecretKeySpec(encodedKey, 0, encodedKey.length, "DES");
//            System.out.println(secret_key + " : " + skey1);

            String key = "Ankush@02";
            DESKeySpec dks = new DESKeySpec(key.getBytes());
            SecretKeyFactory skf = SecretKeyFactory.getInstance("DES");
            SecretKey secret_key = skf.generateSecret(dks);
            System.out.println("Dec secret key : " + secret_key);

            fos = new FileOutputStream(ofile, true);
            for (File file : list) {

                fis = new FileInputStream(file);
                //
                String fname = "H:\\YouCloud\\build\\web\\uploads\\" + file.getName();
                JavaDesDecryption dec = new JavaDesDecryption();
                dec.initDes(fname, secret_key);
                //System.out.println(fname);
                //
                System.out.println("FileName : " + fname);
                fileBytes = new byte[(int) file.length()];
                bytesRead = fis.read(fileBytes, 0, (int) file.length());
                assert (bytesRead == fileBytes.length);
                assert (bytesRead == (int) file.length());

//                RSA obj1 = new RSA();
//                obj1.checkKeys();
//                String dec = obj1.decrypt(fileBytes, file.getName());
//                fos.write(dec.getBytes());


                fos.write(fileBytes);
                fos.flush();
                fileBytes = null;
                fis.close();
                fis = null;
            }
            fos.close();
            fos = null;
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }
}