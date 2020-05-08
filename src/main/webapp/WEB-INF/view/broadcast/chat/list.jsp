<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-lg-6 no-padding">
    <label>ㆍ방송 중 채팅내역을 확인 할 수 있습니다.<br/>ㆍ회원 닉네임을 클릭하시면 해당 회원의 채팅글만 확인할 수 있습니다.</label>
</div>
<div class="col-lg-6 no-padding">
    <span id="chat_summaryArea"></span>
</div>
<div>
    <form id="chatFrm"></form>
</div>



<script>
    $(document).ready(function() {
    });

    function getBroadHistory_chat(tmp) {     // 상세보기
        dalbitLog(detailData);
        var template = $('#tmp_chatFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = detailData;
        var html=templateScript(context);
        $("#chatFrm").html(html);


        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        console.log("tmp : " + tmp);
        var source = BroadcastDataTableSource[tmp];
        var dtList_info_detail_data = function (data) {
            data.room_no = room_no;
        }
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_chat_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(false);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(chat_summary_table);

        $("#chatLeft").removeClass("col-md-6");
        $("#chatLeft").addClass("col-md-12");
        $("#chatRight").addClass("hide");
    }

    function chat_summary_table(json){
        var template = $("#chat_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            header : chat_summary
            , content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#chat_summaryArea").html(html);
        if(json.code == 0){
            $('#djOs').html(util.getCommonCodeLabel(json.summary.djOs, djOs));
        }
    }
    function targetChat(index){
        $("#chatRight").removeClass("hide");
        var metaData = dtList_info_detail.getDataRow(index);
        $("#chatLeft").removeClass("col-md-12");
        $("#chatLeft").addClass("col-md-6");
        $('#chatRight_title').html(util.memNoLink(metaData.nickname, metaData.mem_no)  + "님의 채팅글");
        var dtList_info_detail_data = function (data) {
            data.room_no = room_no;
            data.mem_no = metaData.mem_no;
        }
        var dblist_chat_detail;
        dblist_chat_detail = new DalbitDataTable($("#list_target_chat"), dtList_info_detail_data, BroadcastDataTableSource.targetchat);
        dblist_chat_detail.useCheckBox(false);
        dblist_chat_detail.useIndex(false);
        dtList_info_detail.setPageLength(15);
        dblist_chat_detail.createDataTable();
    }

</script>

<script id="tmp_chatFrm" type="text/x-handlebars-template">
    <div class="col-md-12 no-padding">
        <table class="table table-bordered table-dalbit" style="margin-bottom: 0px;">
            <colgroup>
                <col width="5%"/><col width="5%"/><col width="10%"/><col width="10%"/><col width="15%"/><col width="55%"/>
            </colgroup>
            <tbody>
            <tr>
                <th>No</th>
                <td id="chatNo">1</td>
                <th>방송OS구분</th>
                <td id="djOs"></td>
                <th>방송제목</th>
                <td>{{title}}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="col-md-12 no-padding" id="chatLeft">
        <table class="table table-bordered" style="margin-bottom: -7px">
            <th>전체 채팅내역</th>
        </table>
        <table id="list_chat_detail" class="table table-sorting table-hover table-bordered datatable">
            <thead></thead>
            <tbody></tbody>
        </table>
    </div>
    <div class="col-md-6 no-padding" id="chatRight">
        <table class="table table-bordered" style="margin-bottom: -7px">
            <th id="chatRight_title"></th>
        </table>
        <table id="list_target_chat" class="table table-sorting table-hover table-bordered datatable">
            <thead></thead>
            <tbody></tbody>
        </table>
    </div>
</script>

<script id="chat_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" style="margin-right: 0px;margin-top: 0px;margin-bottom: 0px;">
        <thead>
        <tr>
            <th>채팅참여자</th>
            <th><i class="fa fa-microphone" style="color: #8556F6"></i>: 달D</th>
            <th><i class="fa fa-volume-up" style="color: #080004"></i>: 청취자</th>
            <th><i class="fa fa-star" style="color: #0036ff"></i>: 게스트</th>
            <th><i class="fa fa-street-view" style="color: #00ff32"></i>: 매니저</th>
            <th><i class="fa fa-bomb" style="color: #ff1600"></i> 강제퇴장자</th>
        </tr>
        </thead>
        <tbody id="summaryDataTable">
            <td>{{#equal length '0'}}0{{/equal}}{{content.chatCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.djCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.listenerCnt}}명</td>
            <td>{{content.guest}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.managerCnt}}명</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.forcedCnt}}명</td>
        </tbody>
    </table>
</script>