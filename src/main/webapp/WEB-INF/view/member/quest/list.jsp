<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">
            <span id="questDate"></span>
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-content">
                        <table class="table table-sorting table-hover table-bordered datatable">
                            <colgroup>
                                <col width="2%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/>
                                <col width="16.3%"/><col width="16.3%"/>
                            </colgroup>
                            <thead>
                                <th>No</th>
                                <th>퀘스트명</th>
                                <th>상세 내용</th>
                                <th>보상</th>
                                <th>한달 목표</th>
                                <th>현재 달성</th>
                                <th>지지급 완료</th>
                            </thead>
                            <tbody id="quest_tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    function questList(){
        $("#questDate").html($('#searchDate').html());
        $("#searchDate").show();

        slctType = 1;
        dateType();

        $("#bt_search").on("click", function(){
            getQuestList();
        });
        getQuestList();

    }
    function getQuestList(){

        var data = {};
        data.startDate = $('#startDate').val();
        data.endDate = $('#endDate').val();
        data.memNo = memNo;

        util.getAjaxData("quest", "/rest/member/member/quest/list", data, fn_quest_success);
    }

    function fn_quest_success(dst_id, response) {
        var template = $('#tmp_questList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $("#quest_tableBody").html(html);

    }

</script>

<script id="tmp_questList" type="text/x-handlebars-template">
    {{#each}}
    <tr>
        <td>{{indexDesc ../loginHistCnt rowNum}}</td>
        <td>{{last_upd_date}}</td>
        <td>{{{sexIcon mem_sex}}}</td>
        <td>{{ip}}</td>
        <td style="text-align:left">{{device_uuid}}</td>
        <td style="text-align:left">{{device_token}}</td>
        <td>{{{getCommonCodeLabel os_type 'loginHistoryOsType'}}}</td>
        <td>{{browser}}</td>
        <td>{{app_version}}</td>
        <td>{{location}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="7">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>