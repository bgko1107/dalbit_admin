package com.dalbit.customer.service;

import com.dalbit.common.code.Status;
import com.dalbit.common.vo.JsonOutputVo;
import com.dalbit.common.vo.PagingVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.customer.dao.Cus_BlockAdmDao;
import com.dalbit.customer.vo.BlockAdmVo;
import com.dalbit.member.dao.Mem_MemberDao;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.P_MemberReportVo;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Slf4j
@Service
public class Cus_BlockAdmService {

    @Autowired
    GsonUtil gsonUtil;

    @Autowired
    Cus_BlockAdmDao cusBlockAdmDao;

    @Autowired
    Mem_MemberDao mem_MemberDao;

    /**
     * 차단 회원 내역 조회
     */
    public String selectBlockList(BlockAdmVo blockAdmVo) {
        int count = cusBlockAdmDao.selectBlockListCnt(blockAdmVo);
        ArrayList<BlockAdmVo> list = cusBlockAdmDao.selectBlockList(blockAdmVo);
        blockAdmVo.setTotalCnt(count);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(blockAdmVo.getTotalCnt(), blockAdmVo.getPageStart(), blockAdmVo.getPageCnt())));
    }

    /**
     * 차단 내역 메시지 상세보기
     */
    public String selectBlockDetail(BlockAdmVo blockAdmVo) {
        BlockAdmVo blockDetail = cusBlockAdmDao.selectBlockDetail(blockAdmVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, blockDetail));
    }

    /**
     * IP/Uuid 차단 (Modal)
     */
    public String insertBlock(BlockAdmVo blockAdmVo) {
        blockAdmVo.setOp_name(MemberVo.getMyMemNo());

        blockAdmVo.setEdit_type(0);
        if(blockAdmVo.getRadioBlock() == 1) {
            blockAdmVo.setEdit_contents("deviceUuid 차단 등록 : " + blockAdmVo.getBlock_text());

        } else if(blockAdmVo.getRadioBlock() == 2){
            blockAdmVo.setEdit_contents("ip 차단 등록 : " + blockAdmVo.getBlock_text());

        } else if(blockAdmVo.getRadioBlock() == 3){
            blockAdmVo.setEdit_contents("회원번호 차단 등록 : " + blockAdmVo.getBlock_text());

            P_MemberReportVo memo = new P_MemberReportVo();
            memo.setMemo(blockAdmVo.getAdminMemo());
            memo.setOpName(MemberVo.getMyMemNo());
            memo.setMem_no(blockAdmVo.getBlock_text());
            ProcedureVo procedureVo = new ProcedureVo(memo);
            mem_MemberDao.callMemAdminMemoAdd(procedureVo);
        } else if(blockAdmVo.getRadioBlock() == 4){
            blockAdmVo.setEdit_contents("휴대폰번호 차단 등록 : " + blockAdmVo.getBlock_text());
        }

        int result = 0;
        if(!DalbitUtil.isEmpty(blockAdmVo.getBlock_text())){
            cusBlockAdmDao.insertBlockHistory(blockAdmVo);
            result = cusBlockAdmDao.insertBlock(blockAdmVo);
        }


        if(result > 0) {
            return gsonUtil.toJson(new JsonOutputVo(Status.회원ipUuid차단_성공));
        } else {
            return gsonUtil.toJson(new JsonOutputVo(Status.회원ipUuid차단_실패));
        }
    }

    /**
     * 차단 내역 삭제 (차단 해지)
     */
    public String deleteBlock(BlockAdmVo blockAdmVo) {
        blockAdmVo.setOp_name(MemberVo.getMyMemNo());

        int sucCnt = 0;
        int failCnt = 0;

        String[] idxs = blockAdmVo.getBlockIdxs().split(",");
        for(int i=0; i<idxs.length; i++) {

            if(!DalbitUtil.isEmpty(idxs[i])){
                // rd_admin.tb_login_block_history에 insert하기 위함
                BlockAdmVo history = blockInfo(idxs[i]);
                String temp_blockType = "";
                if(history.getBlock_type() == 1) {
                    temp_blockType = "deviceUuid";
                } else if(history.getBlock_type() == 2) {
                    temp_blockType = "ip";
                } else if(history.getBlock_type() == 3) {
                    temp_blockType = "회원번호";
                }
                blockAdmVo.setEdit_contents(temp_blockType + " 차단 해지 : " + history.getBlock_text());
                blockAdmVo.setEdit_type(1);
                if(!DalbitUtil.isEmpty(history.getReport_idx())) {
                    blockAdmVo.setReport_idx(history.getReport_idx());
                }
                blockAdmVo.setBlockIdx(Integer.parseInt(idxs[i]));
                blockAdmVo.setMem_no(history.getMem_no());

                cusBlockAdmDao.insertDelBlockHistory(blockAdmVo);

                // rd_admin.tb_login_block에서 delete하기 위함
                blockAdmVo.setIdx(idxs[i]);

                int status = cusBlockAdmDao.deleteBlock(blockAdmVo);
                if(status > 0) {
                    sucCnt++;
                } else {
                    failCnt++;
                }
            }
        }
        HashMap resultMap = new HashMap();
        resultMap.put("sucCnt", sucCnt);
        resultMap.put("failCnt", failCnt);

        if(sucCnt > 0) {
             return gsonUtil.toJson(new JsonOutputVo(Status.회원ipUuid차단해지_성공, resultMap));
        } else {
            return gsonUtil.toJson(new JsonOutputVo(Status.회원ipUuid차단해지_실패, resultMap));
        }
    }

    /**
     * 간편 조회
     */
    public BlockAdmVo blockInfo(String idx) {
        BlockAdmVo info = cusBlockAdmDao.selectBlockInfo(idx);
        return info;
    }

    /**
     * 로그인 차단/해지 내역 조회
     */
    public String selectBlockHistList(BlockAdmVo blockAdmVo) {
        int count = cusBlockAdmDao.selectBlockHistListCnt(blockAdmVo);
        ArrayList<BlockAdmVo> list = cusBlockAdmDao.selectBlockHistList(blockAdmVo);
        blockAdmVo.setTotalCnt(count);

        return gsonUtil.toJson(new JsonOutputVo(Status.조회, list, new PagingVo(blockAdmVo.getTotalCnt(), blockAdmVo.getPageStart(), blockAdmVo.getPageCnt())));
    }

    /**
     * 차단 운영자 메모
     */
    public String selectAdminMemo(BlockAdmVo blockAdmVo) {
        BlockAdmVo blockDetail = cusBlockAdmDao.selectAdminMemo(blockAdmVo);
        return gsonUtil.toJson(new JsonOutputVo(Status.조회, blockDetail));
    }

    /**
     * 차단 운영자 메모 등록/수정
     */
    public String adminMemoIns(BlockAdmVo blockAdmVo) {
        blockAdmVo.setOpName(MemberVo.getMyMemNo());
        try {
            if ("".equals(blockAdmVo.getIdx())) {
                cusBlockAdmDao.adminMemoIns(blockAdmVo);
            } else {
                cusBlockAdmDao.adminMemoUpd(blockAdmVo);
            }
            return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
        }catch (Exception e){
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }

    }

    /**
     * 차단 운영자 메모 삭제
     */
    public String adminMemoDel(BlockAdmVo blockAdmVo) {
        try {
            cusBlockAdmDao.adminMemoDel(blockAdmVo);
            return gsonUtil.toJson(new JsonOutputVo(Status.처리완료));
        }catch (Exception e){
            return gsonUtil.toJson(new JsonOutputVo(Status.비즈니스로직오류));
        }
    }
}
