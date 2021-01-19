package com.dalbit.administrate.service;

import com.dalbit.administrate.dao.Adm_MenuDao;
import com.dalbit.administrate.vo.procedure.*;
import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.MenuVo;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

@Slf4j
@Service
public class Adm_MenuService {

    @Autowired
    Adm_MenuDao adm_MenuDao;
    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;

    /**
     * 메뉴 상세 조회
     */
    public String getMenuInfo(P_MenuInfoInputVo pMenuInfoInputVo) {
        HashMap<P_MenuInfoOutputVo,String> menuInfo = adm_MenuDao.callMenuInfo(pMenuInfoInputVo);

        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.조회, menuInfo));
        return result;
    }

    /**
     * 메뉴 등록,변경 조회
     */
    public String getMenuUpdate(MenuVo[] menuList) {
        List<MenuVo> menuVoList = Arrays.asList(menuList);

        int tmp_1Depth_order = 0;
        int tmp_2Depth_order = 0;
        for(int i=0;i<menuVoList.size();i++){
            P_MenuUpdateInputVo inputVo = new P_MenuUpdateInputVo();
            inputVo.setIdx(menuVoList.get(i).getId());              // 새로 추가된 node 값이 string임
            inputVo.setMenu_name(menuVoList.get(i).getText());
            if(menuVoList.get(i).getParent().equals("#")){
                ++tmp_1Depth_order;
                inputVo.setDepth(1);
                inputVo.setParent_idx(0);
                inputVo.setOrderNo(tmp_1Depth_order);
            }else{
                ++tmp_2Depth_order;
                inputVo.setDepth(2);
                inputVo.setParent_idx(Integer.parseInt(menuVoList.get(i).getParent()));
                inputVo.setOrderNo(tmp_2Depth_order);
            }

            int menuSel  = adm_MenuDao.callMenuSel(inputVo);
            if(menuSel > 0){
                //update
                int menuInfo = adm_MenuDao.callMenuUpdate(inputVo);
            }else{
                //insert
                int menuInfo = adm_MenuDao.callMenuInsert(inputVo);

            }
        }
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.수정));
        return result;
    }

    /**
     * 메뉴 정보 변경 조회
     */
    public String getMenuInfoUpdate(P_MenuInfoUpdateInputVo pMenuInfoUpdateInputVo) {
        adm_MenuDao.callMenuInfoUpdate(pMenuInfoUpdateInputVo);
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.수정));
        return result;
    }
    /**
     * 메뉴 삭제
     */
    public String getMenuDelete(P_MenuDeleteInputVo pMenuDeleteInputVo) {
        adm_MenuDao.callMenuDelete(pMenuDeleteInputVo);
        String result;
        result = gsonUtil.toJson(new JsonOutputVo(Status.삭제));
        return result;
    }
}
