<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">
            <span id="questDate"></span>
            <div class="col-lg-12 no-padding">
                <div class="widget widget-table">
                    <div class="widget-content">
                        <table class="table table-sorting table-hover table-bordered datatable">
                            <colgroup>
                                <col width="2%"/><col width="16.3%"/><col width="16.3%"/><col width="5.3%"/><col width="5.3%"/>
                                <col width="5.3%"/><col width="5.3%"/>
                            </colgroup>
                            <thead>
                                <th>No</th>
                                <th>퀘스트명</th>
                                <th>상세 내용</th>
                                <th>보상</th>
                                <th>한달 목표</th>
                                <th>현재 달성</th>
                                <th>지급 완료</th>
                            </thead>
                            <tbody id="quest_tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-12 no-padding mt15" id="div_questDetailTitle" style="display: none">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
                    <li class="active"><a href="#" role="tab" data-toggle="tab" id="questDetailTitle"></a></li>
                </ul>
                <span id="questDetail"></span>
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

        $("#div_questDetailTitle").hide();

        var data = {};
        data.questDate = $('#startDate').val().substr(0,7).replace(".","-");
        data.searchText = memNo;
        data.slctType = 0;

        util.getAjaxData("quest", "/rest/member/quest/list", data, fn_quest_success);
    }

    function fn_quest_success(dst_id, response) {
        var template = $('#tmp_questList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#quest_tableBody").html(html);

    }

    function questNoDetailList(tmp){
        var data = {};
        data.questDate = $('#startDate').val().substr(0,7).replace(".","-");
        data.searchText = memNo;
        data.slctType = 1;
        data.questNo = tmp.questno;

        util.getAjaxData("quest", "/rest/member/quest/detail/list", data, fn_quest_detail_success);
    }

    function fn_quest_detail_success(dst_id, response, param) {
        $("#questDetail").empty();
        if(param.questNo == 1){
            var template = $('#tmp_quest1DetailList').html();
        }else if(param.questNo == 2){
            var template = $('#tmp_quest2DetailList').html();
        }else if(param.questNo == 3){
            var template = $('#tmp_quest3DetailList').html();
        }else if(param.questNo == 4){
            var template = $('#tmp_quest4DetailList').html();
        }else if(param.questNo == 5){
            var template = $('#tmp_quest5DetailList').html();
        }else if(param.questNo == 6 || param.questNo == 7){
            var template = $('#tmp_quest6DetailList').html();
        }else if(param.questNo == 8){
            var template = $('#tmp_quest8DetailList').html();
        }

        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $("#questDetail").html(html);

        $("#div_questDetailTitle").show();
        $("#questDetailTitle").text(response.summary.questName);

    }

</script>

<script id="tmp_questList" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr>
        <td>{{rowNumDesc ../length @index}}</td>
        <td>
            {{#dalbit_if questNo '==' 99}}
                {{questName}}
            {{else}}
                <a href="javascript://" data-questNo="{{questNo}}" onclick="questNoDetailList($(this).data());">{{questName}}</a>
            {{/dalbit_if}}
        </td>
        <td>{{questDesc}}</td>
        <td>{{reward}}</td>
        <td>{{goalCnt}}</td>
        <td>{{successCnt}}</td>
        <td>{{#dalbit_if rewardYn '==' 1}} Y {{else}} N {{/dalbit_if}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="7">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>

<script id="tmp_quest1DetailList" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered datatable">
        <colgroup>
            <col width="2%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/>
        </colgroup>
        <thead>
            <th>No</th>
            <th>DJ 회원 정보</th>
            <th>DJ 닉네임</th>
            <th>등록일</th>
        </thead>
        <tbody>
            {{#each this as |data|}}
            <tr>
                <td>{{rowNumDesc ../length @index}}</td>
                <td>{{{memNoLink memNo memNo}}}</td>
                <td>{{memNick}}</td>
                <td>{{lastUpdDate}}</td>
            </tr>
            {{else}}
            <tr>
                <td colspan="4">{{isEmptyData}}</td>
            </tr>
            {{/each}}
        </tbody>
    </table>
</script>

<script id="tmp_quest2DetailList" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered datatable">
        <colgroup>
            <col width="2%"/><col width="16.3%"/><col width="16.3%"/>
        </colgroup>
        <thead>
            <th>No</th>
            <th>대화일시</th>
            <th>메시지 참여회원</th>
        </thead>
        <tbody>
            {{#each this as |data|}}
            <tr>
                <td>{{rowNumDesc ../length @index}}</td>
                <td>{{lastUpdDate}}</td>
                <td>{{{memNoLink memNo memNo}}} <br/> {{memNick}}</td>
            </tr>
            {{else}}
            <tr>
                <td colspan="3">{{isEmptyData}}</td>
            </tr>
            {{/each}}
        </tbody>
    </table>
</script>

<script id="tmp_quest3DetailList" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered datatable">
        <colgroup>
            <col width="2%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/>
        </colgroup>
        <thead>
        <th>No</th>
        <th>DJ 회원정보</th>
        <th>방송제목</th>
        <th>좋아요 클릭 일시</th>
        </thead>
        <tbody>
        {{#each this as |data|}}
        <tr>
            <td>{{rowNumDesc ../length @index}}</td>
            <td>{{{memNoLink memNo memNo}}} <br/> {{memNick}}</td>
            <td>{{{roomNoLink title linkIdx}}}</td>
            <td>{{lastUpdDate}}</td>
        </tr>
        {{else}}
        <tr>
            <td colspan="4">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<script id="tmp_quest4DetailList" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered datatable">
        <colgroup>
            <col width="2%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/>
            <col width="16.3%"/><col width="16.3%"/>
        </colgroup>
        <thead>
            <th>No</th>
            <th>청취일시 클릭 일시</th>
            <th>등록회원 정보</th>
            <th>주제</th>
            <th>클립번호</th>
            <th>클립 제목</th>
            <th>청취시간</th>
        </thead>
        <tbody>
        {{#each this as |data|}}
        <tr>
            <td>{{rowNumDesc ../length @index}}</td>
            <td>{{lastUpdDate}}</td>
            <td>{{{memNoLink memNo memNo}}} <br/> {{memNick}}</td>
            <td>{{{getCommonCodeLabel subjectType 'clipSubjectType'}}}</td>
            <td>{{{roomNoLink linkIdx linkIdx}}}</td>
            <td>{{{roomNoLink title linkIdx}}}</td>
            <td>{{lastUpdDate}}</td>
        </tr>
        {{else}}
        <tr>
            <td colspan="7">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>


<script id="tmp_quest5DetailList" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered datatable">
        <colgroup>
            <col width="2%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/>
            <col width="16.3%"/><col width="16.3%"/>
        </colgroup>
        <thead>
        <th>No</th>
        <th>등록회원 정보</th>
        <th>방송 / 클립</th>
        <th>제목</th>
        <th>공유일시</th>
        </thead>
        <tbody>
        {{#each this as |data|}}
        <tr>
            <td>{{rowNumDesc ../length @index}}</td>
            <td>{{{memNoLink memNo memNo}}} <br/> {{memNick}}</td>
            <td>{{type}}</td>
            <td>{{{roomNoLink title linkIdx}}}</td>
            <td>{{lastUpdDate}}</td>
        </tr>
        {{else}}
        <tr>
            <td colspan="5">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<script id="tmp_quest6DetailList" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered datatable">
        <colgroup>
            <col width="2%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/>
            <col width="16.3%"/><col width="16.3%"/>
        </colgroup>
        <thead>
        <th>No</th>
        <th>DJ 회원정보</th>
        <th>방송 제목</th>
        <th>청취시간</th>
        </thead>
        <tbody>
        {{#each this as |data|}}
        <tr>
            <td>{{rowNumDesc ../length @index}}</td>
            <td>{{{memNoLink memNo memNo}}} <br/> {{memNick}}</td>
            <td>{{{roomNoLink title linkIdx}}}</td>
            <td>{{timestamp listentime}}</td>
        </tr>
        {{else}}
        <tr>
            <td colspan="4">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>

<script id="tmp_quest8DetailList" type="text/x-handlebars-template">
    <table class="table table-sorting table-hover table-bordered datatable">
        <colgroup>
            <col width="2%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/><col width="16.3%"/>
            <col width="16.3%"/><col width="16.3%"/>
        </colgroup>
        <thead>
        <th>No</th>
        <th>DJ 회원정보</th>
        <th>아이템명</th>
        <th>선물건수</th>
        <th>선물 달</th>
        <th>선물 일시</th>
        </thead>
        <tbody>
        {{#each this as |data|}}
        <tr>
            <td>{{rowNumDesc ../length @index}}</td>
            <td>{{{memNoLink memNo memNo}}} <br/> {{memNick}}</td>
            <td>{{itemName}}</td>
            <td>{{itemCnt}}</td>
            <td>{{dal}} 달</td>
            <td>{{lastUpdDate}}</td>
        </tr>
        {{else}}
        <tr>
            <td colspan="6">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>