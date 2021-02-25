<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10" style="width: 2500px;">
    <div class="widget-content mt10" id="divDalAmt">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <div class="dataTables_paginate paging_full_numbers" id="dalAmt_paginate_top"></div>
        <table class="table table-bordered">
            <colgroup>
                <col width="4%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/><col width="2%"/>
                <col width="2%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="4" class="_bgColor _fontColor" data-bgcolor="#00b050" data-fontcolor="white">회원정보</th>
                <th colspan="39" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">달빛라이브 [달_금액]</th>
            </tr>
            <tr>
                <th rowspan="2" colspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">기초</th>
                <th colspan="10" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">증가</th>
                <th colspan="25" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">감소</th>
                <th rowspan="2" colspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">기말</th>
            </tr>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">전체합계</th>
                <th colspan="5" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유료</th>
                <th colspan="4" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">무료</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">전체합계</th>
                <th colspan="12" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">유료</th>
                <th colspan="12" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">무료</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">유료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">무료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">PG사 결제</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">달 전환</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선물하기</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자지급</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">이벤트</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선물하기</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자지급</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">방송-음성</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">방송-영상</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">부스터-음성</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">부스터-영상</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">클립</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">우체통</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선물하기</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">환불</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">회원탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">휴면탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자회수</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">방송-음성</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">방송-영상</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">부스터-음성</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">부스터-영상</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">클립</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">우체통</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">선물하기</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">환불</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">회원탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">휴면탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자회수</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">유료</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">무료</th>
            </tr>
            </thead>
            <tbody id="dalAmtTableBody"></tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="dalAmt_paginate"></div>
    </div>
</div>
<button class="btn btn-default btn-sm print-btn pull-left excelDownBtn_dal" type="button"><i class="fa fa-print"></i>Excel Down</button>
<button class="btn btn-default btn-sm print-btn pull-right excelDownBtn_dal" type="button"><i class="fa fa-print"></i>Excel Down</button>

