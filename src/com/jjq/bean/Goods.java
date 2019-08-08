package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 商品
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Goods
{
    /** 商品ID */
    private int id;
    /** 所属店铺 */
    private Shop shop;
    /** 商品名称 */
    private String name;
    /** 商品细节 */
    private String details;
    /** 商品详情（介绍） */
    private String description;
    /** 商品图片 */
    private String image;
    /** 销售量 */
    private int salesCount;
    /** 商品状态 */
    private String state;
    /** 商品价格 */
    private int price;
    /** 商品所属分类 */
    private List<GoodsType> goodsTypes;
    /** 商品规格 */
    private GoodsChoose goodsChoose;
    /** 商品参数 */
    private List<GoodsParam> goodsParams;
}
