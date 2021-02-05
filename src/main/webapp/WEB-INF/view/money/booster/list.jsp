<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- serachBox -->
<form id="searchForm">
    <div class="row col-lg-12 form-inline">
        <div class="col-md-9 no-padding">
            <div class="widget widget-table searchBoxArea">
                <div class="widget-header searchBoxRow">
                    <h3 class="title"><i class="fa fa-search"></i> 검색조건</h3>
                    <div>
                        <span id="searchTypeArea" class="_show_histList"></span>
                        <input type="text" class="form-control _show_histList" name="searchText" id="searchText" />

                        <div class="input-group date" id="seldate">
                            <label for="onedayDate" class="input-group-addon">
                                <span><i class="fa fa-calendar" id="seldateDateBtn"></i></span>
                            </label>
                            <input type="text" class="form-control" id="onedayDate" name="onedayDate" style="width: 110px">
                        </div>

                        <%--<label><input type="text" class="form-control" id="txt_search"></label>--%>
                        <button type="button" class="btn btn-success" id="bt_search">검색</button>
                        <input type="text" value="" style="display:none;" />
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 pull-right no-padding" id="divLive">
            <span id="live_summaryArea"></span>
            <%--<span id="dj_typeSummaryArea"></span>--%>
            <%--<span id="platform_summaryArea"></span>--%>
        </div>

    </div>
</form>
<!-- //serachBox -->
<!-- DATA TABLE -->
<div class="row col-lg-12 form-inline">

    <div class="col-md-12">
        <label id="liveTitle">
            ㆍ부스터 아이템의 경우 방송방에서 달로 구매하는 부스터가 아닙니다.<br/>
            ㆍ이벤트 및 스페셜 DJ 혜택 등으로 제작된 부스터로 본인의 방송방에만 사용 가능합니다.<br/>
            ㆍ부스터 아이템은 사용 시 DJ에게 달이 지급되지 않습니다.<br/>
            ㆍ부스터 아이템으로 획득한 좋아요는 실시간 방송 순위에만 반영됩니다.
        </label>
    </div>

    <!-- DATA TABLE -->
    <ul class="nav nav-tabs nav-tabs-custom-colored mt5" id="boosterTab">
        <li class="active"><a href="javascript://" role="tab" data-toggle="tab" id="stat_day">시간대</a></li>
        <li><a href="javascript://" role="tab" data-toggle="tab" id="stat_month">월간</a></li>
        <li><a href="javascript://" role="tab" data-toggle="tab" id="stat_year">연간</a></li>
        <li><a href="javascript://" role="tab" data-toggle="tab" id="list_hist">상세내역</a></li>
        <%--<li><a href="#liveList" role="tab" data-toggle="tab" id="tab_endBrodList" onclick="liveList(2);">종료 방송</a></li>--%>
    </ul>
    <div class="tab-content no-padding" id="layoutDiv"></div>
</div>
<!-- DATA TABLE END -->

<jsp:include page="/WEB-INF/view/common/util/select_memeberBoosterList.jsp"></jsp:include>

