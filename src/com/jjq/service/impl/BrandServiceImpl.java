package com.jjq.service.impl;

import com.jjq.bean.Brand;
import com.jjq.mapper.BrandMapper;
import com.jjq.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandServiceImpl implements BrandService
{
    @Autowired
    BrandMapper brandMapper;

    @Override
    public List<Brand> selectBrandByTypeName(String typeName)
    {
        return brandMapper.selectBrandByTypeName(typeName);
    }

    @Override
    public List<Brand> selectAllBrand(Integer page)
    {
        page = (page - 1) * 10;
        return brandMapper.selectAllBrand(page);
    }

    @Override
    public Brand selectByBrandId(Integer brandId)
    {
        return brandMapper.selectByBrandId(brandId);
    }

    @Override
    public Brand selectBrandByShopId(Integer shopId)
    {
        return brandMapper.selectBrandByShopId(shopId);
    }

    @Override
    public void insertBrand(Brand brand)
    {
        brandMapper.insertBrand(brand);
    }

    @Override
    public boolean selectBrandIsExist(String brandName)
    {
        return brandMapper.selectBrandIsExist(brandName);
    }
}
