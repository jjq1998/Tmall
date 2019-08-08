package com.jjq.service;

import com.jjq.bean.Category;
import com.jjq.bean.GoodsType;
import com.jjq.bean.Type;

import java.util.List;

public interface TypeService
{
    /**
     * 分页查询所有Type
     * @param page 当前页数
     * @return 当前页数所有Type
     */
    List<Type> selectAllTypeInPage(Integer page);

    /**
     * 查询所有Type
     * @return 所有的Type
     */
    List<Type> selectAllType();

    /**
     * 查询所有Type数量
     * @return 所有Type的数量
     */
    Integer selectAllTypeCount();

    /**
     * 添加新的Type
     * @param typeName Type名称
     */
    void insertType(String typeName);

    /**
     *根据TypeId删除Type
     * @param id TypeId
     */
    void deleteType(Integer id);

    /**
     * 分页查询所有Category
     * @param page 当前页数
     * @return 该页所有Category
     */
    List<Category> selectAllCategoryInPage(Integer page);

    /**
     * 查询所有的Category
     * @return 所有的Category
     */
    List<Category> selectAllCategory();

    /**
     * 根据TypeId查询所有Category
     * @param typeId
     * @return 该Type下的所有Category
     */
    List<Category> selectCategoryByTypeId(Integer typeId);

    /**
     * 查询所有Category数量
     * @return 所有Category的数量
     */
    Integer selectAllCategoryCount();

    /**
     * 添加Category
     * @param categoryName Category名称
     * @param typeId 所属Type的Id
     */
    void insertCategory(String categoryName, Integer typeId);

    /**
     * 根据id删除Category
     * @param id 想要删除的Category的Id
     */
    void deleteCategory(Integer id);

    /**
     * 更改Category所属Type为默认Type
     * @param id 想要更改的Category的id
     */
    void updateCategoryToDefault(Integer id);

    /**
     * 分页查询所有GoodsType
     * @param page 当前页数
     * @return 当前页数所有的GoodsType
     */
    List<GoodsType> selectAllGoodsTypeInPage(Integer page);

    /**
     * 查询所有的GoodsType
     * @return 所有的GoodsType
     */
    List<GoodsType> selectAllGoodsType();

    /**
     * 根据CategoryId查询所有GoodsType
     * @param categoryId
     * @return 该Category下的所有GoodsType
     */
    List<GoodsType> selectAllGoodsTypeByCategoryId(Integer categoryId);

    /**
     * 查询所有GoodsType数量
     * @return 所有GoodsType的数量
     */
    Integer selectAllGoodsTypeCount();

    /**
     *添加GoodsType
     * @param goodsTypeName GoodsTypeName
     * @param categoryId 所属Category的id
     */
    void insertGoodsType(String goodsTypeName, Integer categoryId);

    /**
     * 根据ID删除GoodsType
     * @param id 想要删除的GoodsType的id
     */
    void deleteGoodsType(Integer id);

    /**
     * 将GoodsType所属的Category变更为默认Category
     * @param id 想要修改的GoodsType的ID
     */
    void updateGoodsTypeToDefault(Integer id);
}