<script type="text/javascript" src="/js/code/money/boosterCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/moneyHelper.js?${dummyData}"></script>
<script type="text/javascript">
    var date = new Date();
    var sDate;
    var eDate;

    var boostHistPagingInfo = new PAGING_INFO(0, 1, 30);

    $("#onedayDate").val(date.getFullYear() +"-"+ common.lpad(date.getMonth() + 1,2,"0") +"-"+ common.lpad(date.getDate(),2,"0"));
    $('#seldate').datetimepicker({
        format: 'L',
        maxDate:new Date(),
        format: "YYYY-MM-DD",
    });
    sDate = date.getFullYear()  +"-"+ common.lpad(date.getMonth() + 1,2,"0")  +"-"+ common.lpad(date.getDate(),2,"0");        //오늘

    $(document).ready(function() {

        $("#searchTypeArea").html(util.getCommonCodeSelect(-1, search_boostHist_type));

        getSearch();

        $('input[id="searchText"]').on('keydown', function(e) {    // textBox 처리
            if(e.keyCode == 13) {
                exchangePagingInfo.pageNo = 1;
                getSearch();
            };
        });
    });


    $(document).on('click', '#bt_search', function(){
        boostHistPagingInfo.pageNo = 1;
        getSearch();
    });

    $(document).on('click', '#boosterTab li a', function(){
        boostHistPagingInfo.pageNo = 1;
        getSearch();
    });

    $('._show_histList').hide();

    function getSearch(){
        var tabId = $('#boosterTab li.active a').prop('id');
        $('._show_histList').hide();
        if(tabId == 'stat_day'){
            getDaySearch();
        }else if(tabId == 'stat_month'){
            getMonthSearch();
        }else if(tabId == 'stat_year'){
            getYearSearch();
        }else if(tabId == 'list_hist'){

            $('._show_histList').show();
            getHistoryList();
        }
    }

    function goSearch(data){
        //레이아웃 변경
        var template = $("#tmp_statLayout").html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#layoutDiv").html(html);

        if(common.isEmpty(data)){
            data = {
                slctType : 0
                , startDate : $("#onedayDate").val()
                , endDate : $("#onedayDate").val()
            }
        }
        util.getAjaxData("stat_day", "/rest/money/booster/stat", data, function(dist_id, response, param){
            var template = $("#tmp_statDayList").html();
            var templateScript = Handlebars.compile(template);

            //소계 증감
            if(!common.isEmpty(response.data) && !common.isEmpty(response.data.summary)){
                response.data.summary.sum_totalInCnt = response.data.summary.sum_userInCnt + response.data.summary.sum_testInCnt;
                response.data.summary.sum_totalOutCnt = response.data.summary.sum_userOutCnt + response.data.summary.sum_testOutCnt + response.data.summary.sum_userUseCnt + response.data.summary.sum_testUseCnt;
                response.data.summary.total_cnt = response.data.summary.sum_totalInCnt - response.data.summary.sum_totalOutCnt;
            }

            //리스트 증감
            if(!common.isEmpty(response.data) && !common.isEmpty(response.data.list)){
                response.data.list.forEach(function(item, index){
                    response.data.list[index].total_InCnt = item.userInCnt + item.testInCnt;
                    response.data.list[index].total_OutCnt = item.userOutCnt + item.testOutCnt + item.userUseCnt + item.testUseCnt;
                    response.data.list[index].total_cnt = response.data.list[index].total_InCnt - response.data.list[index].total_OutCnt;
                });
            }

            response.data.param = param;
            var html = templateScript(response.data);
            $("#tableBody").html(html);

            //상단 합계
            var template = $("#tmp_totalTable").html();
            var templateScript = Handlebars.compile(template);
            var html = templateScript(response.data.summary);
            $("#tableTotal").html(html);

            ui.paintColor();
        });
    }

    function getDaySearch(){
        var data = {
            slctType : 0
            , startDate : $("#onedayDate").val()
            , endDate : $("#onedayDate").val()
        }
        goSearch(data);
    }

    function getMonthSearch(){

        var startDate = moment($("#onedayDate").val()).format('YYYY-MM-01');
        var endDate =  moment(startDate).add('months', 1).add('days', -1).format('YYYY-MM-DD');

        var data = {
            slctType : 1
            , startDate : startDate
            , endDate : endDate
        }
        goSearch(data);
    }

    function getYearSearch(){

        var startDate = moment($("#onedayDate").val()).format('YYYY-01-01');
        var endDate =  moment(startDate).format('YYYY-12-31');

        var data = {
            slctType : 2
            , startDate : startDate
            , endDate : endDate
        }
        goSearch(data);
    }

    function summary_table(json){
        var template = $("#live_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        };
        var html = templateScript(data);
        $("#live_summaryArea").html(html);

        ui.paintColor();

    }

    function getHistoryList(){
        //레이아웃 변경
        var template = $("#tmp_histLayout").html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#layoutDiv").html(html);

        var data = {
            startDate : $("#onedayDate").val()
            , pageNo : boostHistPagingInfo.pageNo
            , pageCnt : boostHistPagingInfo.pageCnt
            , searchType : $("#searchForm #search_type").val()
            , searchText : $("#searchForm #searchText").val()
        }
        util.getAjaxData("histList", "/rest/money/booster/histList", data, function(dist_id, response, param){
            var template = $("#tmp_histList").html();
            var templateScript = Handlebars.compile(template);
            var html = templateScript(response.data);
            $("#tableBodyHist").html(html);

            if(!common.isEmpty(response.data.paging)){
                boostHistPagingInfo.totalCnt = response.data.paging.totalCnt;
                util.renderPagingNavigation('histList_paginate', boostHistPagingInfo);
            }
        });
    }

    function handlebarsPaging(targetId, pagingInfo){
        specialDjPagingInfo = pagingInfo;
        getHistoryList();
    }

    $(document).on('click', '#bt_member_search', function () {
        showPopMemberList(choiceMember);
    });

    function choiceMember(data) {
        console.log(data);
        var html = '<a href="javascript://" class="_openMemberPop" data-memno="'+data.mem_no+'">'+data.mem_nick+'</a>';
        html += ' <a href="javascript://" class="_deleteMem _fontColor" data-fontColor="red"><i class="fa fa-trash-o"></i></a>';

        var regMemberLength = $("#weeklyForm").find('._openMemberPop').length;
        var tabId = $("#tablist_con li.active a").prop('id');

        if(tabId == 'tab_weekly' && regMemberLength == 2){
            alert("위클리픽은 최대 2명까지 지정 가능합니다.");
            return false;
        }

        if(tabId == 'tab_second' && regMemberLength == 1){
            alert("15초 광고 모델은 1명만 지정 가능합니다.");
            return false;
        }


        //이미 등록된 회원인지 체크
        if(0 < $('._openMemberPop[data-memno="'+data.mem_no+'"]').length){
            alert('이미 등록된 회원입니다.');
            return false;
        }

        $("#weeklyForm").find('._regMemberArea').each(function(){
            if($(this).find('._openMemberPop').length == 0){
                $(this).html(html);
                return false;
            }
        });

        ui.paintColor();
    }
</script>

<script id="tmp_statLayout" type="text/x-handlebars-template">
    <div class="tab-pane fade in active" id="liveList">
        <div class="widget widget-table">
            <div class="widget-content mt10" style="border-top-width:0px;">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                        <col width="10%"/>
                    </colgroup>
                    <tr>
                        <td rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">부스터 아이템<br />현황</td>
                        <td class="_bgColor" data-bgcolor="#dae3f3">유저 지급</td>
                        <td class="_bgColor" data-bgcolor="#dae3f3">테스트 지급</td>
                        <td class="_bgColor" data-bgcolor="#dae3f3">증가 합</td>

                        <td class="_bgColor" data-bgcolor="#FFDEAD">유저 차감</td>
                        <td class="_bgColor" data-bgcolor="#FFDEAD">테스트 차감</td>
                        <td class="_bgColor" data-bgcolor="#FFDEAD">유저 사용</td>
                        <td class="_bgColor" data-bgcolor="#FFDEAD">테스트 사용</td>
                        <td class="_bgColor" data-bgcolor="#FFDEAD">감소 합</td>

                        <td class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white">총합</td>
                    </tr>
                    <tr id="tableTotal"></tr>
                </table>
            </div>
            <div class="widget-content" style="border-top-width:0px;">
                <table id="list_info" class="table table-sorting table-hover table-bordered">
                    <thead id="tableTop">
                        <tr>
                            <th rowspan="2">구분</th>
                            <th colspan="3" class="_bgColor" data-bgcolor="#DAE3F3">아이템 증가</th>
                            <th colspan="5" class="_bgColor" data-bgcolor="#FFDEAD">아이템 감소</th>
                            <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white">총합</th>
                            <%--<th rowspan="2">증감</th>--%>
                        </tr>
                        <tr>
                            <td class="_bgColor" data-bgcolor="#DAE3F3">유저 지급</td>
                            <td class="_bgColor" data-bgcolor="#DAE3F3">테스트 지급</td>
                            <td class="_bgColor" data-bgcolor="#DAE3F3">증가 합</td>

                            <td class="_bgColor" data-bgcolor="#FFDEAD">유저 차감</td>
                            <td class="_bgColor" data-bgcolor="#FFDEAD">테스트 차감</td>
                            <td class="_bgColor" data-bgcolor="#FFDEAD">유저 사용</td>
                            <td class="_bgColor" data-bgcolor="#FFDEAD">테스트 사용</td>
                            <td class="_bgColor" data-bgcolor="#FFDEAD">감소 합</td>

                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>
        </div>
    </div>
</script>

<script id="tmp_statDayList" type="text/x-handlebars-template">
    {{#if this.summary}}
        <tr>
            <td>소계</td>
            <td>{{addComma summary.sum_userInCnt}}</td>
            <td>{{addComma summary.sum_testInCnt}}</td>
            <td class="{{upAndDownClass summary.sum_totalInCnt}}"><i class="fa {{upAndDownIcon summary.sum_totalInCnt}}"></i> {{addComma summary.sum_totalInCnt}}</td>
            <td>{{addComma summary.sum_userOutCnt}}</td>
            <td>{{addComma summary.sum_testOutCnt}}</td>
            <td>{{addComma summary.sum_userUseCnt}}</td>
            <td>{{addComma summary.sum_testUseCnt}}</td>
            <td class="{{upAndDownClass summary.sum_totalOutCnt}}"><i class="fa {{upAndDownIcon summary.sum_totalOutCnt}}"></i> {{addComma summary.sum_totalOutCnt}}</td>
            <td class="{{upAndDownClass summary.total_cnt}}"><i class="fa {{upAndDownIcon summary.total_cnt}}"></i> {{addComma summary.total_cnt}}</td>
            <!--<td class="font-bold">{{addComma data.testInCnt}}</td>-->
        </tr>
    {{/if}}

    {{#each this.list as |data|}}
        <tr>
            {{#equal ../param.slctType '0'}}
                <td>{{data.hour}}시</td>
            {{/equal}}
            {{#equal ../param.slctType '1'}}
                <td>{{data.date}}</td>
            {{/equal}}
            {{#equal ../param.slctType '2'}}
                <td>{{data.month}}</td>
            {{/equal}}

            <td>{{addComma data.userInCnt}}</td>
            <td>{{addComma data.testInCnt}}</td>
            <td class="{{upAndDownClass data.total_InCnt}}"><i class="fa {{upAndDownIcon data.total_InCnt}}"></i> {{data.total_InCnt}}</td>
            <td>{{addComma data.userOutCnt}}</td>
            <td>{{addComma data.testOutCnt}}</td>
            <td>{{addComma data.userUseCnt}}</td>
            <td>{{addComma data.testUseCnt}}</td>
            <td class="{{upAndDownClass data.total_OutCnt}}"><i class="fa {{upAndDownIcon data.total_OutCnt}}"></i> {{data.total_OutCnt}}</td>
            <td class="{{upAndDownClass data.total_cnt}}"><i class="fa {{upAndDownIcon data.total_cnt}}"></i> {{data.total_cnt}}</td>
            <!--<td class="font-bold">{{addComma data.testInCnt}}</td>-->
        </tr>
    {{/each}}
</script>

<script id="tmp_totalTable" type="text/x-handlebars-template">
    <td>{{addComma sum_userInCnt}}</td>
    <td>{{addComma sum_testInCnt}}</td>
    <td class="{{upAndDownClass sum_totalInCnt}}"><i class="fa {{upAndDownIcon sum_totalInCnt}}"></i> {{addComma sum_totalInCnt}}</td>
    <td>{{addComma sum_userOutCnt}}</td>
    <td>{{addComma sum_testOutCnt}}</td>
    <td>{{addComma sum_userUseCnt}}</td>
    <td>{{addComma sum_testUseCnt}}</td>
    <td class="{{upAndDownClass sum_totalOutCnt}}"><i class="fa {{upAndDownIcon sum_totalOutCnt}}"></i> {{addComma sum_totalOutCnt}}</td>
    <td class="{{upAndDownClass total_cnt}}"><i class="fa {{upAndDownIcon total_cnt}}"></i> {{addComma total_cnt}}</td>
</script>

<script id="live_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 100%">
        <tr>
            <th colspan="3" class="_bgColor _fontColor" data-bgcolor="black" data-fontcolor="white">현재 총 보유</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#dae3f3">유저 보유</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">테스트 보유</th>
            <th class="_bgColor" data-bgcolor="#dae3f3">총 보유</th>
        </tr>
        <tr>
            <td>10</td>
            <td>20</td>
            <td class="font-bold">30</td>
        </tr>
    </table>
</script>

<script id="tmp_histLayout" type="text/x-handlebars-template">
    <div class="tab-pane fade in active" id="histList" >
        <div class="widget widget-table">
            <div class="widget-content mt10" style="border-top-width:0px;">
                <div class="col-lg-12 row form-inline no-padding mb10">
                        <button type="button" class="btn btn-primary pull-right" id="bt_member_search">운영자 직접지급</button>
                </div>
            </div>

            <div class="widget-content mt10" style="border-top-width:0px;">
                <table id="list_info" class="table table-sorting table-hover table-bordered">
                    <thead id="tableTop">
                        <colgroup>
                            <col width="5%"/>
                            <col width="15%"/>
                            <col width="20%"/>
                            <col width="10%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="20%"/>
                            <col width="15%"/>
                        </colgroup>
                        <tr>
                            <td>No</td>
                            <td>회원번호</td>
                            <td>닉네임</td>
                            <td>성별</td>
                            <td>상태</td>
                            <td>수량</td>
                            <td>보유수량</td>
                            <td>상태 변경 일시</td>
                            <td>처리자명</td>
                        </tr>
                    </thead>
                    <tbody id="tableBodyHist"></tbody>
                </table>
                <div class="dataTables_paginate paging_full_numbers" id="histList_paginate"></div>
            </div>
        </div>
    </div>
</script>

<script id="tmp_histList" type="text/x-handlebars-template">
    {{#each this.list as |data|}}
        <tr>
            <td>{{data.rowNum}}</td>
            <td>{{{memNoLink data.mem_no data.mem_no}}}</td>
            <td>{{data.mem_nick}}</td>
            <td>{{{sexIconBr data.mem_sex data.mem_birth_year}}}</td>
            <td>{{{memberItemState data.state}}}</td>
            <td>{{addComma data.use_cnt}}</td>
            <td>{{addComma data.item_cnt}}</td>
            <td>{{data.last_upd_date}}</td>
            <td>{{data.op_name}}</td>
        </tr>
    {{else}}
        <tr>
            <td colspan="9">
                {{isEmptyData}}
            </td>
        </tr>
    {{/each}}
</script>