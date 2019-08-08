package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class GoodsSlide
{
    /** 轮播图ID */
    private int id;
    /** 所属商品ID */
    private int goodsId;
    /** 轮播图名称 */
    private String imageUrl;
}
