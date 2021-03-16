package com.dalbit.member.dao;

import com.dalbit.broadcast.vo.procedure.P_BroadcastEditHistOutputVo;
import com.dalbit.common.vo.ProcedureVo;
import com.dalbit.member.vo.LoginBlockHistVo;
import com.dalbit.member.vo.LoginBlockVo;
import com.dalbit.member.vo.LoginHistoryVo;
import com.dalbit.member.vo.MemberVo;
import com.dalbit.member.vo.procedure.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Repository
public interface Mem_MemberDao {

    @Transactional(readOnly = true)
    ProcedureVo callMemberLogin(ProcedureVo procedureVo);

    //@Transactional(readOnly = true)
    ArrayList<P_MemberListOutputVo> callMemberList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    P_MemberInfoOutputVo callMemberInfo(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    P_MemberInfoOutputVo callMemberCertification(P_MemberInfoInputVo pMemberInfoInputVo);

    @Transactional(readOnly = true)
    P_MemberInfoOutputVo callMemberCertificationBak(P_MemberInfoInputVo pMemberInfoInputVo);

    @Transactional(readOnly = true)
    P_MemberInfoOutputVo callMemberTestId(P_MemberInfoInputVo pMemberInfoInputVo);

    @Transactional(readOnly = true)
    P_MemberInfoOutputVo callMemberRoom(P_MemberInfoInputVo pMemberInfoInputVo);

    @Transactional(readOnly = true)
    P_MemberInfoOutputVo callMemberRoomListen(P_MemberInfoInputVo pMemberInfoInputVo);

    @Transactional(readOnly = true)
    HashMap<P_MemberInfoOutputVo,String> callMemberInfo_badge(String mem_no);

    @Transactional(readOnly = true)
    P_MemberInfoOutputVo callMemberBlock(P_MemberInfoInputVo pMemberInfoInputVo);

    @Transactional(readOnly = true)
    ProcedureVo callNickNameCheck(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberEditHistOutputVo> callMemberEditHistory(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    int callMemberRoomEditHistoryCnt(P_MemberEditHistInputVo pMemberEditHistInputVo);
    @Transactional(readOnly = true)
    ArrayList<P_BroadcastEditHistOutputVo> callMemberRoomEditHistory(P_MemberEditHistInputVo pMemberEditHistInputVo);

    @Transactional(readOnly = true)
    int callMemberClipEditHistoryCnt(P_MemberEditHistInputVo pMemberEditHistInputVo);
    @Transactional(readOnly = true)
    ArrayList<P_BroadcastEditHistOutputVo> callMemberClipEditHistory(P_MemberEditHistInputVo pMemberEditHistInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberEditHistOutputVo> callMemberPointHistory(P_MemberEditHistInputVo pMemberEditHistInputVo);

    @Transactional(readOnly = true)
    int callMemberPointHistory_totalCnt(P_MemberEditHistInputVo pMemberEditHistInputVo);

    ProcedureVo callMemberEditor(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    int callMemberSocialIdCheck(P_MemberEditorVo pMemberEditorVo);

    int callMemberSocialIdEditor(P_MemberEditorVo pMemberEditorVo);
    int callMemberEditHistoryAdd(P_MemberEditorVo pMemberEditorVo);
    int callMemberStateEditor(P_MemberEditorVo pMemberEditorVo);
    int callMemberWithdrawal_del(P_MemberEditorVo pMemberEditorVo);
    int callMemberBasicAdd(P_MemberEditorVo pMemberEditorVo);
    int callMemberWithdrawal_bak_del(P_MemberEditorVo pMemberEditorVo);
    int callMemberReport(P_MemberReportVo pMemberReportVo);

    @Transactional(readOnly = true)
    int callMemberBroadCasting_check(P_MemberReportVo pMemberReportVo);
    @Transactional(readOnly = true)
    int callMemberListening_check(P_MemberReportVo pMemberReportVo);

    int callMemberBasicReport_Edit(P_MemberReportVo pMemberReportVo);
    int callMemberWithdrawal_Add(P_MemberReportVo pMemberReportVo);
    int callMemberWithdrawal_fanDel(P_MemberReportVo pMemberReportVo);
    int callMemberWithdrawal_starDel(P_MemberReportVo pMemberReportVo);
    int callMemberNotification_Add(P_MemberReportVo pMemberReportVo);
    int callMemberNotification_Add_ALL(P_MemberReportVo pMemberReportVo);

    int callMemberWithdrawal_bak_Add(P_MemberReportVo pMemberReportVo);
    int callMemberBasic_del(P_MemberReportVo pMemberReportVo);

    ProcedureVo callMemAdminMemoAdd(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberAdminMemoListOutputVo> callMemAdminMemoList(ProcedureVo procedureVo);

    int callMemAdminMemoDel(P_MemberAdminMemoDelVo pMemberAdminMemoDelVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberConnectOutputVo> callMemConnect(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberManagerListOutputVo> callMemManagerList(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberBlackListOutputVo> callMemBlackList(ProcedureVo procedureVo);

    // 달 추가
    @Transactional(readOnly = true)
    int callMemberBeforDelCnt(P_MemberEditorVo pMemberEditorVo);
    int callMemberAddDal(P_MemberEditorVo pMemberEditorVo);
    int callMemberAddDal_history(P_MemberEditorVo pMemberEditorVo);
    int callMemberBeforByeolCnt(P_MemberEditorVo pMemberEditorVo);
    int callMemberAddByeol(P_MemberEditorVo pMemberEditorVo);
    int callMemberAddByeol_history(P_MemberEditorVo pMemberEditorVo);
    int callMemberEdit_date(P_MemberEditorVo pMemberEditorVo);

    int callMemberMinusDal_history(P_MemberEditorVo pMemberEditorVo);

    @Transactional(readOnly = true)
    MemberVo getMemberInfo(String mem_no);

    int callMemberBroadCastHide(P_MemberEditorVo pMemberEditorVo);

    @Transactional(readOnly = true)
    int selectLoginHistoryCnt(LoginHistoryVo loginHistoryVo);

    @Transactional(readOnly = true)
    LoginHistoryVo memberLoginHistory(String mem_no);
    @Transactional(readOnly = true)
    ArrayList<LoginHistoryVo> selectLoginHistory(LoginHistoryVo loginHistoryVo);

    int insertLoginBlock(LoginBlockVo loginBlockVo);
    int insertLoginBlockHistory(LoginBlockHistVo loginBlockHistVo);

    @Transactional(readOnly = true)
    P_MemberParentsAgreeOutputVo getParentsAgreeInfo(P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo);

    int updateRecant(P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo);

    int updateBackRecant(P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo);

    @Transactional(readOnly = true)
    P_MemberSetting getMemberSetting(String mem_no);

    int deleteCert(P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo);
    int deleteCert_back(P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo);
    int moveCertInfo(P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo);
    int moveRollbackCertInfo(P_MemberParentsAgreeInputVo pMemberParentsAgreeInputVo);

    int insertAuth(P_AuthVo pAuthVo);

    P_MemberItemVo boostItemChange(ProcedureVo procedureVo);

    P_MemberEditorVo setChangeAutoSetting(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    int boostItemHistCnt(P_MemberItemVo pMemberItemVo);

    @Transactional(readOnly = true)
    List<P_MemberItemVo> boostItemHist(P_MemberItemVo pMemberItemVo);

    int selectMemberBoostListCnt(P_MemberListInputVo pMemberListInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberListOutputVo> selectMemberBoostList(P_MemberListInputVo pMemberListInputVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberCouponVo> callMemberCouponHistory(ProcedureVo procedureVo);

    @Transactional(readOnly = true)
    ArrayList<P_MemberInfoOutputVo> callAlbumList(ProcedureVo procedureVo);

    int callMemberAlbumDelete(P_MemberInfoInputVo pMemberInfoInputVo);
    int callMemberProfileDelete(P_MemberInfoInputVo pMemberInfoInputVo);
    int callMemberLeaderAlbumDelete(P_MemberInfoInputVo pMemberInfoInputVo);
}
