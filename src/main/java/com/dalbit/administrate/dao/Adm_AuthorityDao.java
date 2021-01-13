package com.dalbit.administrate.dao;

import com.dalbit.common.vo.MenuAuthVo;
import com.dalbit.common.vo.MenuVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface Adm_AuthorityDao {

    void deleteMenuAuth(String empNo);
    void deleteMenuAuthByMenuIdx(int menuIdx);
    void insertMenuAuth(MenuAuthVo menuAuthVo);
    @Transactional(readOnly = true)
    List<MenuVo> getMemberAuthInfo(String empNo);
    List<MenuVo> getMenuAuthInfo(int menuIdx);
    int getMemberAuthCnt(String empNo);
    int getTestIdCnt(String empNo);
}
