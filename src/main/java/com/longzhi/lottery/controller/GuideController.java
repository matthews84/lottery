package com.longzhi.lottery.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.ModelMap;

@Controller
public class GuideController {
    @RequestMapping(value ={"/","/index"} , method = RequestMethod.GET)
    public String index(final ModelMap model) {
        return "index";
    }

    @RequestMapping(value = "/setting", method = RequestMethod.GET)
    public String setting(final ModelMap model) {
        return "setting";

    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(final ModelMap model) {
        return "login";

    }

    @RequestMapping(value = "/upload", method = RequestMethod.GET)
    public String upload(final ModelMap model) {
        return "upload";

    }
    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(final ModelMap model) {
        return "admin";
    }
    @RequestMapping(value = "/winner", method = RequestMethod.GET)
    public String winner(final ModelMap model) {
        return "winner";
    }
    @RequestMapping(value = "/staff", method = RequestMethod.GET)
    public String staff(final ModelMap model) {
        return "staff";
    }
    @RequestMapping(value = "/calendar", method = RequestMethod.GET)
    public String calendar(final ModelMap model) {
        return "calendar";
    }
    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public String temp(final ModelMap model) {
        return "test";
    }

}
