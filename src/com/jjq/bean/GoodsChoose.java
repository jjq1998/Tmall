package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 商品规格
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class GoodsChoose
{
    /** 商品规格ID */
    private int id;
    /** 所属商品ID */
    private int goodsId;
    /** 规格一 */
    private String chooseOne;
    /** 规格二 */
    private String chooseTwo;
    /** 规格三 */
    private String chooseThree;
}
