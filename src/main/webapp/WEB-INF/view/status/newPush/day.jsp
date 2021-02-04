<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table" id="div_scroll">
    <div class="widget-content">
        <span>
            · 푸시 성공 수신거부, 거부비율 건에 대한 수치 현황입니다.<br/>
            · 푸시 초기화 매달 초 00시 이고, 30분 단위 리로드됩니다.
        </span><br/>
        <button type="button" class="btn btn-success btn-ms pull-left" id="bt_tableSw" onclick="tableSwich();">전체보기</button>
        <div id="div_daySimpleTable">
            <table class="table table-bordered _tableHeight" data-height="23px" id="simpleDayTable">
                <colgroup>
                    <col width="6.25%"/><col width="6.25%"/><col width="6.25%"/><col width="6.25%"/><col width="6.25%"/>
                    <col width="6.25%"/><col width="6.25%"/><col width="6.25%"/><col width="6.25%"/><col width="6.25%"/>
                    <col width="6.25%"/><col width="6.25%"/><col width="6.25%"/><col width="6.25%"/><col width="6.25%"/>
                    <col width="6.25%"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">구분</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">성별</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">마이스타</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">알림받기</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">선물</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">팬 등록</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">팬 보드</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">우체통</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">클립</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">랭킹</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">서비스</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">환전</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">운영자 (자동)</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">운영자 (직접)</th>
                    <th class="_bgColor" data-bgColor="#d9d9d9">소계</th>
                    <th class="_bgColor" data-bgColor="#bfbfbf">총 합</th>
                </tr>
                </thead>
                <tbody id="tableDayBody_simple"></tbody>
            </table>
        </div>

        <div id="div_dayDetailTable" class="col-md-12 no-padding" style="display: none">
            <table class="table table-bordered _tableHeight dayTable" data-height="23px" style="width: 3770px;">
                <colgroup>
                    <col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/>
                    <col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/>
                    <col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/>
                    <col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/>
                    <col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/>
                    <col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/>
                    <col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/>
                    <col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/><col width="2.4%"/>
                    <col width="2.4%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">구분</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">성별</th>
                    <th colspan="4" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">마이스타</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">알림받기</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">선물</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">팬 등록</th>
                    <th colspan="4" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">팬 보드/댓글</th>
                    <th colspan="2" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">우체통</th>
                    <th colspan="3" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">클립</th>
                    <th class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">랭킹</th>
                    <th colspan="4" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">서비스</th>
                    <th colspan="2" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">환전</th>
                    <th colspan="7" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">운영자 (자동)</th>
                    <th colspan="6" class="_bgColor _fontColor" data-bgColor="#4472c4" data-fontcolor="white">운영자 (직접)</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#d9d9d9">소계</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#bfbfbf">총 합</th>
                </tr>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">방송 시작</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">신규공지 등록</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">공지댓글</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">클립 등록</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">방송 시작</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">수신</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">최초 1회</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#b4c7e7">신규 글 등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#b4c7e7">신규 댓글</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">메시지 도착</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">선물 대상</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">좋아요</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">댓글</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">선물</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">DJ/FAN</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">생일 축하</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">공지 가입<br/>15일 간 미접속</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">이벤트 알림</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">1:1 문의 답변</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">완료</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">취소(불가)</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">긴급공지</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">휴면/탈퇴</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">사용자 경고</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">경고해제</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">이용정지해제</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">프로필 이미지 초기화/닉네임 초기화</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">클립 정보 수정 및 신고</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">선물 알림</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">회원 + 비회원</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">회원</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">비회원</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">테스트계정</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">타겟</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#dae3f3">일반</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">비밀</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">일반</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">비밀</th>
                </tr>
                </thead>
                <tbody id="tableDayBody_detail"></tbody>
            </table>
        </div>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>


