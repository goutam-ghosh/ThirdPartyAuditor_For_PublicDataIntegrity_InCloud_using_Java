package myyoucloud;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class SplitFileExample {

    private static String FILE_NAME = "H:\\YouCloud\\build\\web\\uploads\\cries.PNG";

    public static void main(String[] args) throws Exception {
        File inputFile = new File(FILE_NAME);
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
                newFileName = FILE_NAME + ".part" + Integer.toString(nChunks - 1);
                filePart = new FileOutputStream(new File(newFileName));
                filePart.write(byteChunkPart);

                /*      SHA256 obj = new SHA256();
                 String res =" "; 
                 res= obj.sha(byteChunkPart, newFileName);
                 byte[] encData = new byte[1024];
                 encData = res.getBytes();

                 RSA obj = new RSA();
                 obj.checkKeys();
                 byte[] res = new byte[1024];
                 res = obj.encrypt(byteChunkPart, newFileName);
                 filePart.write(res);
                 */
                
                filePart.flush();
                filePart.close();
                byteChunkPart = null;
                filePart = null;

            }

            inputStream.close();
        } catch (IOException exception) {
            exception.printStackTrace();
        }
    }
}