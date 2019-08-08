package com.jjq.service;

import com.jjq.bean.Ask;

import java.util.List;

public interface AskService
{
    void insertAsk(Ask ask);

    void insertBrandAsk(Ask ask);

    List<Ask> selectAllAskByUserId(Integer userId, Integer page);

    List<Ask> selectAllAskByType(String type, Integer page);

    boolean selectOpenShopAskIsExistByUserId(Integer userId);

    boolean selectBrandAskIsExistByUserId(Integer userId);

    void deleteOpenShopAskByUserId(Integer userId);

    void deleteBrandAskByUserId(Integer userId);

    Ask selectAskByAskId(Integer askId);

    Integer selectTotalPageByUserId(Integer userId);

    Integer selectTotalCountByType(String type);

    void updateAskState(Integer askId, String state);

    void updateAskAdmin(String admin, Integer id);

    Ask selectBrandAskByUserId(Integer userId);
}
