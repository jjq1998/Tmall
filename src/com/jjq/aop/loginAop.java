package com.jjq.aop;

import com.jjq.bean.User;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.portlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


@Aspect
@Component
public class loginAop
{
    @Around("pointCut()")
    public Object around(ProceedingJoinPoint proceedingJoinPoint) throws Throwable
    {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        User user = (User) request.getSession(true).getAttribute("user");
        request.getSession().setAttribute("forwardUrl", request.getRequestURI() + "?" + request.getQueryString());
        if (user == null)
        {
            System.out.println("用户为空");
            return "login/login";
        }
        return proceedingJoinPoint.proceed();
    }

    @Pointcut("within(com.jjq.controller..*)&&!within(com.jjq.controller.UserController)&&!within(com.jjq.controller.AdminController)&&!within(com.jjq.controller.TypeController)")
    public void pointCut()
    {
    }
}
