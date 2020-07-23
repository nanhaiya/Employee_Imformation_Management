package cn.little.domain;

import java.io.Serializable;

public class JobImfo implements Serializable {
    private int jobId;
    private String jobName;
    private String imageName;
    private String jobScrite;
    private int jobNeedP;
    private int jobNeed;

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getJobScrite() {
        return jobScrite;
    }

    public void setJobScrite(String jobScrite) {
        this.jobScrite = jobScrite;
    }

    public int getJobNeedP() {
        return jobNeedP;
    }

    public void setJobNeedP(int jobNeedP) {
        this.jobNeedP = jobNeedP;
    }

    public int getJobNeed() {
        return jobNeed;
    }

    public void setJobNeed(int jobNeed) {
        this.jobNeed = jobNeed;
    }
}
