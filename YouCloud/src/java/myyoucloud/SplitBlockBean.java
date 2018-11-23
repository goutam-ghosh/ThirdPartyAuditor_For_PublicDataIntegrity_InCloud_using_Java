package myyoucloud;

import java.io.*;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.ServletContext;

public class SplitBlockBean {

    public int splitter(String path,String FILE_NAME, String email) throws FileNotFoundException, ClassNotFoundException {
        
        File inputFile = new File(path+"/"+FILE_NAME);
        FileInputStream inputStream;
        String newFileName;
        FileOutputStream filePart;
        int fileSize = (int) inputFile.length();
        System.out.println(fileSize);

        int PART_SIZE = (fileSize / 9);
        System.out.println(PART_SIZE);

        int nChunks = 0, read = 0, readLength = PART_SIZE;
        byte[] byteChunkPart = new byte[1024];

        try {
            inputStream = new FileInputStream(inputFile);
            while (fileSize > 0) {
                if (fileSize <= PART_SIZE) {
                    readLength = fileSize;
                }
                byteChunkPart = new byte[readLength];
                read = inputStream.read(byteChunkPart, 0, readLength);
                fileSize -= read;
                assert (read == byteChunkPart.length);

                System.out.println(nChunks);
                nChunks++;
                newFileName = path +"/"+FILE_NAME+ ".part" + Integer.toString(nChunks - 1);
                filePart = new FileOutputStream(new File(newFileName));
                System.out.println("Filename is : " + newFileName);
                /*      SHA256 obj = new SHA256();
                 String res =" "; 
                 res= obj.sha(byteChunkPart, newFileName);
                 byte[] encData = new byte[1024];
                 encData = res.getBytes();
                 
                 RSA obj = new RSA();
                 obj.checkKeys();
                 byte[] enc = new byte[1024];
                 enc = obj.encrypt(byteChunkPart, newFileName);
                 filePart.write(enc);
                 */
                JavaDesEncryption obj1 = new JavaDesEncryption();
                //JavaDesEncryption obj2 = new JavaDesEncryption();
                int ret = 0;

                obj1.initDes(newFileName, email);

                //DesDecrypt obj2 = new DesDecrypt();
                //obj2.initDes(newFileName);

                filePart.flush();
                filePart.close();
                byteChunkPart = null;
                filePart = null;

            }
            inputStream.close();
        } catch (IOException exception) {
            System.out.println(exception);
        }
        return nChunks;
    }
}