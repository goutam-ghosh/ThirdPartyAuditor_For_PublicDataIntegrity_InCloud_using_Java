/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package myyoucloud;

public class DBConnector {

    private String constr;

    public DBConnector() {
       constr = "jdbc:mysql://localhost:3306/youcloud?user=root&password=goutam";
      // constr = "jdbc:mysql://mysql32813-youcloud.cloud.hostnet.nl/youcloud?user=root&password=ETDeqo41646";
    }

    public String getConstr() {
        return (constr);
    }
}