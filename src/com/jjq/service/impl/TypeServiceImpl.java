package com.jjq.service.impl;

import com.jjq.bean.Category;
import com.jjq.bean.GoodsType;
import com.jjq.bean.Type;
import com.jjq.mapper.TypeMapper;
import com.jjq.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeServiceImpl implements TypeService
{
    @Autowired
    TypeMapper typeMapper;

    @Override
    public List<Type> selectAllTypeInPage(Integer page)
    {
        return typeMapper.selectAllTypeInPage(page);
    }

    @Override
    public List<Type> selectAllType()
    {
        return typeMapper.selectAllType();
    }

    @Override
    public Integer selectAllTypeCount()
    {
        return typeMapper.selectAllTypeCount();
    }

    @Override
    public void insertType(String typeName)
    {
        typeMapper.insertType(typeName);
    }

    @Override
    public void deleteType(Integer id)
    {
        typeMapper.deleteType(id);
    }

    @Override
    public List<Category> selectAllCategoryInPage(Integer page)
    {
        return typeMapper.selectAllCategoryInPage(page);
    }

    @Override
    public List<Category> selectAllCategory()
    {
        return typeMapper.selectAllCategory();
    }

    @Override
    public List<Category> selectCategoryByTypeId(Integer typeId)
    {
        return typeMapper.selectCategoryByTypeId(typeId);
    }

    @Override
    public Integer selectAllCategoryCount()
    {
        return typeMapper.selectAllCategoryCount();
    }

    @Override
    public void insertCategory(String categoryName, Integer typeId)
    {
        typeMapper.insertCategory(categoryName, typeId);
    }

    @Override
    public void deleteCategory(Integer id)
    {
        typeMapper.deleteCategory(id);
    }

    @Override
    public void updateCategoryToDefault(Integer id)
    {
        typeMapper.updateCategoryToDefault(id);
    }

    @Override
    public List<GoodsType> selectAllGoodsTypeInPage(Integer page)
    {
        return typeMapper.selectAllGoodsTypeInPage(page);
    }

    @Override
    public List<GoodsType> selectAllGoodsType()
    {
        return typeMapper.selectAllGoodsType();
    }

    @Override
    public List<GoodsType> selectAllGoodsTypeByCategoryId(Integer categoryId)
    {
        return typeMapper.selectAllGoodsTypeByCategoryId(categoryId);
    }

    @Override
    public Integer selectAllGoodsTypeCount()
    {
        return typeMapper.selectAllGoodsTypeCount();
    }

    @Override
    public void insertGoodsType(String goodsTypeName, Integer categoryId)
    {
        typeMapper.insertGoodsType(goodsTypeName, categoryId);
    }

    @Override
    public void deleteGoodsType(Integer id)
    {
        typeMapper.deleteGoodsType(id);
    }

    @Override
    public void updateGoodsTypeToDefault(Integer id)
    {
        typeMapper.updateGoodsTypeToDefault(id);
    }
}
