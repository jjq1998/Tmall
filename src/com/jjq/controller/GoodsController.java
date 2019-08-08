package com.jjq.controller;

import com.jjq.bean.*;
import com.jjq.service.BrandService;
import com.jjq.service.GoodsService;
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
import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController
{
    @Autowired
    TypeService typeService;

    @Autowired
    GoodsService goodsService;

    @Autowired
    ShopService shopService;

    @Autowired
    BrandService brandService;

    /**
     * @param model 当前的一级分类
     * @return 添加商品页面
     */
    @RequestMapping(value = "/goodsInsert")
    public String goodsInsertPage(Model model)
    {
        model.addAttribute("typeList", typeService.selectAllType());
        return "shop/goodsInsert";
    }

    /**
     * 添加商品
     *
     * @param typeId     所属三级分类ID的数组
     * @param goodsImage 商品图片
     * @param goods      商品实体类
     * @param request    用于获取当前项目路径
     * @param session    用于获取当前user
     * @throws IOException IO异常
     */
    @RequestMapping("/insertGoods")
    @ResponseBody
    public void insertGoods(Integer[] typeId, MultipartFile goodsImage, Goods goods, HttpServletRequest request, HttpSession session) throws IOException
    {
        User user = (User) session.getAttribute("user");
        Shop shop = shopService.selectShopByUserId(user.getId());
        goods.setShop(shop);
        if (goodsImage != null && !goodsImage.isEmpty())
        {
            FileUtils.copyInputStreamToFile(goodsImage.getInputStream(), new File(request.getServletContext().getRealPath("/") + "shopImage/" + shop.getName() + "/" + goods.getId(), goodsImage.getOriginalFilename()));
            goods.setImage(goodsImage.getOriginalFilename());
        }
        goodsService.insertNewGoods(goods);
        goodsService.insertGoodsTypeByGoodsId(goods.getId(), typeId);
    }

    /**
     * @param session 用于获取当前user
     * @param model   当前仓库中的商品
     * @return 当前仓库中商品页面
     */
    @RequestMapping("/goodsListStore")
    public String goodsStore(HttpSession session, Model model)
    {
        User user = (User) session.getAttribute("user");
        Shop shop = shopService.selectShopByUserId(user.getId());
        List<Goods> list = goodsService.selectAllGoodsByShopId(shop.getId());
        model.addAttribute("goodsList", list);
        return "shop/goodsListStore";
    }

    /**
     * @return 当前在售商品页面
     */
    @RequestMapping("/goodsListSale")
    public String goodsSale()
    {
        return "shop/goodsListSale";
    }

    /**
     * 根据商品ID查询商品信息
     *
     * @param id    商品ID
     * @param model 当前商品信息和所属品牌
     * @return 商品详情页面
     */
    @RequestMapping("/goodsById")
    public String selectGoodsById(Integer id, Model model)
    {
        Goods goods = goodsService.selectGoodsByGoodsId(id);
        model.addAttribute("goods", goods);
        model.addAttribute("brand", brandService.selectBrandByShopId(goods.getShop().getId()));
        return "shop/goodsById";
    }

    /**
     * 更新商品信息页面
     *
     * @param id    商品ID
     * @param model 当前商品信息
     * @return 更新商品信息页面
     */
    @RequestMapping("/goodsUpdate")
    public String updateGoodsBefore(Integer id, Model model)
    {
        model.addAttribute("goods", goodsService.selectGoodsByGoodsId(id));
        return "shop/goodsUpdate";
    }

    /**
     * 更改商品信息
     *
     * @param typeId     所属三级分类ID的数组
     * @param goodsImage 商品图片
     * @param goods      商品实体类
     * @param request    用于获取当前项目路径
     * @param session    用于获取当前user
     * @throws IOException
     */
    @RequestMapping("/updateGoods")
    @ResponseBody
    public void updateGoods(Integer[] typeId, MultipartFile goodsImage, Goods goods, HttpServletRequest request, HttpSession session) throws IOException
    {
        User user = (User) session.getAttribute("user");
        Shop shop = shopService.selectShopByUserId(user.getId());
        goods.setShop(shop);
        Goods oldGoods = goodsService.selectGoodsByGoodsId(goods.getId());
        if (goodsImage != null && !goodsImage.isEmpty())
        {
            File file = new File(request.getServletContext().getRealPath("/") + "shopImage/" + shop.getName() + "/" + goods.getId(), oldGoods.getImage());
            if (file.exists())
                file.delete();
            FileUtils.copyInputStreamToFile(goodsImage.getInputStream(), new File(request.getServletContext().getRealPath("/") + "shopImage/" + shop.getName() + "/" + goods.getId(), goodsImage.getOriginalFilename()));
            goods.setImage(goodsImage.getOriginalFilename());
        }
        goodsService.deleteGoodsTypeByGoodsId(goods.getId());
        goodsService.insertGoodsTypeByGoodsId(goods.getId(), typeId);
        goodsService.updateGoodsByGoodsId(goods);
    }

    /**
     * 添加商品参数页面
     *
     * @param id    商品ID
     * @param model 商品参数
     * @return 添加商品参数页面
     */
    @RequestMapping("/goodsParamInsert")
    public String insertGoodsParamBefore(Integer id, Model model)
    {
        model.addAttribute("goods", goodsService.selectGoodsByGoodsId(id));
        model.addAttribute("goodsSlide", goodsService.selectGoodsSlideByGoodsId(id));
        return "shop/insertGoodsParam";
    }

    /**
     * 添加商品可选参数
     *
     * @param goodsChoose 商品可选参数
     */
    @RequestMapping("/insertGoodsChoose")
    public String insertGoodsChoose(GoodsChoose goodsChoose)
    {
        GoodsChoose goodsChooseByGoodsId = goodsService.selectGoodsChooseByGoodsId(goodsChoose.getGoodsId());
        if (goodsChooseByGoodsId != null)
            goodsService.updateGoodsChoose(goodsChoose);
        else
            goodsService.insertGoodsChoose(goodsChoose);
        return "redirect:/goods/goodsParamInsert?id=" + goodsChoose.getGoodsId();
    }

    /**
     * 添加商品轮播图，先将原来的轮播图文件以及表中数据删除然后上传新的文件和新的表数据
     *
     * @param goodsImage 轮播图组
     * @param request    用于获取项目路径
     * @param goodsId    商品ID
     * @throws IOException IO异常
     */
    @RequestMapping("/insertGoodsSlide")
    public String insertGoodsSlide(MultipartFile[] goodsImage, HttpServletRequest request, Integer goodsId) throws IOException
    {
        Goods goods = goodsService.selectGoodsByGoodsId(goodsId);
        GoodsSlide goodsSlide = new GoodsSlide();
        goodsSlide.setGoodsId(goodsId);
        File fileDir = new File(request.getServletContext().getRealPath("/") + "shopImage/" + goods.getShop().getName() + "/" + goodsId + "/slide");
        if (fileDir.exists())
            fileDir.delete();
        goodsService.deleteGoodsSlideByGoodsId(goodsId);
        for (MultipartFile file : goodsImage)
        {
            if (file != null && !file.isEmpty())
            {
                FileUtils.copyInputStreamToFile(file.getInputStream(), new File(request.getServletContext().getRealPath("/") + "shopImage/" + goods.getShop().getName() + "/" + goods.getId() + "/slide", file.getOriginalFilename()));
            }
            goodsSlide.setImageUrl(file.getOriginalFilename());
            goodsService.insertGoodsSlide(goodsSlide);
        }
        return "redirect:/goods/goodsParamInsert?id=" + goodsId;
    }

    /**
     * 添加商品规格
     *
     * @param goodsParam 商品规格实体类
     * @param goodsId    商品ID
     */
    @RequestMapping("/insertGoodsParam")
    public String insertGoodsParam(GoodsParam goodsParam, Integer goodsId)
    {
        GoodsChoose goodsChoose = goodsService.selectGoodsChooseByGoodsId(goodsId);
        goodsService.insertGoodsParam(goodsParam, goodsChoose.getId());
        return "redirect:/goods/goodsParamInsert?id=" + goodsId;
    }

    /**
     * 根据商品规格ID删除
     *
     * @param id 规格ID
     * @param goodsId 商品ID
     * @return
     */
    @RequestMapping("/deleteGoodsParamById")
    public String deleteGoodsParamByGoodsParamId(Integer id, Integer goodsId)
    {
        goodsService.deleteGoodsParamByParamId(id);
        return "redirect:/goods/goodsParamInsert?id=" + goodsId;
    }
}
