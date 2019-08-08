package com.jjq.service.impl;

import com.jjq.bean.Shop;
import com.jjq.mapper.ShopMapper;
import com.jjq.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShopServiceImpl implements ShopService
{
    @Autowired
    ShopMapper shopMapper;

    @Override
    public List<Shop> selectAllShop(Integer page)
    {
        return shopMapper.selectAllShop(page);
    }

    @Override
    public Integer selectShopCount()
    {
        return shopMapper.selectAllShopCount();
    }

    @Override
    public Shop selectShopById(Integer id)
    {
        return shopMapper.selectShopById(id);
    }

    @Override
    public Shop selectShopByUserId(Integer userId)
    {
        return shopMapper.selectShopByUserId(userId);
    }

    @Override
    public void insertShop(Shop shop)
    {
        shopMapper.insertShop(shop);
    }

    @Override
    public void updateShopService(String serviceOne, String serviceTwo, String serviceThree, Integer id)
    {
        shopMapper.updateShopService(serviceOne, serviceTwo, serviceThree, id);
    }

    @Override
    public void updateShopBrand(Integer brandId, Integer shopId)
    {
        shopMapper.updateShopBrand(brandId, shopId);
    }

    @Override
    public void updateShopState(String state, Integer id)
    {
        shopMapper.updateShopState(state, id);
    }

    @Override
    public void deleteShopByUserId(Integer userId)
    {
        shopMapper.deleteShopByUserId(userId);
    }

    @Override
    public String selectShopState(Integer shopId)
    {
        return shopMapper.selectShopState(shopId);
    }

    @Override
    public boolean selectShopIsBrand(Integer userId)
    {
        return shopMapper.selectShopIsBrand(userId);
    }
}
