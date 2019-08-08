package com.jjq.controller;

import com.jjq.bean.*;
import com.jjq.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController
{
    @Autowired
    AdminService adminService;

    @Autowired
    AdminLogService adminLogService;

    @Autowired
    ShopService shopService;

    @Autowired
    AskService askService;

    @Autowired
    UserService userService;

    @Autowired
    BrandService brandService;

    /**
     * @return 管理员登录界面
     */
    @RequestMapping("/login")
    public String loginBefore()
    {
        return "redirect:/user/go?type=admin/login";
    }

    /**
     * 登录
     *
     * @param name     用户名
     * @param password 密码
     * @return 转发到adminPage方法
     */
    @RequestMapping("/doLogin")
    public String login(String name, String password, HttpSession session, Model model)
    {
        Admin currentAdmin = adminService.selectAdminByNameAndPassword(name, password);
        if (currentAdmin != null)
        {
            AdminLog adminLog = new AdminLog();
            adminLog.setAction("登录");
            adminLog.setAdmin(currentAdmin);
            session.setAttribute("admin", currentAdmin);
//            adminLogService.insertAdminLog(adminLog);
            return "forward:/admin/adminPage";
        }
        else
        {
            model.addAttribute("error", "用户名或密码错误");
            return "redirect:/user/go?type=admin/login";
        }
    }

    /**
     * 根据当前管理员返回到不同页面
     *
     * @return 管理员界面
     */
    @RequestMapping("/adminPage")
    public String superAdminPage(HttpSession session, Model model)
    {
        Admin admin = (Admin) session.getAttribute("admin");
        switch (admin.getPermission())
        {
            case "super_admin":
                return "redirect:/user/go?type=admin/main";
            case "shop_admin":
                return "redirect:/user/go?type=admin/main1";
            case "customer_admin":
                return "redirect:/user/go?type=admin/main2";
            default:
                return "redirect:/user/go?type=admin/main";
        }
    }

    /**
     * ajax请求分页查询所有管理员
     *
     * @param page 当前页数
     * @return 当前页数管理员的json格式
     */
    @RequestMapping("/selectAllAdmin")
    @ResponseBody
    public List<Admin> selectAllAdmin(Integer page)
    {
        page = (page - 1) * 10;
        return adminService.selectAllAdmin(page);
    }

    /**
     * ajax请求分页查询所有管理员日志
     *
     * @param page 当前页数
     * @return 当前页数管理员日志的json格式
     */
    @RequestMapping("/selectAllAdminLog")
    @ResponseBody
    public List<AdminLog> selectAllAdminLog(Integer page)
    {
        page = (page - 1) * 10;
        return adminLogService.selectAllAdminLog(page);
    }

    /**
     * ajax请求管理员和管理员日志的总数
     *
     * @return 管理员和管理员日志总数的json格式
     */
    @RequestMapping("/selectAllCount")
    @ResponseBody
    public Map<String, Object> selectAllAdminAndLogCount()
    {
        Map<String, Object> map = new HashMap<>();
        map.put("adminCount", adminService.selectAllAdminCount());
        map.put("adminLogCount", adminLogService.selectAllAdminLogCount());
        return map;
    }

    /**
     * ajax用户名查重
     *
     * @param name 用户名
     * @return 重复返回true 否则返回false
     */
    @RequestMapping("/selectAdminName")
    @ResponseBody
    public Map<String, Object> selectUserName(String name)
    {
        Map<String, Object> map = new HashMap<>();
        if (adminService.selectAdminByName(name))
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
     * 注册管理员
     *
     * @param admin 管理员
     */
    @RequestMapping("/insertAdmin")
    public String insertAdmin(Admin admin, HttpSession session)
    {
        adminService.insertAdmin(admin);
        AdminLog adminLog = new AdminLog();
        adminLog.setAction("注册");
        adminLog.setAdmin((Admin) session.getAttribute("admin"));
        adminLogService.insertAdminLog(adminLog);
        return "forward:/admin/adminPage";
    }

    /**
     * 修改密码
     *
     * @param admin 管理员
     * @return 登录界面
     */
    @RequestMapping("/updateAdminPassword")
    public String updatePassword(Admin admin, HttpSession session)
    {
        adminService.updateAdmin(admin);
        AdminLog adminLog = new AdminLog();
        adminLog.setAction("修改密码");
        adminLog.setAdmin((Admin) session.getAttribute("admin"));
        adminLogService.insertAdminLog(adminLog);
        return "redirect:/user/go?type=admin/login";
    }

    /**
     * 删除管理员
     *
     * @param id 管理员ID
     */
    @RequestMapping("/deleteAdmin")
    public String deleteAdmin(Integer id, HttpSession session)
    {
        AdminLog adminLog = new AdminLog();
        adminLog.setAction("删除用户");
        adminLog.setAdmin((Admin) session.getAttribute("admin"));
        adminLogService.insertAdminLog(adminLog);
        adminService.deleteAdmin(id);
        return "forward:/admin/adminPage";
    }

    /**
     * 分页异步请求所有店铺
     *
     * @param page 当前页
     * @return 该页所有店铺
     */
    @RequestMapping("/selectAllShopAdmin")
    @ResponseBody
    public List<Shop> selectAllShopAdmin(Integer page)
    {
        page = (page - 1) * 10;
        return shopService.selectAllShop(page);
    }

    /**
     * 异步请求所有的店铺数量
     *
     * @return 所有店铺的数量
     */
    @RequestMapping("/selectShopPage")
    @ResponseBody
    public Map<String, Object> selectAllShopPage()
    {
        Map<String, Object> map = new HashMap<>();
        map.put("shopCount", shopService.selectShopCount());
        return map;
    }

    /**
     * 根据管理员的需求查询所有申请
     *
     * @param type 开店或认证
     * @param page 页数
     */
    @RequestMapping("/askListAdmin")
    @ResponseBody
    public List<Ask> askListAdmin(String type, Integer page)
    {
        return askService.selectAllAskByType(type, page);
    }

    /**
     * 异步查询申请总页数
     *
     * @return 当前申请页数
     */
    @RequestMapping("/selectAskPage")
    @ResponseBody
    public Map<String, Object> selectAskPage()
    {
        Map<String, Object> map = new HashMap<>();
        map.put("askCount", askService.selectTotalCountByType("开店"));
        map.put("brandCount", askService.selectTotalCountByType("认证"));
        return map;
    }

    /**
     * 异步请求店铺状态
     *
     * @param id 店铺ID
     * @return 店铺状态
     */
    @RequestMapping("/selectShopState")
    @ResponseBody
    public Map<String, Object> selectShopState(Integer id)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("shopState", shopService.selectShopState(id));
        return map;
    }

    /**
     * 更改店铺状态为整顿
     *
     * @param id 店铺ID
     */
    @RequestMapping("/updateShopState")
    @ResponseBody
    public void updateShopState(int id, HttpSession session)
    {
        AdminLog adminLog = new AdminLog();
        adminLog.setAction("下架店铺");
        adminLog.setAdmin((Admin) session.getAttribute("admin"));
        adminLogService.insertAdminLog(adminLog);
        shopService.updateShopState("整顿", id);
    }

    /**
     * 根据店铺ID查询店铺信息
     *
     * @param id 店铺ID
     * @return 店铺信息
     */
    @RequestMapping("/selectShopById")
    @ResponseBody
    public Map<String, Object> selectShopById(Integer id)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("shop", shopService.selectShopById(id));
        return map;
    }

    /**
     * 根据AskId查询申请信息
     *
     * @param id 申请ID
     * @return 申请信息
     */
    @RequestMapping("/selectAskById")
    @ResponseBody
    public Map<String, Object> selectAskById(Integer id)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("ask", askService.selectAskByAskId(id));
        return map;
    }

    /**
     * 根据申请是否通过进行相应处理
     * @param id 申请ID
     * @param state 申请状态
     */
    @RequestMapping("/updateAskState")
    @ResponseBody
    public void updateAskState(Integer id, String state, HttpSession session, HttpServletRequest request)
    {
        askService.updateAskState(id, state);
        Ask ask = askService.selectAskByAskId(id);
        AdminLog adminLog = new AdminLog();
        adminLog.setAdmin((Admin) session.getAttribute("admin"));
        if (state.equals("已通过"))
        {
            if (ask.getType().equals("开店"))
            {
                shopService.updateShopState("停业", ask.getShop().getId());
                askService.updateAskAdmin(((Admin) session.getAttribute("admin")).getName(), id);
                userService.updateUserType(ask.getUser().getId());
            }
            if (ask.getType().equals("认证"))
            {
                askService.updateAskAdmin(((Admin) session.getAttribute("admin")).getName(), id);
                Brand brand = new Brand();
                brand.setName(ask.getBrandName());
                brand.setTypeName(ask.getBrandType());
                brand.setImage(ask.getBrandImage());
                brandService.insertBrand(brand);
                shopService.updateShopBrand(brand.getId(), ask.getShop().getId());
            }
            adminLog.setAction("通过申请");
        }
        else if (state.equals("未通过"))
        {
            if (ask.getType().equals("开店"))
            {
                shopService.deleteShopByUserId(ask.getUser().getId());
                File file = new File(request.getServletContext().getRealPath("/") + "shopImage/" + ask.getShop().getName(), ask.getShop().getImage());
                if (file.exists())
                    file.delete();
                askService.updateAskAdmin(((Admin) session.getAttribute("admin")).getName(), id);
            }
            if (ask.getType().equals("认证"))
            {
                askService.updateAskAdmin(((Admin) session.getAttribute("admin")).getName(), id);
                File file = new File(request.getServletContext().getRealPath("/") + "brandImage/" + ask.getBrandName(), ask.getBrandImage());
                if (file.exists())
                    file.delete();
            }
            adminLog.setAction("驳回申请");
        }
        adminLogService.insertAdminLog(adminLog);
    }


}