<script type="text/javascript">
    var dalAmtPagingInfo = new PAGING_INFO(0,1,100);

    function getDalAmtList(pagingNo){

        if(!common.isEmpty(pagingNo)){
            dalAmtPagingInfo.pageNo = pagingNo;
        }else{
            dalAmtPagingInfo.pageNo = 1;
        }

        var data = {
            startDate : $("#startDate").val()
            , pageNo : dalAmtPagingInfo.pageNo
            , pageCnt : dalAmtPagingInfo.pageCnt
        };
        util.getAjaxData("dalAmt", "/rest/enter/pay/dal/amt", data, fn_dalAmt_success);
    }

    function fn_dalAmt_success(data, response){

        $("#dalAmtTableBody").empty();

        var template = $('#tmp_dalAmtDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data;
        var html=templateScript(detailContext);
        $("#dalAmtTableBody").append(html);

        dalAmtPagingInfo.totalCnt = response.data.totalInfo.totalCnt;
        util.renderPagingNavigation('dalAmt_paginate_top', dalAmtPagingInfo);
        util.renderPagingNavigation('dalAmt_paginate', dalAmtPagingInfo);
        dalAmtPagingInfo.pageNo=1;

        if(response.data.length == 0) {
            $("#dalAmt_paginate_top").hide();
            $('#dalAmt_paginate').hide();
        } else {
            $("#dalAmt_paginate_top").show();
            $('#dalAmt_paginate').show();
        }
        ui.paintColor();
        ui.tableHeightSet();
    }

    $('.excelDownBtn_dal').on('click', function(){
        var formData = new FormData();
        formData.append("startDate", $("#startDate").val());

        util.excelDownload($(this), "/rest/enter/pay/dal/amtListExcel", formData,
            function () {
                console.log("fn_success_excel");
            }, function () {
                console.log("fn_fail_excel");
            });
    });

</script>

<script type="text/x-handlebars-template" id="tmp_dalAmtDetailList">
    <tr class="_bgColor font-bold" data-bgcolor="#f2f2f2">
        <td>합계</td>
        <td>{{addComma totalInfo.oldPayDal}}</td>
        <td>{{addComma totalInfo.oldFreeDal}}</td>
        <td>{{addComma totalInfo.addTotalDal}}</td>
        <td>{{addComma totalInfo.addPayTotal}}</td>
        <td>{{addComma totalInfo.addPayPg}}</td>
        <td>{{addComma totalInfo.addPayChange}}</td>
        <td>{{addComma totalInfo.addPayGift}}</td>
        <td>{{addComma totalInfo.addPayOp}}</td>
        <td>{{addComma totalInfo.addFreeTotal}}</td>
        <td>{{addComma totalInfo.addFreeEvent}}</td>
        <td>{{addComma totalInfo.addFreeGift}}</td>
        <td>{{addComma totalInfo.addFreeOp}}</td>
        <td>{{addComma totalInfo.subTotalDal}}</td>
        <td>{{addComma totalInfo.subPayTotal}}</td>
        <td>{{addComma totalInfo.subPayBroad}}</td>
        <td>{{addComma totalInfo.subPayBroadV}}</td>
        <td>{{addComma totalInfo.subPayBooster}}</td>
        <td>{{addComma totalInfo.subPayBoosterV}}</td>
        <td>{{addComma totalInfo.subPayClip}}</td>
        <td>{{addComma totalInfo.subPayMailbox}}</td>
        <td>{{addComma totalInfo.subPayGift}}</td>
        <td>{{addComma totalInfo.subPayCancel}}</td>
        <td>{{addComma totalInfo.subPayWithdrawal}}</td>
        <td>{{addComma totalInfo.subPayWithdrawalSleep}}</td>
        <td>{{addComma totalInfo.subPayOp}}</td>
        <td>{{addComma totalInfo.subFreeTotal}}</td>
        <td>{{addComma totalInfo.subFreeBroad}}</td>
        <td>{{addComma totalInfo.subFreeBroadV}}</td>
        <td>{{addComma totalInfo.subFreeBooster}}</td>
        <td>{{addComma totalInfo.subFreeBoosterV}}</td>
        <td>{{addComma totalInfo.subFreeClip}}</td>
        <td>{{addComma totalInfo.subFreeMailbox}}</td>
        <td>{{addComma totalInfo.subFreeGift}}</td>
        <td>{{addComma totalInfo.subFreeCancel}}</td>
        <td>{{addComma totalInfo.subFreeWithdrawal}}</td>
        <td>{{addComma totalInfo.subFreeWithdrawlSleep}}</td>
        <td>{{addComma totalInfo.subFreeOp}}</td>
        <td>{{addComma totalInfo.newPayDal}}</td>
        <td>{{addComma totalInfo.newFreeDal}}</td>
    </tr>
    {{#each this.detailList as |data|}}
    <tr>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a><br/>
            {{nickName}} {{{sexIcon memSex}}}
        </td>
        <td>{{addComma oldPayDal 'Y'}}</td>
        <td>{{addComma oldFreeDal 'Y'}}</td>
        <td>{{addComma addTotalDal 'Y'}}</td>
        <td>{{addComma addPayTotal 'Y'}}</td>
        <td>{{addComma addPayPg 'Y'}}</td>
        <td>{{addComma addPayChange 'Y'}}</td>
        <td>{{addComma addPayGift 'Y'}}</td>
        <td>{{addComma addPayOp 'Y'}}</td>
        <td>{{addComma addFreeTotal 'Y'}}</td>
        <td>{{addComma addFreeEvent 'Y'}}</td>
        <td>{{addComma addFreeGift 'Y'}}</td>
        <td>{{addComma addFreeOp 'Y'}}</td>
        <td>{{addComma subTotalDal 'Y'}}</td>
        <td>{{addComma subPayTotal 'Y'}}</td>
        <td>{{addComma subPayBroad 'Y'}}</td>
        <td>{{addComma subPayBroadV 'Y'}}</td>
        <td>{{addComma subPayBooster 'Y'}}</td>
        <td>{{addComma subPayBoosterV 'Y'}}</td>
        <td>{{addComma subPayClip 'Y'}}</td>
        <td>{{addComma subPayMailbox 'Y'}}</td>
        <td>{{addComma subPayGift 'Y'}}</td>
        <td>{{addComma subPayCancel 'Y'}}</td>
        <td>{{addComma subPayWithdrawal 'Y'}}</td>
        <td>{{addComma subPayWithdrawalSleep 'Y'}}</td>
        <td>{{addComma subPayOp 'Y'}}</td>
        <td>{{addComma subFreeTotal 'Y'}}</td>
        <td>{{addComma subFreeBroad 'Y'}}</td>
        <td>{{addComma subFreeBroadV 'Y'}}</td>
        <td>{{addComma subFreeBooster 'Y'}}</td>
        <td>{{addComma subFreeBoosterV 'Y'}}</td>
        <td>{{addComma subFreeClip 'Y'}}</td>
        <td>{{addComma subFreeMailbox 'Y'}}</td>
        <td>{{addComma subFreeGift 'Y'}}</td>
        <td>{{addComma subFreeCancel 'Y'}}</td>
        <td>{{addComma subFreeWithdrawal 'Y'}}</td>
        <td>{{addComma subFreeWithdrawlSleep 'Y'}}</td>
        <td>{{addComma subFreeOp 'Y'}}</td>
        <td>{{addComma newPayDal 'Y'}}</td>
        <td>{{addComma newFreeDal 'Y'}}</td>
    </tr>
    {{/each}}
</script>