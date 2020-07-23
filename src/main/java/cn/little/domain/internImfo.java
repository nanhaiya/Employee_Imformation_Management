package cn.little.domain;

import java.io.Serializable;

public class internImfo implements Serializable {
    private int id;
    private  String name;
    private int AdaptPeriod;  //适应期
    private int GraowPeriod;  //融入期
    private int AssiPeriod;   //成长期

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAdaptPeriod() {
        return AdaptPeriod;
    }

    public void setAdaptPeriod(int adaptPeriod) {
        AdaptPeriod = adaptPeriod;
    }

    public int getGraowPeriod() {
        return GraowPeriod;
    }

    public void setGraowPeriod(int graowPeriod) {
        GraowPeriod = graowPeriod;
    }

    public int getAssiPeriod() {
        return AssiPeriod;
    }

    public void setAssiPeriod(int assiPeriod) {
        AssiPeriod = assiPeriod;
    }
}
