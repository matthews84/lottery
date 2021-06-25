package com.longzhi.lottery.service.impl;

import com.longzhi.lottery.domain.Staff;
import com.longzhi.lottery.mapper.StaffMapper;
import com.longzhi.lottery.service.IStaffService;
import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StaffService implements IStaffService {
    @Resource
    private StaffMapper staffMapper;

   @Override
    public Staff findStaffById(String sid) {
        return staffMapper.selectByPrimaryKey(sid);
    }

    @Override
    public int insertBatch(List<Staff> staffs) {
        System.out.println("执行到StaffService的insertBatch");
        staffMapper.SetStaffTableId();
        return staffMapper.insertBatch(staffs);
    }

    @Override
    public List<Staff> findAllStaff() {
        List<Staff> staffs = staffMapper.findAllStaff();
        return  staffs;
    }
    @Override
    public List<Staff> findWinner() {
        List<Staff> staffs = staffMapper.findWinner();
        return  staffs;
    }
    @Override
    public  int insertSingle (String sid,String name, String sex, String age, String tele,String dep) {
        staffMapper.SetStaffTableId();
        return staffMapper.insertSingle(sid,name,sex,age,tele,dep);
    }
    @Override
    public  int DelByPrimaryKey (String sid) {
        return staffMapper.DelByPrimaryKey(sid);
    }
    @Override
    public  int updateByPrimaryKey (String name, String sex, String age, String tele,String dep,String sid) {
        return staffMapper.updateByPrimaryKey(name,sex,age,tele,dep,sid);
    }
    @Override
    public int insertLottery(String sid,String prizelevel,String prize){
        staffMapper.SetWinnerTableId();
        return staffMapper.insertLottery(sid,prizelevel,prize);
    }


}