<div class="modal fade" id="dayModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px;">
        <div class="modal-content">
            <div class="modal-body">
                <table class="table table-bordered _tableHeight font-bold" data-height="23px">
                    <colgroup>
                        <col width="16.6%"/><col width="16.6%"/><col width="16.6%"/><col width="16.6%"/>
                        <col width="16.6%"/>
                    </colgroup>
                    <tr>
                        <td class="_bgColor" data-bgcolor="#b4c7e7">구분</td>
                        <td colspan="2"><span id="type"></span></td>
                        <td class="_bgColor" data-bgcolor="#b4c7e7">날짜</td>
                        <td><span id="date"></span></td>
                        <td class="_bgColor" data-bgcolor="#d9d9d9"><a href="javascript://" data-dismiss="modal" aria-hidden="true">[닫기]</a></td>
                    </tr>
                    <tr>
                        <td class="_bgColor" data-bgcolor="#d9d9d9"><span style="color: blue">남</span>/<span style="color: red;">여</span>/알수없음<br/>발송 수</td>
                        <td><span id="sendCount"></span></td>
                        <td class="_bgColor" data-bgcolor="#d9d9d9"><span style="color: blue">남</span>/<span style="color: red;">여</span>/알수없음<br/>성공 수</td>
                        <td><span id="succCount"></span></td>
                        <td class="_bgColor" data-bgcolor="#d9d9d9"><span style="color: blue">남</span>/<span style="color: red;">여</span>/알수없음<br/>실패 수</td>
                        <td><span id="failCount"></span></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){

    });

    function getDay(){
        var data = getData();
        data.viewType = 0;
        console.log(data);
        util.getAjaxData("day", "/rest/status/push/day", data, fn_day_simple_success);

        var data = getData();
        data.viewType = 1;
        console.log(data);
        util.getAjaxData("day", "/rest/status/push/day", data, fn_day_detail_success);
    }

    function fn_day_simple_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#tableDayBody_simple").empty();
        if(!isDataEmpty){
            var template = $('#tmp_tableDayBody_simpleTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#tableDayBody_simple").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        var template = $('#tableDayBody_simpleDetail').html();
        var templateScript = Handlebars.compile(template);
        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];
            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date + "<br/>(" + toDay + ")" + '</span>';
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date + "<br/>(" + toDay + ")" + '</span>';
            } else {
                toDay = response.data.detailList[i].the_date+ "<br/>(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;
        }

        for(var i = (response.data.detailList.length - 1); 0 <= i; i-- ){
            var accumTotSucc = 0;
            var accumTotFail = 0;
            for(var j = (response.data.detailList.length - 1); 0 <= j; j-- ) {
                if(response.data.detailList[i].the_date == response.data.detailList[j].the_date){
                    accumTotSucc = accumTotSucc + response.data.detailList[j].totSucc;
                    accumTotFail = accumTotFail + response.data.detailList[j].totFail;
                }
            }
            response.data.detailList[i].accumTotSucc = accumTotSucc;
            response.data.detailList[i].accumTotFail = accumTotFail;
        }


        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableDayBody_simple").append(html);

        if(isDataEmpty){
            $("#tableDayBody_simple td:last").remove();
        }else{
            $("#tableDayBody_simple").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();

        monthRowspan("month");
        totalRowspan("total");
    }

    function fn_day_detail_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        $("#tableDayBody_detail").empty();
        if(!isDataEmpty){
            var template = $('#tmp_tableDayBody_detailTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#tableDayBody_detail").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        var template = $('#tableDayBody_detailDetail').html();
        var templateScript = Handlebars.compile(template);
        response.data.detailList.nowMonth = Number(moment().format("MM"));
        response.data.detailList.nowDay = Number(moment().format("DD"));
        response.data.detailList.nowHour = Number(moment().format("HH"));

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi, ".")).add('days', 0).day()];
            if (toDay == "토") {
                toDay = '<span class="_fontColor" data-fontColor="blue" style="color:blue">' + response.data.detailList[i].the_date + "<br/>(" + toDay + ")" + '</span>';
            } else if (toDay == "일") {
                toDay = '<span class="_fontColor" data-fontColor="red" style="color:red">' + response.data.detailList[i].the_date + "<br/>(" + toDay + ")" + '</span>';
            } else {
                toDay = response.data.detailList[i].the_date+ "<br/>(" + toDay + ")";
            }
            response.data.detailList[i].date = toDay;
        }

        for(var i = (response.data.detailList.length - 1); 0 <= i; i-- ){
            var accumTotSucc = 0;
            var accumTotFail = 0;
            for(var j = (response.data.detailList.length - 1); 0 <= j; j-- ) {
                if(response.data.detailList[i].the_date == response.data.detailList[j].the_date){
                    accumTotSucc = accumTotSucc + response.data.detailList[j].totSucc;
                    accumTotFail = accumTotFail + response.data.detailList[j].totFail;
                }
            }
            response.data.detailList[i].accumTotSucc = accumTotSucc;
            response.data.detailList[i].accumTotFail = accumTotFail;
        }

        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableDayBody_detail").append(html);

        if(isDataEmpty){
            $("#tableDayBody_detail td:last").remove();
        }else{
            $("#tableDayBody_detail").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();

        monthRowspan("detailMonth");
        totalRowspan("detailTotal");
    }

    function tableSwich(){
        $("#div_dayDetailTable").hide();
        $("#div_daySimpleTable").hide();
        if( $("#bt_tableSw").html() == "전체보기"){
            $("#div_scroll").css('width','3800px');
            $("#bt_tableSw").html('간략하게');
            $("#div_dayDetailTable").show();
        }else{
            $("#div_scroll").css('width','');
            $("#bt_tableSw").html('전체보기');
            $("#div_daySimpleTable").show();
        }
    }

    function mouseover(row){
        row.addClass("selectedRow");
    }
    function mouseout(row){
        row.removeClass("selectedRow");
    }

    function dayDetailPopup(data){
        var data = {
            type : data.data('type')
            , startDate : data.data('startdate')
            , slctType : 0
        };
        util.getAjaxData("day", "/rest/status/push/day/detail/popup", data, fn_day_detail_popup_success);
    }

    function daySimplePopup(data){
        var data = {
            type : data.data('type')
            , startDate : data.data('startdate')
            , slctType : 0
        };
        util.getAjaxData("day", "/rest/status/push/day/detail/popup", data, fn_day_simple_popup_success);
    }

    function fn_day_detail_popup_success(dst_id, response, param){
        $('#dayModal').modal("show");
        $('#dayModal').find("#type").html(util.getCommonCodeLabel(param.type,status_detail_push_type));
        $('#dayModal').find("#date").html(param.startDate);
        $('#dayModal').find("#sendCount").html('<span style="color:blue;">' + response.data.totalInfo.sendmCnt + '</span> / <span style="color:red;">' + response.data.totalInfo.sendfCnt + '</span> / ' + response.data.totalInfo.sendnCnt);
        $('#dayModal').find("#succCount").html('<span style="color:blue;">' + response.data.totalInfo.succmCnt + '</span> / <span style="color:red;">' + response.data.totalInfo.succfCnt + '</span> / ' + response.data.totalInfo.succnCnt);
        $('#dayModal').find("#failCount").html('<span style="color:blue;">' + response.data.totalInfo.failmCnt + '</span> / <span style="color:red;">' + response.data.totalInfo.failfCnt + '</span> / ' + response.data.totalInfo.failnCnt);

    }

    function fn_day_simple_popup_success(dst_id, response, param){
        $('#dayModal').modal("show");
        $('#dayModal').find("#type").html(util.getCommonCodeLabel(param.type,status_simple_push_type));
        $('#dayModal').find("#date").html(param.startDate);
        $('#dayModal').find("#sendCount").html('<span style="color:blue;">' + response.data.totalInfo.sendmCnt + '</span> / <span style="color:red;">' + response.data.totalInfo.sendfCnt + '</span> / ' + response.data.totalInfo.sendnCnt);
        $('#dayModal').find("#succCount").html('<span style="color:blue;">' + response.data.totalInfo.succmCnt + '</span> / <span style="color:red;">' + response.data.totalInfo.succfCnt + '</span> / ' + response.data.totalInfo.succnCnt);
        $('#dayModal').find("#failCount").html('<span style="color:blue;">' + response.data.totalInfo.failmCnt + '</span> / <span style="color:red;">' + response.data.totalInfo.failfCnt + '</span> / ' + response.data.totalInfo.failnCnt);

    }

