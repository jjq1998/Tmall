package com.jjq.mapper;

import com.jjq.bean.Category;
import com.jjq.bean.GoodsType;
import com.jjq.bean.Type;

import java.util.List;

public interface TypeMapper
{
    List<Type> selectAllTypeInPage(Integer page);

    List<Type> selectAllType();

    Integer selectAllTypeCount();

    void insertType(String typeName);

    void deleteType(Integer id);

    List<Category> selectAllCategoryInPage(Integer page);

    List<Category> selectAllCategory();

    List<Category> selectCategoryByTypeId(Integer typeId);

    Integer selectAllCategoryCount();

    void insertCategory(String categoryName, Integer typeId);

    void deleteCategory(Integer id);

    void updateCategoryToDefault(Integer typeId);

    List<GoodsType> selectAllGoodsTypeInPage(Integer page);

    List<GoodsType> selectAllGoodsType();

    List<GoodsType> selectAllGoodsTypeByCategoryId(Integer categoryId);

    Integer selectAllGoodsTypeCount();

    void insertGoodsType(String goodsTypeName, Integer categoryId);

    void deleteGoodsType(Integer id);

    void updateGoodsTypeToDefault(Integer categoryId);

    List<GoodsType> selectGoodsTypeByGoodsId(Integer goodsId);
}
