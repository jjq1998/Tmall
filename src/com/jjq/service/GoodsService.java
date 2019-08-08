package com.jjq.service;

import com.jjq.bean.Goods;
import com.jjq.bean.GoodsChoose;
import com.jjq.bean.GoodsParam;
import com.jjq.bean.GoodsSlide;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GoodsService
{
    /**
     * 添加新商品
     * @param goods 商品信息
     */
    void insertNewGoods(Goods goods);

    /**
     * 添加商品类型
     * @param goodsId 商品ID
     * @param goodsTypes 商品类型的数组
     */
    void insertGoodsTypeByGoodsId(Integer goodsId, Integer[] goodsTypes);

    /**
     * 根据商品ID删除商品
     * @param goodsId 商品ID
     */
    void deleteGoodsByGoodsId(Integer goodsId);

    /**
     * 根据商品ID删除商品所有分类
     * @param goodsId 商品ID
     */
    void deleteGoodsTypeByGoodsId(Integer goodsId);

    /**
     * 更改商品状态
     * @param goodsId 商品ID
     * @param state 商品状态
     */
    void updateGoodsState(Integer goodsId, String state);

    /**
     * 更改商品销售量
     * @param goodsId 商品ID
     */
    void updateGoodsSaleCount(Integer goodsId);

    /**
     * 更改商品信息
     * @param goods 商品实体类
     */
    void updateGoodsByGoodsId(Goods goods);

    /**
     * 根据Type查询商品类型
     * @param type TypeName
     * @return 该Type下的商品
     */
    List<Goods> selectAllGoodsByType(String type);

    /**
     * 根据GoodsType查询商品
     * @param goodsType goodsTypeName
     * @return 该GoodsType下的商品
     */
    List<Goods> selectAllGoodsByGoodsType(String goodsType);

    /**
     * 根据查询条件查询所有可能符合的商品
     * @param condition 查询条件
     * @return Type，Category，GoodsType，GoodsName中符合条件的商品
     */
    List<Goods> selectAllGoodsByCondition(String condition);

    /**
     * 根据店铺ID查询商品
     * @param shopId 店铺ID
     * @return 该店铺所有商品
     */
    List<Goods> selectAllGoodsByShopId(Integer shopId);

    /**
     * 根据商品ID查询商品
     * @param goodsId 商品ID
     * @return 该商品信息
     */
    Goods selectGoodsByGoodsId(Integer goodsId);

    /**
     * 根据商品ID查询商品规格信息
     * @param goodsId 商品ID
     * @return 该商品的规格信息
     */
    GoodsChoose selectGoodsChooseByGoodsId(Integer goodsId);

    /**
     * 根据商品ID查询该商品下所有配置
     * @param goodsId 商品ID
     * @return 商品下的所有可选配置
     */
    List<GoodsParam> selectGoodsParamByGoodsId(Integer goodsId);

    /**
     * 插入商品规格
     * @param goodsChoose 商品规格
     */
    void insertGoodsChoose(GoodsChoose goodsChoose);

    /**
     * 插入商品配置
     * @param goodsParam 商品配置
     * @param goodsChooseId 所属商品规格信息ID
     */
    void insertGoodsParam(GoodsParam goodsParam, Integer goodsChooseId);

    /**
     * 根据商品ID删除该商品的规格信息
     * @param goodsId 商品ID
     */
    void deleteGoodsChooseByGoodsId(Integer goodsId);

    /**
     * 更改商品可选参数
     * @param goodsChoose 可选参数实体类
     */
    void updateGoodsChoose(GoodsChoose goodsChoose);

    /**
     * 根据商品配置ID删除该商品配置
     * @param paramId 商品配置ID
     */
    void deleteGoodsParamByParamId(Integer paramId);

    /**
     * 根据商品ID查询轮播图
     * @param goodsId 商品ID
     * @return 该商品的轮播图
     */
    List<GoodsSlide> selectGoodsSlideByGoodsId(Integer goodsId);

    /**
     * 添加轮播图
     * @param goodsSlide 轮播图
     */
    void insertGoodsSlide(GoodsSlide goodsSlide);

    /**
     * 根据商品ID删除轮播图
     * @param goodsId 商品ID
     */
    void deleteGoodsSlideByGoodsId(Integer goodsId);
}
