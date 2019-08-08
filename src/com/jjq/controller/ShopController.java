package com.jjq.controller;

import com.jjq.bean.Ask;
import com.jjq.bean.Shop;
import com.jjq.bean.User;
import com.jjq.service.AskService;
import com.jjq.service.BrandService;
import com.jjq.service.ShopService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping("/shop")
public class ShopController
{
    @Autowired
    ShopService shopService;

    @Autowired
    AskService askService;

    @Autowired
    BrandService brandService;

    /**
     * @return 已卖出商品
     */
    @RequestMapping("/shop")
    public String shop()
    {
        return "shop/shop";
    }

    /**
     * 开店申请相关页面
     * @param shopImage 店铺图片
     * @param shop 店铺信息
     * @param ask 申请信息
     * @return 申请列表
     * @throws IOException
     */
    @RequestMapping("/submitAsk")
    public String submitAsk(MultipartFile shopImage, HttpSession session, Shop shop, Ask ask, HttpServletRequest request) throws IOException
    {
        User user = (User) session.getAttribute("user");
        ask.setUser(user);
        shop.setUser(user);
        shop.setImage(shopImage.getOriginalFilename());
        if (!shopImage.isEmpty())
        {
            FileUtils.copyInputStreamToFile(shopImage.getInputStream(), new File(request.getServletContext().getRealPath("/") + "shopImage/" + shop.getName(), shopImage.getOriginalFilename()));
        }
        shopService.insertShop(shop);
        ask.setShop(shop);
        askService.insertAsk(ask);
        return "redirect:/ask/askList";
    }

    /**
     * 根据用户ID删除店铺
     * @return 管理员店铺界面
     */
    @RequestMapping("/deleteShop")
    public String deleteShopByUserId(HttpSession session)
    {
        shopService.deleteShopByUserId(((User) session.getAttribute("user")).getId());
        return null;
    }

    /**
     * @return 店铺详情页
     */
    @RequestMapping("/shopPage")
    public String selectShopByUserId(HttpSession session, Model model)
    {
        Shop shop = shopService.selectShopByUserId(((User) session.getAttribute("user")).getId());
        model.addAttribute("shop", shop);
        model.addAttribute("brand", brandService.selectByBrandId(shop.getBrandId()));
        return "shop/shopPage";
    }

    /**
     * 更改店铺客服
     * @param serviceOne 客服一
     * @param serviceTwo 客服二
     * @param serviceThree 客服三
     * @param shopId 店铺ID
     * @return 店铺信息页
     */
    @RequestMapping("/updateShopService")
    public String updateShopService(String serviceOne, String serviceTwo, String serviceThree, Integer shopId)
    {
        shopService.updateShopService(serviceOne, serviceTwo, serviceThree, shopId);
        return "redirect:/shop/shopPage";
    }

    @RequestMapping("/updateShopState")
    public String updateShopState(String state, Integer id)
    {
        shopService.updateShopState(state, id);
        return "redirect:/shop/shopPage";
    }
}
