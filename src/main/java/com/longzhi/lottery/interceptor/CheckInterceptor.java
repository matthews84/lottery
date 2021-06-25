package com.longzhi.lottery.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        //获取请求的RUi:去除http:localhost:8080这部分剩下的
        String url = request.getRequestURI();
        System.out.println("url="+url);
        //UTL:除了login.jsp是可以公开访问的，其他的URL都进行拦截控制
        Boolean flag = true;
        String[] wUrl = {"/login","/index","/upload","test","codeCheck","pictureCheckCode","lottery-data","import","staff-list","winner-list","insert-staff","del-staff","update-staff"};
        for(String temp : wUrl){
            if(url.indexOf(temp) != -1){
                flag = false;
                System.out.println("不拦截");
                break;
            }
        }
        HttpSession session = request.getSession();
        String aname = (String) session.getAttribute("admin");
        if(flag)
        {
            if(aname == null ||"".equals(aname)){
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().println("<script>alert('请先登录');window.location='login'</script>");
                return false;
            }
            else{

                return true;
            }
        }
        else{
            return true;
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
