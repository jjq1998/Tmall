package com.jjq.mapper;

import com.jjq.bean.Ask;

import java.util.List;

public interface AskMapper
{
    void insertAsk(Ask ask);

    void insertBrandAsk(Ask ask);

    List<Ask> selectAllAskByUserId(Integer userId, Integer page);

    List<Ask> selectAllAskByType(String type, Integer page);

    boolean selectOpenShopAskIsExistByUserId(Integer userId);

    boolean selectBrandAskIsExistByUserId(Integer userId);

    void deleteOpenShopAskByUserId(Integer userId);

    void deleteBrandAskByUserId(Integer userId);

    Integer selectAskCountByUserId(Integer userId);

    Integer selectAskCountByType(String type);

    Ask selectAskByAskId(Integer askId);

    void updateAskState(Integer askId, String state);

    void updateAskAdmin(String admin, Integer id);

    Ask selectBrandAskByUserId(Integer userId);
}
