package com.longzhi.lottery.domain;

public class Staff {
    private Integer id;
    private String sid;
    private String name;
    private String sex;
    private Integer age;
    private String dep;
    private String tele;
    private Integer isDelete;
    private String prizelevel;
    private String prize;

    public Integer getId() {   return id;   }

    public void setId(Integer id) {  this.id = id;   }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getTele() {
        return tele;
    }

    public void setTele(String tele) {
        this.tele = tele;
    }

    public String getDep() {
        return dep;
    }

    public void setDep(String dep) {
        this.dep = dep;
    }

    public String getPrizelevel() {  return prizelevel;  }

    public void setPrizelevel(String prizelevel) {   this.prizelevel = prizelevel;}

    public String getPrize() {  return prize; }

    public void setPrize(String prize) {  this.prize = prize;  }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
    }

}
