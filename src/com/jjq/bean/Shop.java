package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;

/**
 * 店铺
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Shop
{
    /** 店铺ID */
    private int id;
    /** 店长 */
    private User user;
    /** 店铺名称 */
    private String name;
    /** 店铺描述评分 */
    private int descriptionMark;
    /** 店铺物流评分 */
    private int streamMark;
    /** 店铺服务评分 */
    private int serviceMark;
    /** 店铺建立时间 */
    private Timestamp time;
    /** 店铺状态 */
    private String state;
    /** 店铺图片 */
    private String image;
    /** 客服一用户名 */
    private String serviceOne;
    /** 客服二用户名 */
    private String serviceTwo;
    /** 客服三用户名 */
    private String serviceThree;
    /** 所属品牌ID */
    private int brandId;
}
