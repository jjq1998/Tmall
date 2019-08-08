package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

/**
 * 商品参数
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class GoodsParam
{
    /** 商品参数ID */
    private int id;
    /** 参数一 */
    private String paramOne;
    /** 参数二 */
    private String paramTwo;
    /** 参数三 */
    private String paramThree;
    /** 价格 */
    private int price;
    /** 剩余库存 */
    private int inventory;
}
