package com.dalbit.menu.vo.procedure;

import com.dalbit.menu.vo.MainDjRankingVo;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

import javax.servlet.http.HttpServletRequest;

@Getter @Setter
public class P_MainDjRankingVo {

    public P_MainDjRankingVo(){}
    public P_MainDjRankingVo(MainDjRankingVo mainDjRankingVo, HttpServletRequest request){
        int pageNo = DalbitUtil.isEmpty(mainDjRankingVo.getPage()) ? 1 : mainDjRankingVo.getPage();
        int pageCnt = DalbitUtil.isEmpty(mainDjRankingVo.getRecords()) ? 10 : mainDjRankingVo.getRecords();

        setMemLogin(0);
        setMem_no(DalbitUtil.getProperty("temp.memNo"));
        setSlct_type(mainDjRankingVo.getRankType());
        setPageNo(pageNo);
        setPageCnt(pageCnt);
    }

    /* Input */
    private int memLogin;
    private String mem_no;
    private Integer slct_type;
    private int pageNo;
    private int pageCnt;

    /* Output */
    private int rank;
    private String up_down;
    private String nickName;
    private String memId;
    private String memSex;
    private String profileImage;
    private int level;
    private String grade;
    private int goodCount;
    private int listenerCount;
}
