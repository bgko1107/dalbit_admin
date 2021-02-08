<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 현재 접속자 > 현재 접속 회원 -->
<div class="widget-table mb10">
    <div class="col-md-12 no-padding">
        <%--<div class="col-md-2 no-padding">--%>
        <%--</div>--%>
        <div class="col-md-12 no-padding pull-right mt5">
            <span name="guestType" id="guestType" onchange="guestType_sel_change()"></span>
            <div class="col-md-2 no-padding pull-right">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="15%"/><col width="65%"/>
                    </colgroup>
                    <tr>
                        <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                    </tr>
                </table>
            </div>
        </div>
        <table id="guest_tableList" class="table table-sorting table-hover table-bordered datatable">
            <thead id="tableTop_detail">
            </thead>
            <tbody id="tableBody_detail">
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript" src="/js/code/broadcast/broadCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    $(function(){
        $("#guestType").html(util.getCommonCodeSelect(0, liveGuest));
    });

    var dtList_info_guest;

    function getliveGuest_tabClick(tmp){
        liveState = tmp;
        if(liveState == 5){
            $("#divLive").hide();
            $("#divLiveListen").hide();
            $("#divLiveGuest").show();
            $("#divLivelogin").hide();
            $("#seldate").hide();
        }
        var dtList_data = function (data) {
            data.pageCnt = 100;
            data.searchText = $("#searchText").val();
            data.orderType = $("select[name='liveGuest']").val();
            data.startDate = $("#onedayDate").val();
            data.slctType = 0;
            data.newSearchType = slctType == 1 ? $("#searchMember").val() : $("#searchBroad").val();
        };
        dtList_info_guest = new DalbitDataTable($("#guest_tableList"), dtList_data, BroadcastDataTableSource.liveGuestList);
        dtList_info_guest.setPageLength(100);
        dtList_info_guest.useCheckBox(false);
        dtList_info_guest.useIndex(true);
        dtList_info_guest.createDataTable(liveGuest_summary);

        livePageTabCount();
    }

    function liveGuest_summary(json){

        if(json.result == "success"){
            json.summary.guestTotal = json.summary.guestMcnt  + json.summary.guestFcnt + json.summary.guestNcnt;
            json.summary.uniqueTotal = json.summary.uniqueMcnt  + json.summary.uniqueFcnt + json.summary.uniqueNcnt;
            json.summary.totalCnt = json.summary.normalCnt  + json.summary.secretCnt;
            json.summary.totalByeol = json.summary.normalByeol  + json.summary.secretByeol;

            var template = $("#liveGuest_tableSummary").html();
            var templateScript = Handlebars.compile(template);
            var data = {
                content : json.summary
                , length : json.recordsTotal
            };
            var html = templateScript(data);
            $("#liveGuest_summaryArea").html(html);
        }
    }

    function guestType_sel_change(){
        dtList_info_guest.reload(liveGuest_summary);
        livePageTabCount();
    }

    function guestOut(index){
        var data = dtList_info_guest.getDataRow(index);
        console.log(data);
        util.getAjaxData("type", "/rest/broadcast/guest/out", data, guest_out_success);
    }
    function guest_out_success(dst_id, response) {
        alert(response.message);
        guestType_sel_change();
    }

    function reportPopup(index){
        var data = dtList_info_guest.getDataRow(index);

        console.log(data);
        var report = "/member/member/popup/reportPopup?"
            + "memNo=" + encodeURIComponent(data.mem_no)
            + "&memId=" + encodeURIComponent(data.mem_userid)
            + "&memNick=" + encodeURIComponent(common.replaceHtml(data.mem_nick))
            + "&memSex=" + encodeURIComponent(data.mem_sex)
            + "&deviceUuid=" + data.device_uuid
            + "&ip=" + data.ip;

        util.windowOpen(report,"750","910","clipReport");
    }

</script>

<script id="liveGuest_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 100%">
        <tr>
            <th colspan="7" style="background-color: #2f5597;color: white">게스트</th>
        </tr>
        <tr>
            <th colspan="3" style="background-color: #d9d9d9;color: black">성별</th>
            <th colspan="2" style="background-color: #d9d9d9;color: black">받은 선물<br/>일반(비밀)</th>
            <th style="background-color: #d9d9d9;color: black">게스트 연결 시간</th>
        </tr>
        <tr>
            <td style="background-color: #dae3f3">{{{sexIcon 'm'}}}</td>
            <td style="background-color: #dae3f3">{{{sexIcon 'f'}}}</td>
            <td style="background-color: #dae3f3">{{{sexIcon 'n'}}}</td>
            <td style="background-color: #dae3f3" class="font-bold">건 수</td>
            <td style="background-color: #dae3f3" class="font-bold">별 수</td>
            <td style="background-color: #dae3f3" class="font-bold">일/시/분/초</td>
        </tr>
        <tr>
            <td>{{addComma content.guestMcnt}} ({{addComma content.uniqueMcnt}}) 명</td>
            <td>{{addComma content.guestFcnt}} ({{addComma content.uniqueFcnt}}) 명</td>
            <td>{{addComma content.guestNcnt}} ({{addComma content.uniqueNcnt}}) 명</td>
            <td>{{addComma content.normalCnt}}({{addComma content.secretCnt}}) 건</td>
            <td>{{addComma content.normalByeol}}({{addComma content.secretByeol}}) 별</td>
            <td>{{timeStampDay content.totalConnect}}</td>
        </tr>
        <tr>
            <td colspan="3" class="font-bold" style="background-color: #7f7f7f;color: white">총 연결 수 : {{content.guestTotal}} ({{content.uniqueTotal}})</td>
            <td colspan="3" class="font-bold" style="background-color: #7f7f7f;color: white">총 받은 선물 : {{content.totalCnt}}건/{{content.totalByeol}}별</td>
        </tr>
    </table>
</script>