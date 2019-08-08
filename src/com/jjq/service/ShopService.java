package com.jjq.service;

import com.jjq.bean.Shop;

import java.util.List;

public interface ShopService
{
    List<Shop> selectAllShop(Integer page);

    Integer selectShopCount();

    Shop selectShopById(Integer id);

    Shop selectShopByUserId(Integer userId);

    void insertShop(Shop shop);

    void updateShopService(String serviceOne, String serviceTwo, String serviceThree, Integer id);

    void updateShopBrand(Integer brandId, Integer shopId);

    void updateShopState(String state, Integer id);

    void deleteShopByUserId(Integer userId);

    String selectShopState(Integer shopId);

    boolean selectShopIsBrand(Integer userId);
}