</script>
<script type="text/x-handlebars-template" id="tmp_tableDayBody_simpleTotal">
    <tr class="font-bold">
        <td class="_bgColor" data-bgcolor="#bfbfbf">총합</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">성공수치</span><br/>(수신거부)<br/>(거부비율%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p11Succ}}</span><br/>({{addComma p11Fail}})<br/>({{average p11Fail p11Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p25Succ}}</span><br/>({{addComma p25Fail}})<br/>({{average p25Fail p25Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p15Succ}}</span><br/>({{addComma p15Fail}})<br/>({{average p15Fail p15Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p16Succ}}</span><br/>({{addComma p16Fail}})<br/>({{average p16Fail p16Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p17Succ}}</span><br/>({{addComma p17Fail}})<br/>({{average p17Fail p17Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p34Succ}}</span><br/>({{addComma p34Fail}})<br/>({{average p34Succ p34Fail}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p31Succ}}</span><br/>({{addComma p31Fail}})<br/>({{average p31Fail p31Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p20Succ}}</span><br/>({{addComma p20Fail}})<br/>({{average p20Fail p20Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p19Succ}}</span><br/>({{addComma p19Fail}})<br/>({{average p19Fail p19Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p62Succ}}</span><br/>({{addComma p62Fail}})<br/>({{average p62Fail p62Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p53Succ}}</span><br/>({{addComma p53Fail}})<br/>({{average p53Fail p53Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p61Succ}}</span><br/>({{addComma p61Fail}})<br/>({{average p61Fail p61Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma totSucc}}</span><br/>({{addComma totFail}})<br/>({{average totFail totSucc}}%)</td>
        <td class="_bgColor" data-bgcolor="#bfbfbf"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma totSucc}}</span><br/>({{addComma totFail}})<br/>({{average totFail totSucc}}%)</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tableDayBody_simpleDetail">
    {{#each this as |data|}}
    <tr {{#dalbit_if ../nowDay '==' data.day}} class="font-bold _stateSubTh" {{/dalbit_if}} >
        <td class="month _bgColor font-bold" data-bgcolor="#b4c7e7">{{data.the_date}}</td>
        <td class="_fontColor _bgColor" data-bgColor="#dae3f3" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{{sexIcon data.gb}}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="11, 18, 24, 30"         data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p11Succ '!=' 0}}<span class="font-bold">{{addComma p11Succ}}</span><br/>({{addComma p11Fail}})<br/>({{average p11Fail p11Succ}}%){{else}}{{#dalbit_if p11Fail '!=' 0}}<span class="font-bold">{{addComma p11Succ}}</span><br/>({{addComma p11Fail}})<br/>({{average p11Fail p11Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="25"                     data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p25Succ '!=' 0}}<span class="font-bold">{{addComma p25Succ}}</span><br/>({{addComma p25Fail}})<br/>({{average p25Fail p25Succ}}%){{else}}{{#dalbit_if p25Fail '!=' 0}}<span class="font-bold">{{addComma p25Succ}}</span><br/>({{addComma p25Fail}})<br/>({{average p25Fail p25Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="15"                     data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p15Succ '!=' 0}}<span class="font-bold">{{addComma p15Succ}}</span><br/>({{addComma p15Fail}})<br/>({{average p15Fail p15Succ}}%){{else}}{{#dalbit_if p15Fail '!=' 0}}<span class="font-bold">{{addComma p15Succ}}</span><br/>({{addComma p15Fail}})<br/>({{average p15Fail p15Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="16"                     data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p16Succ '!=' 0}}<span class="font-bold">{{addComma p16Succ}}</span><br/>({{addComma p16Fail}})<br/>({{average p16Fail p16Succ}}%){{else}}{{#dalbit_if p16Fail '!=' 0}}<span class="font-bold">{{addComma p16Succ}}</span><br/>({{addComma p16Fail}})<br/>({{average p16Fail p16Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="17, 21, 22, 23"         data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p17Succ '!=' 0}}<span class="font-bold">{{addComma p17Succ}}</span><br/>({{addComma p17Fail}})<br/>({{average p17Fail p17Succ}}%){{else}}{{#dalbit_if p17Fail '!=' 0}}<span class="font-bold">{{addComma p17Succ}}</span><br/>({{addComma p17Fail}})<br/>({{average p17Fail p17Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="34, 35"                 data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p34Succ '!=' 0}}<span class="font-bold">{{addComma p34Succ}}</span><br/>({{addComma p34Fail}})<br/>({{average p34Fail p34Succ}}%){{else}}{{#dalbit_if p34Fail '!=' 0}}<span class="font-bold">{{addComma p34Succ}}</span><br/>({{addComma p34Fail}})<br/>({{average p34Fail p34Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="31, 32, 33"             data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p31Succ '!=' 0}}<span class="font-bold">{{addComma p31Succ}}</span><br/>({{addComma p31Fail}})<br/>({{average p31Fail p31Succ}}%){{else}}{{#dalbit_if p31Fail '!=' 0}}<span class="font-bold">{{addComma p31Succ}}</span><br/>({{addComma p31Fail}})<br/>({{average p31Fail p31Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="20"                     data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p20Succ '!=' 0}}<span class="font-bold">{{addComma p20Succ}}</span><br/>({{addComma p20Fail}})<br/>({{average p20Fail p20Succ}}%){{else}}{{#dalbit_if p20Fail '!=' 0}}<span class="font-bold">{{addComma p20Succ}}</span><br/>({{addComma p20Fail}})<br/>({{average p20Fail p20Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="19, 51, 52, 60"         data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p19Succ '!=' 0}}<span class="font-bold">{{addComma p19Succ}}</span><br/>({{addComma p19Fail}})<br/>({{average p19Fail p19Succ}}%){{else}}{{#dalbit_if p19Fail '!=' 0}}<span class="font-bold">{{addComma p19Succ}}</span><br/>({{addComma p19Fail}})<br/>({{average p19Fail p19Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="62, 63"                 data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p62Succ '!=' 0}}<span class="font-bold">{{addComma p62Succ}}</span><br/>({{addComma p62Fail}})<br/>({{average p62Fail p62Succ}}%){{else}}{{#dalbit_if p62Fail '!=' 0}}<span class="font-bold">{{addComma p62Succ}}</span><br/>({{addComma p62Fail}})<br/>({{average p62Fail p62Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="53, 54, 55, 56, 57, 58" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p53Succ '!=' 0}}<span class="font-bold">{{addComma p53Succ}}</span><br/>({{addComma p53Fail}})<br/>({{average p53Fail p53Succ}}%){{else}}{{#dalbit_if p53Fail '!=' 0}}<span class="font-bold">{{addComma p53Succ}}</span><br/>({{addComma p53Fail}})<br/>({{average p53Fail p53Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="daySimplePopup($(this))" data-type="61, 92, 93, 94, 95, 96" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p61Succ '!=' 0}}<span class="font-bold">{{addComma p61Succ}}</span><br/>({{addComma p61Fail}})<br/>({{average p61Fail p61Succ}}%){{else}}{{#dalbit_if p61Fail '!=' 0}}<span class="font-bold">{{addComma p61Succ}}</span><br/>({{addComma p61Fail}})<br/>({{average p61Fail p61Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
        <td class="_fontColor" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if totSucc '!=' 0}}<span class="font-bold">{{addComma totSucc}}</span><br/>({{addComma totFail}})<br/>({{average totFail totSucc}}%){{else}}{{#dalbit_if totFail '!=' 0}}<span class="font-bold">{{addComma totSucc}}</span><br/>({{addComma totFail}})<br/>({{average totFail totSucc}}%){{/dalbit_if}}{{/dalbit_if}}</td>

        <td class="total _bgColor font-bold" data-bgcolor="#bfbfbf" data-month="{{data.the_date}}">
            <span style="display: none">{{the_date}}</span>
            <span class="_fontColor" data-fontcolor="#ca6927">{{addComma accumTotSucc}}</span><br/>({{addComma accumTotFail}})<br/>({{average accumTotFail accumTotSucc}}%)
        </td>
    </tr>
    {{else}}
        <td colspan="15" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_tableDayBody_detailTotal">
    <tr class="font-bold">
        <td class="_bgColor" data-bgcolor="#bfbfbf">총합</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">성공수치</span><br/>(수신거부)<br/>(거부비율%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p11Succ}}</span><br/>({{addComma p11Fail}})<br/>({{average p11Fail p11Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p18Succ}}</span><br/>({{addComma p18Fail}})<br/>({{average p18Fail p18Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p24Succ}}</span><br/>({{addComma p24Fail}})<br/>({{average p24Fail p24Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p30Succ}}</span><br/>({{addComma p30Fail}})<br/>({{average p30Fail p30Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p25Succ}}</span><br/>({{addComma p25Fail}})<br/>({{average p25Fail p25Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p15Succ}}</span><br/>({{addComma p15Fail}})<br/>({{average p15Fail p15Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p16Succ}}</span><br/>({{addComma p16Fail}})<br/>({{average p16Fail p16Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p17Succ}}</span><br/>({{addComma p17Fail}})<br/>({{average p17Fail p17Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p21Succ}}</span><br/>({{addComma p21Fail}})<br/>({{average p21Fail p21Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p22Succ}}</span><br/>({{addComma p22Fail}})<br/>({{average p22Fail p22Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p23Succ}}</span><br/>({{addComma p23Fail}})<br/>({{average p23Fail p23Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p34Succ}}</span><br/>({{addComma p34Fail}})<br/>({{average p34Fail p34Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p35Succ}}</span><br/>({{addComma p35Fail}})<br/>({{average p35Fail p35Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p31Succ}}</span><br/>({{addComma p31Fail}})<br/>({{average p31Fail p31Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p32Succ}}</span><br/>({{addComma p32Fail}})<br/>({{average p32Fail p32Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p33Succ}}</span><br/>({{addComma p33Fail}})<br/>({{average p33Fail p33Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p20Succ}}</span><br/>({{addComma p20Fail}})<br/>({{average p20Fail p20Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p19Succ}}</span><br/>({{addComma p19Fail}})<br/>({{average p19Fail p19Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p51Succ}}</span><br/>({{addComma p51Fail}})<br/>({{average p51Fail p51Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p52Succ}}</span><br/>({{addComma p52Fail}})<br/>({{average p52Fail p52Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p60Succ}}</span><br/>({{addComma p60Fail}})<br/>({{average p60Fail p60Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p62Succ}}</span><br/>({{addComma p62Fail}})<br/>({{average p62Fail p62Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p63Succ}}</span><br/>({{addComma p63Fail}})<br/>({{average p63Fail p63Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p53Succ}}</span><br/>({{addComma p53Fail}})<br/>({{average p53Fail p53Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p50Succ}}</span><br/>({{addComma p50Fail}})<br/>({{average p50Fail p50Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p54Succ}}</span><br/>({{addComma p54Fail}})<br/>({{average p54Fail p54Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p55Succ}}</span><br/>({{addComma p55Fail}})<br/>({{average p55Fail p55Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p56Succ}}</span><br/>({{addComma p56Fail}})<br/>({{average p56Fail p56Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p57Succ}}</span><br/>({{addComma p57Fail}})<br/>({{average p57Fail p57Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p58Succ}}</span><br/>({{addComma p58Fail}})<br/>({{average p58Fail p58Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p61Succ}}</span><br/>({{addComma p61Fail}})<br/>({{average p61Fail p61Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p92Succ}}</span><br/>({{addComma p92Fail}})<br/>({{average p92Fail p92Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p93Succ}}</span><br/>({{addComma p93Fail}})<br/>({{average p93Fail p93Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p94Succ}}</span><br/>({{addComma p94Fail}})<br/>({{average p94Fail p94Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p95Succ}}</span><br/>({{addComma p95Fail}})<br/>({{average p95Fail p95Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma p96Succ}}</span><br/>({{addComma p96Fail}})<br/>({{average p96Fail p96Succ}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma totSucc}}</span><br/>({{addComma totFail}})<br/>({{average totFail totSucc}}%)</td>
        <td class="_bgColor" data-bgcolor="#f2f2f2"><span class="_fontColor" data-fontcolor="#ca6927">{{addComma totSucc}}</span><br/>({{addComma totFail}})<br/>({{average totFail totSucc}}%)</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tableDayBody_detailDetail">
    {{#each this as |data|}}
    <tr {{#dalbit_if ../nowDay '==' data.day}} class="font-bold _stateSubTh"  {{/dalbit_if}}>
    <td class="detailMonth _bgColor font-bold" data-bgcolor="#b4c7e7">{{data.the_date}}</td>
    <td class="_fontColor _bgColor" data-bgColor="#dae3f3" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{{sexIcon data.gb}}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="11" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p11Succ '!=' 0}}<span class="font-bold">{{addComma p11Succ}}</span><br/>({{addComma p11Fail}})<br/>({{average p11Fail p11Succ}}%){{else}}{{#dalbit_if p11Fail '!=' 0}}<span class="font-bold">{{addComma p11Succ}}</span><br/>({{addComma p11Fail}})<br/>({{average p11Fail p11Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="18" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p18Succ '!=' 0}}<span class="font-bold">{{addComma p18Succ}}</span><br/>({{addComma p18Fail}})<br/>({{average p18Fail p18Succ}}%){{else}}{{#dalbit_if p18Fail '!=' 0}}<span class="font-bold">{{addComma p18Succ}}</span><br/>({{addComma p18Fail}})<br/>({{average p18Fail p18Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="24" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p24Succ '!=' 0}}<span class="font-bold">{{addComma p24Succ}}</span><br/>({{addComma p24Fail}})<br/>({{average p30Fail p24Succ}}%){{else}}{{#dalbit_if p24Fail '!=' 0}}<span class="font-bold">{{addComma p24Succ}}</span><br/>({{addComma p24Fail}})<br/>({{average p24Fail p24Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="30" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p30Succ '!=' 0}}<span class="font-bold">{{addComma p30Succ}}</span><br/>({{addComma p30Fail}})<br/>({{average p30Fail p30Succ}}%){{else}}{{#dalbit_if p30Fail '!=' 0}}<span class="font-bold">{{addComma p30Succ}}</span><br/>({{addComma p30Fail}})<br/>({{average p30Fail p30Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="25" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p25Succ '!=' 0}}<span class="font-bold">{{addComma p25Succ}}</span><br/>({{addComma p25Fail}})<br/>({{average p25Fail p25Succ}}%){{else}}{{#dalbit_if p25Fail '!=' 0}}<span class="font-bold">{{addComma p25Succ}}</span><br/>({{addComma p25Fail}})<br/>({{average p25Fail p25Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="15" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p15Succ '!=' 0}}<span class="font-bold">{{addComma p15Succ}}</span><br/>({{addComma p15Fail}})<br/>({{average p15Fail p15Succ}}%){{else}}{{#dalbit_if p15Fail '!=' 0}}<span class="font-bold">{{addComma p15Succ}}</span><br/>({{addComma p15Fail}})<br/>({{average p15Fail p15Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="16" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p16Succ '!=' 0}}<span class="font-bold">{{addComma p16Succ}}</span><br/>({{addComma p16Fail}})<br/>({{average p16Fail p16Succ}}%){{else}}{{#dalbit_if p16Fail '!=' 0}}<span class="font-bold">{{addComma p16Succ}}</span><br/>({{addComma p16Fail}})<br/>({{average p16Fail p16Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="17" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p17Succ '!=' 0}}<span class="font-bold">{{addComma p17Succ}}</span><br/>({{addComma p17Fail}})<br/>({{average p17Fail p17Succ}}%){{else}}{{#dalbit_if p17Fail '!=' 0}}<span class="font-bold">{{addComma p17Succ}}</span><br/>({{addComma p17Fail}})<br/>({{average p17Fail p17Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="21" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p21Succ '!=' 0}}<span class="font-bold">{{addComma p21Succ}}</span><br/>({{addComma p21Fail}})<br/>({{average p21Fail p21Succ}}%){{else}}{{#dalbit_if p21Fail '!=' 0}}<span class="font-bold">{{addComma p21Succ}}</span><br/>({{addComma p21Fail}})<br/>({{average p21Fail p21Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="22" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p22Succ '!=' 0}}<span class="font-bold">{{addComma p22Succ}}</span><br/>({{addComma p22Fail}})<br/>({{average p22Fail p22Succ}}%){{else}}{{#dalbit_if p22Fail '!=' 0}}<span class="font-bold">{{addComma p22Succ}}</span><br/>({{addComma p22Fail}})<br/>({{average p22Fail p22Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="23" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p23Succ '!=' 0}}<span class="font-bold">{{addComma p23Succ}}</span><br/>({{addComma p23Fail}})<br/>({{average p23Fail p23Succ}}%){{else}}{{#dalbit_if p23Fail '!=' 0}}<span class="font-bold">{{addComma p23Succ}}</span><br/>({{addComma p23Fail}})<br/>({{average p23Fail p23Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="34" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p34Succ '!=' 0}}<span class="font-bold">{{addComma p34Succ}}</span><br/>({{addComma p34Fail}})<br/>({{average p34Fail p34Succ}}%){{else}}{{#dalbit_if p34Fail '!=' 0}}<span class="font-bold">{{addComma p34Succ}}</span><br/>({{addComma p34Fail}})<br/>({{average p34Fail p34Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="35" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p35Succ '!=' 0}}<span class="font-bold">{{addComma p35Succ}}</span><br/>({{addComma p35Fail}})<br/>({{average p35Fail p35Succ}}%){{else}}{{#dalbit_if p35Fail '!=' 0}}<span class="font-bold">{{addComma p35Succ}}</span><br/>({{addComma p35Fail}})<br/>({{average p34Fail p35Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="31" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p31Succ '!=' 0}}<span class="font-bold">{{addComma p31Succ}}</span><br/>({{addComma p31Fail}})<br/>({{average p31Fail p31Succ}}%){{else}}{{#dalbit_if p31Fail '!=' 0}}<span class="font-bold">{{addComma p31Succ}}</span><br/>({{addComma p31Fail}})<br/>({{average p31Fail p31Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="32" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p32Succ '!=' 0}}<span class="font-bold">{{addComma p32Succ}}</span><br/>({{addComma p32Fail}})<br/>({{average p32Fail p32Succ}}%){{else}}{{#dalbit_if p32Fail '!=' 0}}<span class="font-bold">{{addComma p32Succ}}</span><br/>({{addComma p32Fail}})<br/>({{average p32Fail p32Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="33" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p33Succ '!=' 0}}<span class="font-bold">{{addComma p33Succ}}</span><br/>({{addComma p33Fail}})<br/>({{average p33Fail p33Succ}}%){{else}}{{#dalbit_if p33Fail '!=' 0}}<span class="font-bold">{{addComma p33Succ}}</span><br/>({{addComma p33Fail}})<br/>({{average p33Fail p33Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="20" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p20Succ '!=' 0}}<span class="font-bold">{{addComma p20Succ}}</span><br/>({{addComma p20Fail}})<br/>({{average p20Fail p20Succ}}%){{else}}{{#dalbit_if p20Fail '!=' 0}}<span class="font-bold">{{addComma p20Succ}}</span><br/>({{addComma p20Fail}})<br/>({{average p20Fail p20Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="19" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p19Succ '!=' 0}}<span class="font-bold">{{addComma p19Succ}}</span><br/>({{addComma p19Fail}})<br/>({{average p19Fail p19Succ}}%){{else}}{{#dalbit_if p19Fail '!=' 0}}<span class="font-bold">{{addComma p19Succ}}</span><br/>({{addComma p19Fail}})<br/>({{average p19Fail p19Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="51" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p51Succ '!=' 0}}<span class="font-bold">{{addComma p51Succ}}</span><br/>({{addComma p51Fail}})<br/>({{average p51Fail p51Succ}}%){{else}}{{#dalbit_if p51Fail '!=' 0}}<span class="font-bold">{{addComma p51Succ}}</span><br/>({{addComma p51Fail}})<br/>({{average p51Fail p51Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="52" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p52Succ '!=' 0}}<span class="font-bold">{{addComma p52Succ}}</span><br/>({{addComma p52Fail}})<br/>({{average p52Fail p52Succ}}%){{else}}{{#dalbit_if p52Fail '!=' 0}}<span class="font-bold">{{addComma p52Succ}}</span><br/>({{addComma p52Fail}})<br/>({{average p52Fail p52Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="60" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p60Succ '!=' 0}}<span class="font-bold">{{addComma p60Succ}}</span><br/>({{addComma p60Fail}})<br/>({{average p60Fail p60Succ}}%){{else}}{{#dalbit_if p60Fail '!=' 0}}<span class="font-bold">{{addComma p60Succ}}</span><br/>({{addComma p60Fail}})<br/>({{average p60Fail p60Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="62" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p62Succ '!=' 0}}<span class="font-bold">{{addComma p62Succ}}</span><br/>({{addComma p62Fail}})<br/>({{average p62Fail p62Succ}}%){{else}}{{#dalbit_if p62Fail '!=' 0}}<span class="font-bold">{{addComma p62Succ}}</span><br/>({{addComma p62Fail}})<br/>({{average p62Fail p62Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="63" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p63Succ '!=' 0}}<span class="font-bold">{{addComma p63Succ}}</span><br/>({{addComma p63Fail}})<br/>({{average p63Fail p63Succ}}%){{else}}{{#dalbit_if p63Fail '!=' 0}}<span class="font-bold">{{addComma p63Succ}}</span><br/>({{addComma p63Fail}})<br/>({{average p63Fail p63Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="53" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p53Succ '!=' 0}}<span class="font-bold">{{addComma p53Succ}}</span><br/>({{addComma p53Fail}})<br/>({{average p53Fail p53Succ}}%){{else}}{{#dalbit_if p53Fail '!=' 0}}<span class="font-bold">{{addComma p53Succ}}</span><br/>({{addComma p53Fail}})<br/>({{average p53Fail p53Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="50" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p50Succ '!=' 0}}<span class="font-bold">{{addComma p50Succ}}</span><br/>({{addComma p50Fail}})<br/>({{average p50Fail p50Succ}}%){{else}}{{#dalbit_if p50Fail '!=' 0}}<span class="font-bold">{{addComma p50Succ}}</span><br/>({{addComma p50Fail}})<br/>({{average p50Fail p50Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="54" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p54Succ '!=' 0}}<span class="font-bold">{{addComma p54Succ}}</span><br/>({{addComma p54Fail}})<br/>({{average p54Fail p54Succ}}%){{else}}{{#dalbit_if p54Fail '!=' 0}}<span class="font-bold">{{addComma p54Succ}}</span><br/>({{addComma p54Fail}})<br/>({{average p54Fail p54Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="55" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p55Succ '!=' 0}}<span class="font-bold">{{addComma p55Succ}}</span><br/>({{addComma p55Fail}})<br/>({{average p55Fail p55Succ}}%){{else}}{{#dalbit_if p55Fail '!=' 0}}<span class="font-bold">{{addComma p55Succ}}</span><br/>({{addComma p55Fail}})<br/>({{average p55Fail p55Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="56" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p56Succ '!=' 0}}<span class="font-bold">{{addComma p56Succ}}</span><br/>({{addComma p56Fail}})<br/>({{average p56Fail p56Succ}}%){{else}}{{#dalbit_if p56Fail '!=' 0}}<span class="font-bold">{{addComma p56Succ}}</span><br/>({{addComma p56Fail}})<br/>({{average p56Fail p56Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="57" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p57Succ '!=' 0}}<span class="font-bold">{{addComma p57Succ}}</span><br/>({{addComma p57Fail}})<br/>({{average p57Fail p57Succ}}%){{else}}{{#dalbit_if p57Fail '!=' 0}}<span class="font-bold">{{addComma p57Succ}}</span><br/>({{addComma p57Fail}})<br/>({{average p57Fail p57Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="58" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p58Succ '!=' 0}}<span class="font-bold">{{addComma p58Succ}}</span><br/>({{addComma p58Fail}})<br/>({{average p58Fail p58Succ}}%){{else}}{{#dalbit_if p58Fail '!=' 0}}<span class="font-bold">{{addComma p58Succ}}</span><br/>({{addComma p58Fail}})<br/>({{average p58Fail p58Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="61" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p61Succ '!=' 0}}<span class="font-bold">{{addComma p61Succ}}</span><br/>({{addComma p61Fail}})<br/>({{average p61Fail p61Succ}}%){{else}}{{#dalbit_if p61Fail '!=' 0}}<span class="font-bold">{{addComma p61Succ}}</span><br/>({{addComma p61Fail}})<br/>({{average p61Fail p61Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="92" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p92Succ '!=' 0}}<span class="font-bold">{{addComma p92Succ}}</span><br/>({{addComma p92Fail}})<br/>({{average p92Fail p92Succ}}%){{else}}{{#dalbit_if p92Fail '!=' 0}}<span class="font-bold">{{addComma p92Succ}}</span><br/>({{addComma p92Fail}})<br/>({{average p92Fail p92Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="93" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p93Succ '!=' 0}}<span class="font-bold">{{addComma p93Succ}}</span><br/>({{addComma p93Fail}})<br/>({{average p93Fail p93Succ}}%){{else}}{{#dalbit_if p93Fail '!=' 0}}<span class="font-bold">{{addComma p93Succ}}</span><br/>({{addComma p93Fail}})<br/>({{average p93Fail p93Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="94" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p94Succ '!=' 0}}<span class="font-bold">{{addComma p94Succ}}</span><br/>({{addComma p94Fail}})<br/>({{average p94Fail p94Succ}}%){{else}}{{#dalbit_if p94Fail '!=' 0}}<span class="font-bold">{{addComma p94Succ}}</span><br/>({{addComma p94Fail}})<br/>({{average p94Fail p94Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="95" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p95Succ '!=' 0}}<span class="font-bold">{{addComma p95Succ}}</span><br/>({{addComma p95Fail}})<br/>({{average p95Fail p95Succ}}%){{else}}{{#dalbit_if p95Fail '!=' 0}}<span class="font-bold">{{addComma p95Succ}}</span><br/>({{addComma p95Fail}})<br/>({{average p95Fail p95Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" onmouseover="mouseover($(this));" onmouseout="mouseout($(this));" onclick="dayDetailPopup($(this))" data-type="96" data-startdate="{{the_date}}" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if p96Succ '!=' 0}}<span class="font-bold">{{addComma p96Succ}}</span><br/>({{addComma p96Fail}})<br/>({{average p96Fail p96Succ}}%){{else}}{{#dalbit_if p96Fail '!=' 0}}<span class="font-bold">{{addComma p96Succ}}</span><br/>({{addComma p96Fail}})<br/>({{average p96Fail p96Succ}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="_fontColor" data-fontcolor="{{#dalbit_if data.gb '==' 'm'}}blue{{/dalbit_if}}{{#dalbit_if data.gb '==' 'f'}}red{{/dalbit_if}}">{{#dalbit_if totSucc '!=' 0}}<span class="font-bold">{{addComma totSucc}}</span><br/>({{addComma totFail}})<br/>({{average totFail totSucc}}%){{else}}{{#dalbit_if totFail '!=' 0}}<span class="font-bold">{{addComma totSucc}}</span><br/>({{addComma totFail}})<br/>({{average totFail totSucc}}%){{/dalbit_if}}{{/dalbit_if}}</td>
    <td class="detailTotal _bgColor font-bold" data-bgcolor="#bfbfbf" data-month="{{data.the_date}}">
        <span style="display: none">{{the_date}}</span>
        <span class="_fontColor" data-fontcolor="#ca6927">{{addComma accumTotSucc}}</span><br/>({{addComma accumTotFail}})<br/>({{average accumTotFail accumTotSucc}}%)
    </td>
    </tr>
    {{else}}
        <td colspan="14" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>