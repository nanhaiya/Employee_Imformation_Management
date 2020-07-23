package cn.little.domain;

import java.io.Serializable;

public class SalaryImfo implements Serializable {
    private int Id;
    private String Name;
    private double BasicS;  //底薪
    private double FullAS;  //全勤奖
    private double WorkS;   //项目奖
    private double OvertimeS;   //加班费
    private double Deduct;   //惩罚扣除
    private double Tax;     //个税

    public int getId() {
        return Id;
    }

    public void setId(int id) {
        Id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public double getBasicS() {
        return BasicS;
    }

    public void setBasicS(double basicS) {
        BasicS = basicS;
    }

    public double getFullAS() {
        return FullAS;
    }

    public void setFullAS(double fullAS) {
        FullAS = fullAS;
    }

    public double getWorkS() {
        return WorkS;
    }

    public void setWorkS(double workS) {
        WorkS = workS;
    }

    public double getOvertimeS() {
        return OvertimeS;
    }

    public void setOvertimeS(double overtimeS) {
        OvertimeS = overtimeS;
    }

    public double getDeduct() {
        return Deduct;
    }

    public void setDeduct(double deduct) {
        Deduct = deduct;
    }

    public double getTax() {
        return Tax;
    }

    public void setTax(double tax) {
        Tax = tax;
    }
}
