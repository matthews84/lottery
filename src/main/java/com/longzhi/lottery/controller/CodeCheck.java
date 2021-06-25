package com.longzhi.lottery.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import static com.longzhi.lottery.domain.Code.p_code;

/**
 *处理登录请求
 */
@Controller
public class CodeCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @RequestMapping(value = "/codeCheck",method = RequestMethod.POST)
    @ResponseBody
    protected void codeCheck(HttpServletRequest request, HttpServletResponse response,String checkCode) throws ServletException, IOException {
        //PrintWriter out = response.getWriter();
        if (!checkCode.equalsIgnoreCase(p_code.toString())) {
            //System.out.println("执行到这里if");
            request.setAttribute("errormsg", "验证码不正确");
            response.getWriter().write("error");
            //out.println("<script type='text/javascript'>alert('验证码错误!');window.location.href='index.jsp';</script>");
        }
        else{
            //System.out.println("执行到这里else");
            response.getWriter().write("ok");

        }
        //out.println("<script type='text/javascript'>alert('登录成功!');window.location.href='login.jsp'</script>");
    }

}