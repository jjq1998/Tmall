package com.jjq.service.impl;

import com.jjq.bean.Ask;
import com.jjq.mapper.AskMapper;
import com.jjq.service.AskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AskServiceImpl implements AskService
{
    @Autowired
    AskMapper askMapper;

    @Override
    public void insertAsk(Ask ask)
    {
        askMapper.insertAsk(ask);
    }

    @Override
    public void insertBrandAsk(Ask ask)
    {
        askMapper.insertBrandAsk(ask);
    }

    @Override
    public List<Ask> selectAllAskByUserId(Integer userId, Integer page)
    {
        page = (page - 1) * 10;
        return askMapper.selectAllAskByUserId(userId, page);
    }

    @Override
    public List<Ask> selectAllAskByType(String type, Integer page)
    {
        page = (page - 1) * 10;
        return askMapper.selectAllAskByType(type, page);
    }

    @Override
    public boolean selectOpenShopAskIsExistByUserId(Integer userId)
    {
        return askMapper.selectOpenShopAskIsExistByUserId(userId);
    }

    @Override
    public boolean selectBrandAskIsExistByUserId(Integer userId)
    {
        return askMapper.selectBrandAskIsExistByUserId(userId);
    }

    @Override
    public void deleteOpenShopAskByUserId(Integer userId)
    {
        askMapper.deleteOpenShopAskByUserId(userId);
    }

    @Override
    public void deleteBrandAskByUserId(Integer userId)
    {
        askMapper.deleteBrandAskByUserId(userId);
    }

    @Override
    public Ask selectAskByAskId(Integer askId)
    {
        return askMapper.selectAskByAskId(askId);
    }

    @Override
    public Integer selectTotalPageByUserId(Integer userId)
    {
        int totalCount = askMapper.selectAskCountByUserId(userId);
        int totalPage = totalCount / 10;
        if (totalCount % 10 != 0)
            totalPage++;
        return totalPage;
    }

    @Override
    public Integer selectTotalCountByType(String type)
    {
        return askMapper.selectAskCountByType(type);
    }

    @Override
    public void updateAskState(Integer askId, String state)
    {
        askMapper.updateAskState(askId, state);
    }

    @Override
    public void updateAskAdmin(String admin, Integer id)
    {
        askMapper.updateAskAdmin(admin, id);
    }

    @Override
    public Ask selectBrandAskByUserId(Integer userId)
    {
        return askMapper.selectBrandAskByUserId(userId);
    }

}
