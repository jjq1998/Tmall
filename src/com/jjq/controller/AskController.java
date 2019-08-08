package com.jjq.controller;

import com.jjq.bean.Ask;
import com.jjq.bean.Brand;
import com.jjq.bean.Shop;
import com.jjq.bean.User;
import com.jjq.service.AskService;
import com.jjq.service.BrandService;
import com.jjq.service.ShopService;
import com.jjq.service.TypeService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/ask")
public class AskController
{
    @Autowired
    AskService askService;

    @Autowired
    ShopService shopService;

    @Autowired
    BrandService brandService;

    @Autowired
    TypeService typeService;

    /**
     * 根据用户ID查询该用户所有申请
     * @param page 当前页数
     * @return 申请列表
     */
    @RequestMapping("/askList")
    public String askList(Integer page, Model model, HttpSession session)
    {
        User user = (User) session.getAttribute("user");
        if (page == null || page < 1)
            page = 1;
        Integer totalPage = askService.selectTotalPageByUserId(user.getId());
        if (page > totalPage)
            page = totalPage;
        model.addAttribute("askList", askService.selectAllAskByUserId(user.getId(), page));
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("page", page);
        return "shop/askList";
    }

    /**
     * @return 品牌认证页面
     */
    @RequestMapping("/brandAsk")
    public String brandAsk(Model model, HttpSession session)
    {
        model.addAttribute("typeList", typeService.selectAllType());
        if (askService.selectBrandAskIsExistByUserId(((User) session.getAttribute("user")).getId()))
        {
            model.addAttribute("askIsExist", "true");
        }
        if (shopService.selectShopIsBrand(((User) session.getAttribute("user")).getId()))
        {
            model.addAttribute("shopIsBrand", "true");
        }
        return "shop/brandAsk";
    }

    /**
     * @return 开店申请页面
     */
    @RequestMapping("/openShop")
    public String openShop(Model model, HttpSession session)
    {
        if (askService.selectOpenShopAskIsExistByUserId(((User) session.getAttribute("user")).getId()))
        {
            model.addAttribute("askIsExist", "true");
        }
        return "shop/openShop";
    }

    /**
     * 撤销开店申请
     * @return 开店申请页面
     */
    @RequestMapping("/cancelAsk")
    public String deleteAskAndShopByUserId(HttpSession session, HttpServletRequest request)
    {
        User user = (User) session.getAttribute("user");
        Shop shop = shopService.selectShopById(user.getId());
        File file = new File(request.getServletContext().getRealPath("/") + "shopImage/" + shop.getName(), shop.getImage());
        if (file.exists())
            file.delete();
        askService.deleteOpenShopAskByUserId(user.getId());
        shopService.deleteShopByUserId(user.getId());
        return "redirect:/ask/openShop";
    }

    @RequestMapping("/cancelBrandAsk")
    public String deleteBrandAskByUserId(HttpSession session, HttpServletRequest request)
    {
        User user = (User) session.getAttribute("user");
        Ask ask = askService.selectBrandAskByUserId(user.getId());
        File file = new File(request.getServletContext().getRealPath("/") + "brandImage/" + ask.getBrandName(), ask.getBrandImage());
        if (file.exists())
            file.delete();
        askService.deleteBrandAskByUserId(user.getId());
        return "redirect:/ask/brandAsk";
    }

    /**
     * 根据ID查询申请
     * @param id 申请ID
     * @return 详情页面
     */
    @RequestMapping("/selectAskById")
    public String selectAskByAskId(int id, Model model)
    {
        Ask ask = askService.selectAskByAskId(id);
        model.addAttribute("ask", ask);
        return "/shop/askList2";
    }

    /**
     * ajax根据TypeName请求所属品牌
     * @param typeName 店家所选Type
     * @return 该Type下所属品牌
     */
    @RequestMapping("/selectBrandByTypeName")
    @ResponseBody
    public List<Brand> selectBrandByTypeName(String typeName)
    {
        return brandService.selectBrandByTypeName(typeName);
    }

    /**
     * 添加品牌认证申请
     * @param ask 申请
     * @param file 品牌图标
     * @return 申请列表
     * @throws IOException
     */
    @RequestMapping("/insertBrandAsk")
    public String insertBrandAsk(Ask ask, MultipartFile file, HttpSession session, HttpServletRequest request) throws IOException
    {
        User user = (User) session.getAttribute("user");
        ask.setUser(user);
        Shop shop = shopService.selectShopByUserId(user.getId());
        ask.setShop(shop);
        if (!file.isEmpty())
        {
            FileUtils.copyInputStreamToFile(file.getInputStream(), new File(request.getServletContext().getRealPath("/") + "brandImage/" + ask.getBrandName(), file.getOriginalFilename()));
        }
        ask.setBrandImage(file.getOriginalFilename());
        askService.insertBrandAsk(ask);
        return "redirect:/ask/askList";
    }

    /**
     * ajax请求查询品牌名称是否重复
     * @param name 品牌名称
     * @return 存在返回true 否则返回false
     */
    @RequestMapping("/selectBrandIsExist")
    @ResponseBody
    public Map<String, Object> selectBrandIsExist(String name)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("result", brandService.selectBrandIsExist(name));
        return map;
    }
}
