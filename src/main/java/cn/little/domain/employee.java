package cn.little.domain;

import java.io.Serializable;

public class employee implements Serializable {
    private Integer Id;
    private String Name;
    private String jobName;
    private String WorkPlace;
    private String Kind;

    public Integer getId() {
        return Id;
    }

    public void setId(Integer id) {
        Id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getWorkPlace() {
        return WorkPlace;
    }

    public void setWorkPlace(String workPlace) {
        WorkPlace = workPlace;
    }

    public String getKind() {
        return Kind;
    }

    public void setKind(String kind) {
        Kind = kind;
    }

    @Override
    public String toString() {
        return "employee{" +
                "Id=" + Id +
                ", Name='" + Name + '\'' +
                ", jobName='" + jobName + '\'' +
                ", WorkPlace='" + WorkPlace + '\'' +
                ", Kind='" + Kind + '\'' +
                '}';
    }
}
