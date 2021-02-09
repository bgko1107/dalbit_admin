<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 클립관리 > 클립내역관리 > 클립청취 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate" style="display: none;"></span>
        <%--<span class="pull-right">--%>
            <%--<div class="pull-left" style="width:30px; height:30px; background-color: #dae3f3; border:1px solid #cccccc;"></div>--%>
            <%--<div class="pull-left pl10 pt5" style="width:105px; height:30px; border:1px solid #cccccc; border-left-width: 0px;">테스트 아이디</div>--%>
        <%--</span>--%>
        <select id="clipListenSort" name="clipListenSort" class="form-control searchType" onchange="initDataTable_clipHistoryListen_reload();">
            <option value="0" selected="selected">최근</option>
            <option value="2">좋아요</option>
            <option value="4">선물달</option>
        </select>
        <span id="clipListen_summaryArea"></span>
        <table id="clip_history_listen_list_info" class="table table-sorting table-hover table-bordered">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript" src="/js/dataTablesSource/clip/clipHistoryDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/clip/clipCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    $(function(){

    });

    function getHistory_clipListenList(tmp){
        getClipSubjectTypeCodeDefine();

        initDataTable_clipHistoryListen(tmp);
    }

    var dtList_info;
    function initDataTable_clipHistoryListen(tmp) {
        if(common.isEmpty(memNo)){
            return;
        }

        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = MemberDataTableSource[tmp];

        //=---------- Main DataTable ----------
        var dtList_info_detail_data = function (data) {
            data.targetMemNo = memNo;
            data.orderByType = $("#clipListenSort").val();
        };

        dtList_info_detail = new DalbitDataTable($("#clip_history_listen_list_info"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.setPageLength(50);
        dtList_info_detail.createDataTable(selectCallback_clipHistotyListen);

        //---------- Main DataTable ----------=
    };

    function selectCallback_clipHistotyListen(data){
        // 탭 우측 총 건수 추가
        var text = "<span style='color: black;'>클립 청취 수 :</span>" +
            "<span style='color: darkblue; font-weight: bold; '> " +  common.addComma(data.pagingVo.totalCnt) + " 건</span>" +
            "<span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>" +
            "<span style='color: blue; font-weight: bold; '>남성 : " +  common.addComma(data.summary.manTotalCnt) + " 건, </span>" +
            "<span style='color: red; font-weight: bold; '>여성 : " +  common.addComma(data.summary.femaleTotalCnt) + " 건, </span>" +
            "<span style='color: black; font-weight: bold; '>알수없음 : " +  common.addComma(data.summary.unknownTotalCnt) + " 건</span>";

        $("#headerInfo").html(text);
        $("#headerInfo").show();

        var data = {
            memNo : memNo
        };
        util.getAjaxData("selectReply", "/rest/clip/history/listen/member/list/summary", data, clipListen_tableSummary_table);

    }

    function clipListen_tableSummary_table(dst_id, response){
        var template = $("#clipListen_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : response.data
        };
        var html = templateScript(data);
        $("#clipListen_summaryArea").html(html);

        ui.paintColor();
    }

    function initDataTable_clipHistoryListen_reload(){
        dtList_info_detail.reload(selectCallback_clipHistotyListen);
    }

</script>


<script id="tmp_codeDefine" type="text/x-handlebars-template">
    <select name="slctType" id="slctType" class="form-control">
        {{#each this as |sub|}}
        <option value="{{sub.value}}">{{sub.code}}</option>
        {{/each}}
    </select>
</script>

<script id="clipListen_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right" id="declarationSummary" style="width: 500px;">
        <thead>
        <tr>
            <th colspan="5" class="_bgColor" data-bgcolor="#8faadc">총 합</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#dae3f3">청취자</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">청취수</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">선물 건</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">보낸 달</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">좋아요</th>
        </tr>
        </thead>
        <tbody>
        <td>{{addComma content.listenerCnt}} 명</td>
        <td>{{addComma content.countPlay}} 건</td>
        <td>{{addComma content.countGift}} 건</td>
        <td>{{addComma content.countDal}} 달</td>
        <td>{{addComma content.countGood}} 개</td>
        </tbody>
    </table>
</script>