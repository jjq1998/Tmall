package com.jjq.mapper;

import com.jjq.bean.Goods;
import com.jjq.bean.GoodsChoose;
import com.jjq.bean.GoodsParam;
import com.jjq.bean.GoodsSlide;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsMapper
{
    void insertNewGoods(Goods goods);

    void insertGoodsTypeByGoodsId(Integer goodsId, @Param("goodsTypes") Integer[] goodsTypes);

    void deleteGoodsByGoodsId(Integer goodsId);

    void deleteGoodsTypeByGoodsId(Integer goodsId);

    void updateGoodsState(Integer goodsId, String state);

    void updateGoodsSaleCount(Integer goodsId);

    void updateGoodsByGoodsId(Goods goods);

    List<Goods> selectAllGoodsByType(String type);

    List<Goods> selectAllGoodsByGoodsType(String goodsType);

    List<Goods> selectAllGoodsByCondition(String condition);

    List<Goods> selectAllGoodsByShopId(Integer shopId);

    Goods selectGoodsByGoodsId(Integer goodsId);

    GoodsChoose selectGoodsChooseByGoodsId(Integer goodsId);

    List<GoodsParam> selectGoodsParamByGoodsId(Integer goodsId);

    void insertGoodsChoose(GoodsChoose goodsChoose);

    void updateGoodsChoose(GoodsChoose goodsChoose);

    void insertGoodsParam(@Param("goodsParam") GoodsParam goodsParam, Integer goodsChooseId);

    void deleteGoodsChooseByGoodsId(Integer goodsId);

    void deleteGoodsParamByParamId(Integer paramId);

    List<GoodsSlide> selectGoodsSlideByGoodsId(Integer goodsId);

    void insertGoodsSlide(GoodsSlide goodsSlide);

    void deleteGoodsSlideByGoodsId(Integer goodsId);
}
