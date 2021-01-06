<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
<%
    String in_tabType = request.getParameter("tabType");
%>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <input type="hidden" name="pageStart" id="pageStart">
                    <input type="hidden" name="pageCnt" id="pageCnt">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th id="th_bottonList">
                                    <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_dayButton"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <label class="control-inline fancy-radio custom-color-green">
                                        <input type="radio" name="rankType" value='1' checked="checked" />
                                        <span><i></i>일간</span>
                                    </label>
                                    <label class="control-inline fancy-radio custom-color-green">
                                        <input type="radio" name="rankType" value='2' />
                                        <span><i></i>주간</span>
                                    </label>

                                    <input id="onedayDate" type="text" class="form-control" style="width: 196px;"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." style="display: none"></label>

                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">

                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="rankTab">
                    <li><a href="/menu/rank/djRankList?tabType=0" id="tab_rankList"><i class="fa fa-home"></i> DJ랭킹</a></li>
                    <li><a href="/menu/rank/djRankList?tabType=1" id="tab_rankFanList"><i class="fa fa-user"></i> Fan랭킹</a></li>
                    <li><a href="/menu/rank/addDjPoint" id="tab_addDjPoint">DJ가산점</a></li>
                    <li class="active"><a href="#goodRank"><i class="fa fa-user"></i>좋아요랭킹</a></li>
                    <li><a href="/menu/rank/awardsVote" id="tab_awardsVote">어워즈 투표현황</a></li>
                    <li><a href="/menu/rank/awardsVoteMember" id="tab_awardsVoteMember">투표 참여자목록</a></li>
                    <li><a href="/menu/rank/awardsDj" id="tab_awardsDj">어워즈 수상 DJ</a></li>
                    <li><a href="/menu/rank/awardsFan" id="tab_awardsFan">어워즈 수상 팬</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active " id="goodRankList">
                        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>

                        <table id="list_info" class="table table-sorting table-hover table-bordered">
                        </table>
                        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
                    </div>
                </div>     <!-- 상세 -->
            </div>
            <!-- DATA TABLE END -->
        </div>
    </div>
</div>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
     goodRankListPagingInfo = new PAGING_INFO(0, 1, 50);

     var dateTime = new Date();
     dateTime = moment(dateTime).format("YYYY.MM.DD");
     setTimeDate(dateTime);

     var tabType = <%=in_tabType%>;

    $(function(){
        $("#searchArea").html(util.getCommonCodeSelect(9999, searchType));

        slctType = 0;
        dateType();

    });

    function init(){
        var data = {
             slctType : $('input:radio[name="rankType"]:checked').val()
            , searchType : 0
            , pageNo : goodRankListPagingInfo.pageNo
            , pageCnt : goodRankListPagingInfo.pageCnt
            , searchText : $("#searchText").val()
            , rankingDate : $("#startDate").val()
        };

        console.log(data);

        util.getAjaxData("goodRank", "/rest/menu/rank/goodRank", data, fn_succ_list);
    }

    function fn_succ_list(dst_id, response, params) {
        dalbitLog(response);

        response.data.rankType = $('input:radio[name="rankType"]:checked').val();

        var template = $('#tmp_goodRankList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#list_info").html(html);

        if(response.result == "success"){
            var pagingInfo = response.pagingVo;
            goodRankListPagingInfo.totalCnt = pagingInfo.totalCnt;
            util.renderPagingNavigation('list_info_paginate_top', goodRankListPagingInfo);
            util.renderPagingNavigation('list_info_paginate', goodRankListPagingInfo);
        }
    }

    $('input[name="rankType"]').on('change', function(){
        if($('input:radio[name="rankType"]:checked').val() == 1){
            slctType = 0;
        }else if($('input:radio[name="rankType"]:checked').val() == 2){
            slctType = 4;
        }
        dateType();
        if($('input:radio[name="rankType"]:checked').val() == 2){       // 주간
            setMonday();
        }
    });

    $('#bt_search').on('click', function() {
        init();
    });

    $('input[id="searchText"]').on('keydown', function(e) {
        if(e.keyCode == 13) {
            init();
        };
    });

    function handlebarsPaging(targetId, pagingInfo){
        goodRankListPagingInfo = pagingInfo;
        init();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_goodRankList">
    <thead id="djtableTop">
    <tr>
        <th>순위</th>
        <th>프로필<br/>이미지</th>
        <th>회원번호</th>
        <th>닉네임</th>
        <th>성별</th>
        <th style="width: 110px">보상 배지</th>
        <th>배지 시작일</th>
        <th>배지 종료일</th>
        <th>좋아요 총합</th>
        <th>1분 좋아요</th>
        <th>부스터 좋아요</th>
        <th>부스터 횟수</th>
    </tr>
    </thead>
    <tbody id="goodRankListBody">
    {{#each this as |rank|}}
    <tr {{#dalbit_if inner '==' 1}} class="bg-testMember" {{/dalbit_if}}>
            <td>
                {{rank.rank}}
            </td>
            <td style="width: 50px">
                <img class="thumbnail fullSize_background" src="{{renderProfileImage rank.profileImage rank.memSex}}" style='height:68px; width:68px;margin-bottom: 0px' />
            </td>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a>
                <%--<br /> <br />--%>
                <%--레벨 : {{level}} <br />--%>
                <%--등급 : {{grade}}--%>
            </td>
            <td>
                {{#equal nickName ''}}
                    {{{fontColor '탈퇴회원 입니다.' 0 'red'}}}
                {{else}}
                    {{rank.nickName}}
                {{/equal}}
            </td>
            <td>{{{sexIcon memSex mem_birth_year}}}</td>
            <td>
                {{#dalbit_if rank.rewardDal '>' 0}}
                    {{#dalbit_if rank.rank '<' 4}}
                        <img class="" src="https://image.dalbitlive.com/badge/201020/heartr0{{rank.rank}}_s_3x.png" style='width:42px; height:26px; margin-bottom: 0px;'/><br/>
                        {{#dalbit_if ../rankType '==' '1'}} 일간 좋아요 {{rank.rank}} {{reward_rank}} {{/dalbit_if}}
                        {{#dalbit_if ../rankType '==' '2'}} 주간 좋아요 {{rank.rank}} {{reward_rank}} {{/dalbit_if}}
                    {{/dalbit_if}}
                {{/dalbit_if}}
            </td>
            <td>
                {{#dalbit_if rank.rewardDal '>' 0}}
                    {{substr startBadge 0 19}}<br/>
                    보상 달 : {{addComma rewardDal}}<br/>
                {{/dalbit_if}}
            </td>
            <td>
                {{#dalbit_if rank.rewardDal '>' 0}}
                    {{substr endBadge 0 19}}<br />
                    {{#dalbit_if ../rankType '==' '1'}} (23:59:59){{/dalbit_if}}
                    {{#dalbit_if ../rankType '==' '2'}} (일요일 23:59:59){{/dalbit_if}}
                {{/dalbit_if}}
            </td>
           <td>{{totalPoint}}</td>
           <td>{{goodPoint}}</td>
           <td>{{boosterPoint}}</td>
           <td>{{boosterCnt}}</td>
        </tr>

        {{else}}
            <tr>
                <td colspan="11">{{isEmptyData}}</td>
            </tr>
        {{/each}}
    </tbody>
</script>
