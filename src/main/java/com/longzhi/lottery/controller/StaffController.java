package com.longzhi.lottery.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.longzhi.lottery.domain.Lottery;
import com.longzhi.lottery.domain.Staff;
import com.longzhi.lottery.service.IStaffService;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class StaffController {
    @Resource
    private  IStaffService staffService;

    @ResponseBody
    @RequestMapping(value = "/lottery-data",method = RequestMethod.POST)
    public String lotterydata(String lottery_result,String prizelevel,String prize){
        List<Lottery> lottery = new ArrayList<Lottery>();
        int update_status = 0;
        lottery = JSONObject.parseArray(lottery_result, Lottery.class);
        System.out.println("lottery"+lottery.get(0).getSid());
        for(int i=0;i<lottery.size();i++){
            String sid =lottery.get(i).getSid();
            update_status = staffService.insertLottery(sid,prizelevel,prize);
        }
        if(update_status>0){
            return "ok";
        }
        else{
            return "error";
        }
    }

    @ResponseBody
    @RequestMapping(value = "/import",produces = {"text/html;charset=UTF-8"})
    public String importStaff(@RequestBody List<Staff> staffs){
        /*for(Staff s:staffs){
            System.out.println(s.getDep());
        }*/
        staffService.insertBatch(staffs);
        return "导入成功";
    }
    @ResponseBody
    @RequestMapping(value = "/staff-list",produces = "application/json; charset=utf-8")
    public String stafflist(){
        List<Staff> staffs = staffService.findAllStaff();
        String jsonStr = JSON.toJSONString(staffs);
        return jsonStr;
    }

    @ResponseBody
    @RequestMapping(value = "/winner-list",produces = "application/json; charset=utf-8")
    public String winnerlist(String order,String offset,String limit){
        List<Staff> staffs = staffService.findWinner();
        for(Staff s:staffs){
            System.out.println("中奖者"+s.getSid());
            System.out.println("奖品"+s.getPrize());
        }
        String jsonStr = JSON.toJSONString(staffs);
        return jsonStr;
    }
    @RequestMapping(value = "/insert-staff",method = RequestMethod.POST)
    public String  insertstaff(String add_sid,String add_name, String add_sex, String add_age, String add_tele,String add_dep, Model model){
        System.out.println(add_sid);
        System.out.println(add_dep);
        int add_status = staffService.insertSingle(add_sid,add_name,add_sex,add_age,add_tele,add_dep);
        if(add_status!=0){
            model.addAttribute("add_status","ok");
        }
        else{
            model.addAttribute("add_status","error");
        }
        return "admin";
    }
    @RequestMapping(value = "/del-staff",method = RequestMethod.POST)
    public String delstaff(String del_sid,Model model){
        System.out.println("删除员工"+del_sid);
        int del_status = staffService.DelByPrimaryKey(del_sid);
        if(del_status!=0){
            model.addAttribute("del_status","ok");
        }
        else{
            model.addAttribute("del_status","error");
        }
        return "admin";
    }
    @RequestMapping(value = "/update-staff",method = RequestMethod.POST)
    public String updatestaff(String update_sid,String update_name,String update_sex,String update_age,String update_tele,String update_dep,Model model){
        /*System.out.println("update_name"+update_name);
        System.out.println("update_sex"+update_sex);
        System.out.println("update_age"+update_age);
        System.out.println("update_tele"+update_tele);
        System.out.println("update_id"+update_id);*/
        int update_status = staffService.updateByPrimaryKey(update_name,update_sex,update_age,update_tele,update_dep,update_sid);
        if(update_status!=0){
            model.addAttribute("update_status","ok");
        }
        else{
            model.addAttribute("update_status","error");
        }
        return "admin";
    }
}
