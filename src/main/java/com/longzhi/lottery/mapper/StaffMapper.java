package com.longzhi.lottery.mapper;

import com.longzhi.lottery.domain.Staff;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StaffMapper {
    int SetStaffTableId();
    int SetWinnerTableId();
    Staff selectByPrimaryKey(String sid);
    int insertBatch(List<Staff> staffs);
    List<Staff> findAllStaff();
    List<Staff> findWinner();
    //添加员工
    int insertSingle(@Param("sid")String sid,@Param("name")String name, @Param("sex")String sex, @Param("age")String age, @Param("tele")String tele,@Param("dep")String dep);
    //删除员工
    int DelByPrimaryKey(@Param("sid")String sid);
    //更新员工
    int updateByPrimaryKey(@Param("name")String name, @Param("sex")String sex, @Param("age")String age, @Param("tele")String tele,@Param("dep")String dep,@Param("sid")String sid);
    int insertLottery(@Param("sid")String sid,@Param("prizelevel")String prizelevel,@Param("prize") String prize);
}
