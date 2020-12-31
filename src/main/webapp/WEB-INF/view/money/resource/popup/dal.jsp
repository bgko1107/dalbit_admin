<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제/환불 > 결제내역 -->
<div class="widget-table mb10">
    <div class="col-md-12" style="background-color: #fbe5d6;padding:7px;margin-top: 8px">
        <span class="font-bold" id="sp_type" style="color: #7792c9;"></span><span class="font-bold">&nbsp;상세내역</span>
    </div>
    <div class="widget-content mt10">
        <table class="table table-bordered" id="list">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript" src="/js/code/payment/payCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    var dtList_info;

    var type = '${param.type}';

    getDalList();
    function getDalList() {
        if(type == "1"){
            $("#sp_type").text("달 결제");
        }else if(type == "2-1"){
            $("#sp_type").text("달 직접 선물");
        }else if(type == "3"){
            $("#sp_type").text("달 교환");
        }else if(type == "3-1"){
            $("#sp_type").text("달 교환(자동)");
        }else if(type == "4"){
            $("#sp_type").text("가입보상");
        }else if(type == "5"){
            $("#sp_type").text("레벨 보상");
        }else if(type == "6"){
            $("#sp_type").text("랭킹 보상");
        }else if(type == "7"){
            $("#sp_type").text("출석이벤트");
        }else if(type == "8"){
            $("#sp_type").text("소실금액복구(운영자지급)");
        }else if(type == "9-1"){
            $("#sp_type").text("이벤트 지급(자동)");
        }else if(type == "9-2"){
            $("#sp_type").text("이벤트 지급(운영자지급)");
        }else if(type == "10"){
            $("#sp_type").text("테스트 지급");
        }else if(type == "2-2"){
            $("#sp_type").text("달 직접 선물");
        }else if(type == "11"){
            $("#sp_type").text("아이템 선물");
        }else if(type == "12"){
            $("#sp_type").text("결제 취소");
        }else if(type == "13"){
            $("#sp_type").text("영구정지");
        }else if(type == "14"){
            $("#sp_type").text("탈퇴");
        }else if(type == "15"){
            $("#sp_type").text("테스트 회수");
        }else if(type == "19"){
            $("#sp_type").text("룰렛 이벤트");
        }else if(type == "22"){
            $("#sp_type").text("스패셜DJ");
        }

        var dtList_info_data = function(data) {
            data.sDate = '${param.sDate}';
            data.eDate = '${param.eDate}';
            data.type = '${param.type}';
            data.gender = '${param.gender}';
            data.slctType = '${param.slctType}';
        };


        // data-type="1"        달 결제
        // data-type="2-1"      달 직접 선물
        // data-type="3"        달 교환
        // data-type="4"        가입 보상
        // data-type="5"        레벨 보상
        // data-type="6"        랭킹 보상
        // data-type="7"        출석이벤트
        // data-type="8"        소실금액 복구 (운영자지급)
        // data-type="9-1"      이벤트 지급 (자동)
        // data-type="9-2"      이벤트 지급 (운영자지급)
        // data-type="10"       테스트 지급
        // data-type="2-2"      달 직접 선물
        // data-type="11"       아이템 선물
        // data-type="12"       결제 취소
        // data-type="13"       영구정지
        // data-type="14"       탈퇴
        // data-type="15"       테스트 회수
        // data-type="15"       룰렛 이벤트
        // data-type="22"       룰렛 이벤트

        if(type == "1"){            // 달결제
            dtList_info = new DalbitDataTable($("#list"), dtList_info_data, resourceDataTableSource.dalInc_payDetail);
        }else if(type == "2-1" || type == "2-2"){    // 달 직접 선물(달증가)/(달감소)
            dtList_info = new DalbitDataTable($("#list"), dtList_info_data, resourceDataTableSource.dalInc_giftDirect);
        }else if(type == "3" || type == "3-1"){      // 달 교환
            dtList_info = new DalbitDataTable($("#list"), dtList_info_data, resourceDataTableSource.dalInc_dalChange);
        }else if(type == "4" || type == "5" || type == "6" || type == "7"               // 가입보상, 레벨보상, 랭킹보상, 출석이벤트,
                || type == "8" || type == "9-1" || type == "9-2"  || type == "10"       // 소실금액 복구(운영자지급), 이벤트 지급(자동/운영자지급), 테스트 지급
                || type == "15" || type == "19" || type == "22" ){                      // 테스트 회수,  룰렛 이벤트, 스패셜DJ
            dtList_info = new DalbitDataTable($("#list"), dtList_info_data, resourceDataTableSource.dalInc_joinReward);
        }else if(type == "11"){     // 아이템 사용
            dtList_info = new DalbitDataTable($("#list"), dtList_info_data, resourceDataTableSource.dalDec_gift);
        }else if(type == "12"){     // 결제 취소
            dtList_info = new DalbitDataTable($("#list"), dtList_info_data, resourceDataTableSource.dalDec_payDetail);
        }else if(type == "13" || type == "14"){     // 영구정지, 탈퇴회원
            dtList_info = new DalbitDataTable($("#list"), dtList_info_data, resourceDataTableSource.dalDec_memState);
        }
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(50);
        dtList_info.useInitReload(true);
        dtList_info.createDataTable();
    }


</script>


