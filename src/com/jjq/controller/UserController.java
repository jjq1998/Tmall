package com.jjq.controller;

import com.jjq.bean.Brand;
import com.jjq.bean.Search;
import com.jjq.bean.User;
import com.jjq.service.BrandService;
import com.jjq.service.SearchService;
import com.jjq.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController
{
    @Autowired
    UserService userService;

    @Autowired
    SearchService searchService;

    @Autowired
    BrandService brandService;

    private Map<String, HttpSession> userMap = new HashMap<>();

    @RequestMapping("/go")
    public String go(String type)
    {
        return type;
    }

    /**
     * @return 登录界面
     */
    @RequestMapping("/login")
    public String loginBefore()
    {
        return "redirect:/user/go?type=login/login";
    }

    /**
     * 登出
     *
     * @param session 当前用户的session
     * @return 登录界面
     */
    @RequestMapping("/logout")
    public String logout(HttpSession session)
    {
        User user = (User) session.getAttribute("user");
        userMap.remove(user.getName());
        session.invalidate();
        return "redirect:/user/go?type=login/login";
    }

    /**
     * 登录
     *
     * @param user 用户
     * @return 登录成功返回主页面， 否则返回登录页面
     */
    @RequestMapping("/doLogin")
    public String login(User user, HttpSession session, Model model, HttpServletRequest request)
    {
        User currentUser = userService.selectUserByNameAndPassword(user);
        if (currentUser != null)
        {
            if (userMap.containsKey(currentUser.getName()))
            {
                HttpSession httpSession = userMap.get(currentUser.getName());
                if (request.getSession(false) != null)
                {
                    httpSession.invalidate();
                }
                userMap.put(currentUser.getName(), session);
            }
            else
            {
                userMap.put(currentUser.getName(), session);
            }
            session.setAttribute("user", currentUser);
            String forwardUrl = (String) session.getAttribute("forwardUrl");
            session.removeAttribute("forwardUrl");
            if (forwardUrl != null)
            {
                return "redirect:" + forwardUrl;
            }
            else
            {
                return "redirect:/user/go?type=main/main";
            }
        }
        else
        {
            model.addAttribute("error", "用户名或密码错误");
            return "redirect:/user/go?type=login/login";
        }
    }

    /**
     * @return 主界面
     */
    @RequestMapping("/main")
    public String mainPage()
    {
        return "redirect:/user/go?type=main/main";
    }

    /**
     * 注册
     *
     * @param user 用户
     * @return 登录界面
     */
    @RequestMapping("/doInsert")
    public String register(User user)
    {
        userService.insertUser(user);
        return "redirect:/user/go?type=login/login";
    }

    /**
     * ajax查重
     *
     * @param name 用户名
     * @return 存在返回true 否则返回false
     */
    @RequestMapping("/selectUserName")
    @ResponseBody
    public Map<String, Object> selectUserName(String name)
    {
        Map<String, Object> map = new HashMap<>();
        if (userService.selectUserByName(name))
        {
            map.put("result", "true");
        }
        else
        {
            map.put("result", "false");
        }
        return map;
    }

    /**
     * 查询当前用户搜索历史
     *
     * @return 当前用户搜索历史
     */
    @RequestMapping("/selectUserSearch")
    @ResponseBody
    public List<Search> selectUserSearch(int id)
    {
        return searchService.selectAllSearchByUserId(id);
    }

    /**
     * ajax分页请求所有品牌
     * @param page 当前页
     * @return 所有品牌
     */
    @RequestMapping("/selectAllBrand")
    @ResponseBody
    public List<Brand> selectAllBrand(Integer page)
    {
        return brandService.selectAllBrand(page);
    }
}