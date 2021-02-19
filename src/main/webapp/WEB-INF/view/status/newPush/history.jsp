<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <div class="col-md-12 no-padding">
            <div class="col-md-6 no-padding">
                <span class="_searchDate"></span><br/>
                <span id="push_send_user_aria" onchange="sel_pushChange();"></span>
                <span id="search_platform_aria" onchange="sel_pushChange();"></span>
                <span id="search_sendType_aria" onchange="sel_pushChange();"></span>
                <span id="search_push_slct_aria" onchange="sel_pushChange();"></span>
            </div>
            <div class="col-md-6 no-padding">
                <span id="pushHistory_summaryArea"></span>
            </div>

        </div>

        <table id="push_history_list_info" class="table table-sorting table-hover table-bordered">
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
<div class="div_historyDetail" id="div_historyDetail">
    <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
        <li class="active"><a href="#historyDetail" role="tab" data-toggle="tab" id="tab_historyDetail">Push발송내역 상세정보</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade active in" id="historyDetail"></div>     <!-- 상세 -->
    </div>
</div>
<script type="text/javascript">
    $(document).on('click', "._getPushHistoryDetail", function(){
        var code = $(this).data('idx');
        var data = dtList_info.getDataRow(code);

        historyDetail(data);

        var scrollPosition = $("#tab_historyDetail").offset();
        util.scrollPostion(scrollPosition.top);
    });

    $(function(){
    });

    function getHistory(){
        $("#push_send_user_aria").html(util.getCommonCodeSelect(-1, push_send_user));
        $("#search_platform_aria").html(util.getCommonCodeSelect(-1, content_platform5));
        $("#search_sendType_aria").html(util.getCommonCodeSelect(-1, push_sendType));
        $("#search_push_slct_aria").html(util.getCommonCodeSelect(-1, push_push_slct));

        initDataTable();
        $(".div_historyDetail").hide();
        // util.getAjaxData("total", "/rest/status/push/total", $("#searchForm").serialize(), fn_total_success);
    }

    var dtList_info;
    function initDataTable() {
        //=---------- Main DataTable ----------
        var dtList_info_data = function (data) {
            data.push_send_user = $("#push_send_user").val();
            data.platform = $("#platform").val();
            data.send_type = $("#send_type").val();
            data.push_slct = $("#push_slct").val();
            data.searchText = $("#searchText").val();
            data.newSearchType = $("#searchMember").val();
        };
        dtList_info = new DalbitDataTable($("#push_history_list_info"), dtList_info_data, PushDataTableSource.historyList, $("#searchForm"));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(true);
        dtList_info.setPageLength(20);
        dtList_info.createDataTable(pushHistorySummary);
        //---------- Main DataTable ----------=
    };

    function pushHistorySummary(data){
        console.log(data.summary);

        var template = $("#pushHistory_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript(data.summary);
        $("#pushHistory_summaryArea").html(html);
    }

    function historyDetail(data){
        $(".div_historyDetail").show();
        var template = $('#tmp_pushHistoryDetail').html();
        var templateScript = Handlebars.compile(template);
        var context = data;
        var html = templateScript(context);
        $("#historyDetail").html(html);
    }

    function sel_pushChange(){

        console.log($("#push_send_user").val());

        dtList_info.reload(pushHistorySummary);
    }

    function memberNoticePopup(data){
        var popupUrl = "/status/newPush/popup/detail?mem_no=" + data.memno;
        util.windowOpen(popupUrl,"900","550","알림받기 회원 상세내역");
    }
</script>

<script id="pushHistory_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right">
        <thead>
        <tr>
            <th style="min-width:70px">수신대상</th>
            <th style="min-width:70px">발송건수</th>
            <th style="min-width:70px">성공건수</th>
            <th style="min-width:70px">실패건수</th>
            <th style="min-width:80px">성공율</th>
            <th style="min-width:70px">클릭건수</th>
            <th style="min-width:80px">클릭율</th>
        </tr>
        </thead>
        <tbody id="summaryDataTable">
            <td>{{#if target_cnt}}{{target_cnt}}{{else}}0{{/if}}명</td>
            <td>{{#if target_cnt}}{{send_cnt}}{{else}}0{{/if}}건</td>
            <td>{{#if target_cnt}}{{succ_cnt}}{{else}}0{{/if}}건</td>
            <td>{{#if target_cnt}}{{fail_cnt}}{{else}}0{{/if}}건</td>
            <td>{{#if target_cnt}}{{succ_rate}}{{else}}0{{/if}}%</td>
            <td>{{#if target_cnt}}{{click_cnt}}{{else}}0{{/if}}건</td>
            <td>{{#if target_cnt}}{{click_rate}}{{else}}0{{/if}}%</td>
        </tbody>
    </table>
</script>


<script id="tmp_pushHistoryDetail" type="text/x-handlebars-template">
    <input type="hidden" name="push_idx" value="{{push_idx}}" />
    <div class="row col-md-12">
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th>No</th>
                <td>{{rowNum}}</td>

                <th>노출 OS구분</th>
                <td colspan="2">
                    {{#dalbit_if target_platform '==' '11'}}Android / IOS{{/dalbit_if}}
                    {{#dalbit_if target_platform '==' '10'}}Android{{/dalbit_if}}
                    {{#dalbit_if target_platform '==' '01'}}IOS{{/dalbit_if}}
                </td>
                <th>발송형태</th>
                <td colspan="2">
                    {{#dalbit_if send_type '==' '11'}}PUSH / 알림{{/dalbit_if}}
                    {{#dalbit_if send_type '==' '10'}}PUSH{{/dalbit_if}}
                    {{#dalbit_if send_type '==' '01'}}알림{{/dalbit_if}}
                </td>

                <th>발송일시</th>
                <td colspan="3">{{substr send_date '0' '19'}}</td>
            </tr>
            <tr>
                <th>메시지 제목</th>
                <td colspan="5"><input type="text" class="form-control" name="send_title" id="push-send_title" value="{{send_title}}" style="width:100%; background-color:white;" disabled="disabled"></td>

                <th>수신대상</th>
                <td colspan="5">
                    {{target_cnt}} 명
                </td>
            </tr>
            <tr>
                <th rowspan="2">메시지 내용</th>
                <td rowspan="2" colspan="5">
                    <div>
                        <textarea class="form-control" name="send_cont" id="push-send_cont" rows="5" cols="30" style="width:100%; resize: none; background-color:white;" disabled="disabled" >{{send_cont}}</textarea>
                    </div>
                </td>
                <th>회원번호</th>
                <td colspan="5">
                    <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a>
                </td>
            </tr>
            <tr>
                <th>푸시 타입<br>(이동경로)</th>
                <td colspan="5">{{{getCommonCodeLabel push_type 'push_slctPush3'}}}</td>
            </tr>
            <tr style="display:none;">
                <th>추가정보</th>
                <td colspan="11">
                    {{send_etc}}
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</script>