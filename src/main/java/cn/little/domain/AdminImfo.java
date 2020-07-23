package cn.little.domain;

import java.io.Serializable;

public class AdminImfo implements Serializable {
    private String admin;
    private String password;
    private Integer loadStatus;

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getLoadStatus() {
        return loadStatus;
    }

    public void setLoadStatus(int loadStatus) {
        this.loadStatus = loadStatus;
    }

    @Override
    public String toString() {
        return "AdminImfo{" +
                "admin='" + admin + '\'' +
                ", password='" + password + '\'' +
                ", loadStatus=" + loadStatus +
                '}';
    }
}
