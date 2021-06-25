package com.longzhi.lottery.service;

import com.longzhi.lottery.domain.Staff;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IStaffService {
    Staff findStaffById(String sid);
    int insertBatch(List<Staff> staffs);
    List<Staff> findAllStaff();
    List<Staff> findWinner();
    int insertSingle(String sid,String name, String sex, String age, String tele,String dep);
    int DelByPrimaryKey(String sid);
    int updateByPrimaryKey(String name, String sex, String age, String tele,String dep,String sid);
    int insertLottery(String sid,String prizelevel,String prize);
}
