package com.jjq.mapper;

import com.jjq.bean.Brand;

import java.util.List;

public interface BrandMapper
{
    List<Brand> selectBrandByTypeName(String typeName);

    List<Brand> selectAllBrand(Integer page);

    Brand selectByBrandId(Integer brandId);

    Brand selectBrandByShopId(Integer shopId);

    void insertBrand(Brand brand);

    boolean selectBrandIsExist(String brandName);
}
