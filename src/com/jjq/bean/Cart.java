package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Repository;

/**
 * 购物车
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cart
{
    /** 用户 */
    private User user;
    /** 商品参数 */
    private GoodsParam goodsParam;
}
