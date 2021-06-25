package com.longzhi.lottery.controller;

import com.longzhi.lottery.domain.Staff;
import com.longzhi.lottery.domain.User;
import com.longzhi.lottery.service.IUserService;
import com.longzhi.lottery.util.MD5Utils;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ResponseBody;
import net.sf.json.JSONArray;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {
    @Resource
    IUserService userService ;
    @RequestMapping(value = "/loginCheck",method = RequestMethod.POST)
    @ResponseBody
    public String loginCheck(String username, String password, HttpSession session){
        if(username==null||username.equals("")){
            return "nameEmpty";
        }
        if(password==null||password.equals("")){
            return "pwdEmpty";
        }
        User user=new User();
        user.setUsername(username);
        user.setPassword(password);
        if(userService.userLogin(user).getId()!=null){
            User sessionUser=userService.userLogin(user);
//            sessionUser.setPassword("");
            System.out.println(sessionUser.getUsername());
            session.setAttribute("admin",sessionUser.getUsername());
            return "ok";
        }
        return "error";
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout( HttpSession session){
        session.removeAttribute("admin");// 先取出httpsession中的student属性
        session.invalidate();
        return "login";
    }




}
