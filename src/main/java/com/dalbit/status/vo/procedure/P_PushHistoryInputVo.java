package com.dalbit.status.vo.procedure;

import com.dalbit.common.vo.SearchVo;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class P_PushHistoryInputVo extends SearchVo {
    private String startDate;
    private String endDate;
    private String push_send_user;
    private int state;

    private String idx; 			                    // 'push Idx'
    private String send_date; 		                // '발송일자[예약발송일자]'
    private String target_mem; 		            // '수신대상구분(0:지정,1:팬,11:회원,21:회원_비회원,31:비회원)'
    private String target_platform;               // '디바이스대상(10:aos,01:ios,11:aos_ios'
    private String push_slct; 		                // '푸시구분'
    private String push_type; 		                // '이동구분'
    private String image_type; 		            // '이미지구분'
    private String send_type; 		                // '발송형태상(10:push,01:alrim,11:push_alrim'
    private String target_cnt; 		                // '수신대상'
    private String send_title; 		                // '제목'
    private String send_cont; 		                // '내용'
    private String mem_no; 			            // '발신자회원번호'
    private String mem_nick; 		                // '발신자회원아이디'
    private String send_etc; 		                // '추가내용'
    private String send_cnt; 		                // '발송건수'
    private String succ_cnt; 		                // '성공건수'
    private String fail_cnt; 		                    // '실패건수'
    private String succ_rate; 		                // '성공율'
    private String click_cnt; 		                // '클릭건수'
    private String click_rate; 		                // '클릭율'
    private String admin_idx; 		                // '어드민발송 Idx'
    private String ins_date; 		                // '등록일자'
    private String last_upd_date; 	            // '변경일자'

}
