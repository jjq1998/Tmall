package com.jjq.controller;

import com.jjq.bean.Category;
import com.jjq.bean.GoodsType;
import com.jjq.bean.Type;
import com.jjq.service.GoodsService;
import com.jjq.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/type")
public class TypeController
{
    @Autowired
    TypeService typeService;

    @Autowired
    GoodsService goodsService;

    /**
     * 异步分页查询所有的Type
     *
     * @param page 当前页数
     * @return 该页数所有的Type
     */
    @RequestMapping("/selectAllType")
    @ResponseBody
    public List<Type> selectAllType(Integer page)
    {
        page = (page - 1) * 6;
        return typeService.selectAllTypeInPage(page);
    }

    /**
     * 异步分页查询所有的Category
     *
     * @param page 当前页数
     * @return 该页数所有的Category
     */
    @RequestMapping("/selectAllCategory")
    @ResponseBody
    public List<Category> selectAllCategory(Integer page)
    {
        page = (page - 1) * 6;
        return typeService.selectAllCategoryInPage(page);
    }

    /**
     * 异步分页查询所有的GoodsType
     *
     * @param page 当前页数
     * @return 该页数所有的GoodsType
     */
    @RequestMapping("/selectAllGoodsType")
    @ResponseBody
    public List<GoodsType> selectAllGoodsType(Integer page)
    {
        page = (page - 1) * 6;
        return typeService.selectAllGoodsTypeInPage(page);
    }

    /**
     * 异步请求各种类型的总数
     *
     * @return 各种类型的总数
     */
    @RequestMapping("/selectAllCount")
    @ResponseBody
    public Map<String, Object> selectAllCount()
    {
        Map<String, Object> map = new HashMap<>();
        map.put("typeCount", typeService.selectAllTypeCount());
        map.put("categoryCount", typeService.selectAllCategoryCount());
        map.put("goodsTypeCount", typeService.selectAllGoodsTypeCount());
        return map;
    }

    /**
     * ajax根据ID删除Type并将该Type下所有Category转为默认分类
     *
     * @param id 想要删除的Type的ID
     */
    @RequestMapping("/deleteType")
    @ResponseBody
    public void deleteType(Integer id)
    {
        typeService.deleteType(id);
        typeService.updateCategoryToDefault(id);
    }

    /**
     * ajax根据ID删除Category并将该Category下的所有GoodsType转为默认分类
     *
     * @param id 想要删除的Category的ID
     */
    @RequestMapping("/deleteCategory")
    @ResponseBody
    public void deleteCategory(Integer id)
    {
        typeService.deleteCategory(id);
        typeService.updateGoodsTypeToDefault(id);
    }

    /**
     * ajax根据ID删除GoodsType
     *
     * @param id
     */
    @RequestMapping("/deleteGoodsType")
    @ResponseBody
    public void deleteGoodsType(Integer id)
    {
        typeService.deleteGoodsType(id);
    }

    /**
     * 添加Category时查询所有Type
     *
     * @return 所有的Type
     */
    @RequestMapping("/selectType")
    @ResponseBody
    public List<Type> selectType()
    {
        return typeService.selectAllType();
    }

    /**
     * 添加GoodsType时查询所有的Category
     *
     * @return 所有的Category
     */
    @RequestMapping("/selectCategory")
    @ResponseBody
    public List<Category> selectCategory()
    {
        return typeService.selectAllCategory();
    }

    /**
     * 异步请求添加Type
     *
     * @param type 想要添加的Type的名称
     */
    @RequestMapping("/insertType")
    @ResponseBody
    public void insertType(String type)
    {
        typeService.insertType(type);
    }

    /**
     * 异步请求添加Category
     *
     * @param typeId   所属Type的ID
     * @param category 想要添加的Category的名称
     */
    @RequestMapping("/insertCategory")
    @ResponseBody
    public void insertCategory(Integer typeId, String category)
    {
        typeService.insertCategory(category, typeId);
    }

    /**
     * 异步请求添加GoodsType
     *
     * @param categoryId 所属Category的ID
     * @param goodsType  想要添加的GoodsType的名称
     */
    @RequestMapping("/insertGoodsType")
    @ResponseBody
    public void insertGoodsType(Integer categoryId, String goodsType)
    {
        typeService.insertGoodsType(goodsType, categoryId);
    }

    /**
     * ajax根据TypeId查询所有下属Category
     *
     * @param id TypeId
     * @return 该Type下所有Category
     */
    @RequestMapping("/selectCategoryByTypeId")
    @ResponseBody
    public List<Category> selectAllCategoryByTypeId(Integer id)
    {
        return typeService.selectCategoryByTypeId(id);
    }

    /**
     * ajax根据CategoryId查询所有下属GoodsType
     *
     * @param id CategoryId
     * @return 该Category下所有GoodsType
     */
    @RequestMapping("/selectGoodsTypeByCategoryId")
    @ResponseBody
    public List<GoodsType> selectAllGoodsTypeByCategoryId(Integer id)
    {
        return typeService.selectAllGoodsTypeByCategoryId(id);
    }

    /**
     * 根据一级分类名称查询该分类下属商品
     *
     * @param typeName 一级分类名称
     * @return 商品列表页
     */
    @RequestMapping("/selectGoodsByType")
    public String selectGoodsByTypeName(String typeName, Model model)
    {
        model.addAttribute("goodsList", goodsService.selectAllGoodsByType(typeName));
        return "main/goodsList";
    }

    /**
     * 根据三级分类名称查询该分类下属商品
     *
     * @param goodsTypeName 三级分类名称
     * @return 商品列表页
     */
    @RequestMapping("/selectGoodsByGoodsType")
    public String selectGoodsByGoodsTypeName(String goodsTypeName, Model model)
    {
        model.addAttribute("goodsList", goodsService.selectAllGoodsByGoodsType(goodsTypeName));
        return "main/goodsList";
    }

    /**
     * 根据条件查询商品
     *
     * @param condition 用户输入的搜索条件
     * @return 商品列表页
     */
    @RequestMapping("/selectGoodsByCondition")
    public String selectGoodsByCondition(String condition, Model model)
    {
        model.addAttribute("goodsList", goodsService.selectAllGoodsByCondition(condition));
        return "main/goodsList";
    }
}
