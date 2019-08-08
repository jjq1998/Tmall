package com.jjq.mapper;

import com.jjq.bean.Shop;

import java.util.List;

public interface ShopMapper
{
    List<Shop> selectAllShop(Integer page);

    Integer selectAllShopCount();

    Shop selectShopById(Integer id);

    Shop selectShopByUserId(Integer userId);

    String selectShopState(Integer shopId);

    void insertShop(Shop shop);

    void updateShopService(String serviceOne, String serviceTwo, String serviceThree, Integer id);

    void updateShopState(String state, Integer id);

    void updateShopBrand(Integer brandId, Integer shopId);

    void deleteShopByUserId(Integer userId);

    boolean selectShopIsBrand(Integer userId);
}
