package com.dalbit.member.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.member.dao.Mem_BanwordDao;
import com.dalbit.member.vo.procedure.P_MemberBanwordInputVo;
import com.dalbit.member.vo.procedure.P_MemberBanwordOutputVo;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Slf4j
@Service
public class Mem_BanwordService {

    @Autowired
    Mem_BanwordDao mem_BanwordDao;
    @Autowired
    GsonUtil gsonUtil;

    public String getBanwordHistory(P_MemberBanwordInputVo pMemberBanwordInputVo){
        ArrayList<P_MemberBanwordOutputVo> banwordList = mem_BanwordDao.callBanwordHistory(pMemberBanwordInputVo);
        ArrayList<P_MemberBanwordOutputVo> list = new ArrayList<>();
        int start = pMemberBanwordInputVo.getPageStart();
        int end = pMemberBanwordInputVo.getPageCnt() + pMemberBanwordInputVo.getPageStart();

        String result;

        if(banwordList.size() > 0) {
            String[] banword = banwordList.get(0).getBan_word().split("\\|");
            if (end > banword.length) {
                end = banword.length;
            }

            if (banword.length > 0) {
                for (int i = start; i < end; i++) {
                    P_MemberBanwordOutputVo data = new P_MemberBanwordOutputVo();
                    data.setRowNum(i + 1);
                    data.setBan_word(banword[i]);
                    list.add(data);
                }
            }
            result = gsonUtil.toJson(new JsonOutputVo(Status.금지어목록보기성공, list, new PagingVo(banwordList.get(0).getCount())));
        }else{
            result = gsonUtil.toJson(new JsonOutputVo(Status.금지어목록보기실패));
        }

        return result;
    }
}
