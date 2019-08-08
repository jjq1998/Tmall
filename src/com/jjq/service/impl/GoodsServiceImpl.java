package com.jjq.service.impl;

import com.jjq.bean.Goods;
import com.jjq.bean.GoodsChoose;
import com.jjq.bean.GoodsParam;
import com.jjq.bean.GoodsSlide;
import com.jjq.mapper.GoodsMapper;
import com.jjq.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService
{
    @Autowired
    GoodsMapper goodsMapper;

    @Override
    public void insertNewGoods(Goods goods)
    {
        goodsMapper.insertNewGoods(goods);
    }

    @Override
    public void insertGoodsTypeByGoodsId(Integer goodsId, Integer[] goodsTypes)
    {
        goodsMapper.insertGoodsTypeByGoodsId(goodsId, goodsTypes);
    }

    @Override
    public void deleteGoodsByGoodsId(Integer goodsId)
    {
        goodsMapper.deleteGoodsByGoodsId(goodsId);
    }

    @Override
    public void deleteGoodsTypeByGoodsId(Integer goodsId)
    {
        goodsMapper.deleteGoodsTypeByGoodsId(goodsId);
    }

    @Override
    public void updateGoodsState(Integer goodsId, String state)
    {
        goodsMapper.updateGoodsState(goodsId, state);
    }

    @Override
    public void updateGoodsSaleCount(Integer goodsId)
    {
        goodsMapper.updateGoodsSaleCount(goodsId);
    }

    @Override
    public void updateGoodsByGoodsId(Goods goods)
    {
        goodsMapper.updateGoodsByGoodsId(goods);
    }

    @Override
    public List<Goods> selectAllGoodsByType(String type)
    {
        return goodsMapper.selectAllGoodsByType(type);
    }

    @Override
    public List<Goods> selectAllGoodsByGoodsType(String goodsType)
    {
        return goodsMapper.selectAllGoodsByGoodsType(goodsType);
    }

    @Override
    public List<Goods> selectAllGoodsByCondition(String condition)
    {
        return goodsMapper.selectAllGoodsByCondition(condition);
    }

    @Override
    public List<Goods> selectAllGoodsByShopId(Integer shopId)
    {
        return goodsMapper.selectAllGoodsByShopId(shopId);
    }

    @Override
    public Goods selectGoodsByGoodsId(Integer goodsId)
    {
        return goodsMapper.selectGoodsByGoodsId(goodsId);
    }

    @Override
    public GoodsChoose selectGoodsChooseByGoodsId(Integer goodsId)
    {
        return goodsMapper.selectGoodsChooseByGoodsId(goodsId);
    }

    @Override
    public List<GoodsParam> selectGoodsParamByGoodsId(Integer goodsId)
    {
        return goodsMapper.selectGoodsParamByGoodsId(goodsId);
    }

    @Override
    public void insertGoodsChoose(GoodsChoose goodsChoose)
    {
        goodsMapper.insertGoodsChoose(goodsChoose);
    }

    @Override
    public void insertGoodsParam(GoodsParam goodsParam, Integer goodsChooseId)
    {
        goodsMapper.insertGoodsParam(goodsParam, goodsChooseId);
    }

    @Override
    public void deleteGoodsChooseByGoodsId(Integer goodsId)
    {
        goodsMapper.deleteGoodsChooseByGoodsId(goodsId);
    }

    @Override
    public void updateGoodsChoose(GoodsChoose goodsChoose)
    {
        goodsMapper.updateGoodsChoose(goodsChoose);
    }

    @Override
    public void deleteGoodsParamByParamId(Integer paramId)
    {
        goodsMapper.deleteGoodsParamByParamId(paramId);
    }

    @Override
    public List<GoodsSlide> selectGoodsSlideByGoodsId(Integer goodsId)
    {
        return goodsMapper.selectGoodsSlideByGoodsId(goodsId);
    }

    @Override
    public void insertGoodsSlide(GoodsSlide goodsSlide)
    {
        goodsMapper.insertGoodsSlide(goodsSlide);
    }

    @Override
    public void deleteGoodsSlideByGoodsId(Integer goodsId)
    {
        goodsMapper.deleteGoodsSlideByGoodsId(goodsId);
    }
}
