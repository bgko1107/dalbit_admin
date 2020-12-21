<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
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
                                        <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;"/>

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
                    <li class="active"><a href="#addDjPointList"><i class="fa fa-user"></i>DJ가산점</a></li>
                    <li><a href="/menu/rank/goodRank" id="tab_goodRank">좋아요랭킹</a></li>
                    <li><a href="/menu/rank/awardsVote" id="tab_awardsVote">어워즈 투표현황</a></li>
                    <li><a href="/menu/rank/awardsVoteMember" id="tab_awardsVoteMember">투표 참여자목록</a></li>
                    <li><a href="/menu/rank/awardsDj" id="tab_awardsDj">어워즈 수상 DJ</a></li>
                    <li><a href="/menu/rank/awardsFan" id="tab_awardsFan">어워즈 수상 팬</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active " id="addDjPointList">
                        <div class="row col-lg-12 form-inline">
                            <div class="col-md-8 no-padding mt10">
                                <span id="tab_title">
                                    · 스페셜 DJ 선정 시 필요 데이터 입니다.<br/>
                                    &nbsp;&nbsp;DJ 랭킹의 (어제 랭킹) 기준 [1위 2점, 2위 1점, 3위 0.5점]이 오늘 반영되어 일 단위로 누적됩니다.<br/>
                                    &nbsp;&nbsp;가산점 총합 순위이며, 가산점 총합이 동일한 경우 월간 랭킹 점수가 높은 순으로 노출됩니다.

                                </span>
                            </div>
                        </div>

                        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>
                        <table id="list_info" class="table table-sorting table-hover table-bordered">
                        </table>
                        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
                    </div>
                </div>     <!-- 상세 -->
            </div>
        </div>
        <!-- DATA TABLE END -->
    </div>
</div>
</div>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    djRankListPagingInfo = new PAGING_INFO(0, 1, 50);

    $(function(){
        $("#searchArea").html(util.getCommonCodeSelect(9999, searchType));

        slctType = 1;
        dateType();
    });

    function init(tabName){
        var data = {
             pageStart : djRankListPagingInfo.pageNo
            , pageCnt : djRankListPagingInfo.pageCnt
            , selectGubun : $('#searchArea').val()
            , txt_search : $("#searchText").val()
            , sDate : $("#startDate").val()
            , eDate : $("#endDate").val()
        }
        util.getAjaxData("addDjPoint", "/rest/menu/rank/addDjPoint", data, fn_succ_list);
    }

    function fn_succ_list(dst_id, response, params) {
        dalbitLog(response);

        var template = $('#tmp_addDjPoint').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#list_info").html(html);

        if(response.result == "success") {
            var pagingInfo = response.pagingVo;
            djRankListPagingInfo.totalCnt = pagingInfo.totalCnt;
            util.renderPagingNavigation('list_info_paginate_top', djRankListPagingInfo);
            util.renderPagingNavigation('list_info_paginate', djRankListPagingInfo);
        }
    }

    $('#bt_search').on('click', function() {
        init();
    });

    $('input[id="searchText"]').on('keydown', function(e) {
        if(e.keyCode == 13) {
            init();
        };
    });

    function handlebarsPaging(targetId, pagingInfo){
        djRankListPagingInfo = pagingInfo;
        init();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_addDjPoint">
    <thead>
        <tr>
            <th>가산점 순위</th>
            <th>프로필<br/>이미지</th>
            <th>회원번호</th>
            <th>닉네임</th>
            <th>성별</th>
            <th style="color: red">가산점<br/>총합</th>
            <th>1위 횟수<br/>(가산점)</th>
            <th>2위 횟수<br/>(가산점)</th>
            <th>3위 횟수<br/>(가산점)</th>
            <th>랭킹 점수</th>
        </tr>
    </thead>
    <tbody id="djRankListBody">
    {{#each this as |rank|}}
        <tr {{#dalbit_if inner '==' 1}} class="bg-testMember" {{/dalbit_if}}>
        <td>
            {{rowNum}}
        </td>
        <td style="width: 50px">
            <img class="thumbnail fullSize_background" src="{{renderProfileImage rank.image_profile rank.mem_sex}}" style='height:68px; width:68px;margin-bottom: 0px' />
        </td>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{memNo}}">{{memNo}}</a>
            <br /> <br />
            레벨 : {{level}} <br />
            등급 : {{grade}}
        </td>
        <td>
            {{#equal mem_nick ''}}
            {{{fontColor '탈퇴회원 입니다.' 0 'red'}}}
            {{else}}
            {{rank.mem_nick}}
            {{/equal}}
        </td>
        <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
        <td style="color: red;">{{#dalbit_if addPointTotal '!=' 0.0}}{{addPointTotal}}점{{/dalbit_if}}</td>
        <td>{{addPointRank1}}회<br/>({{addPoint1}}점)</td>
        <td>{{addPointRank2}}회<br/>({{addPoint2}}점)</td>
        <td>{{addPointRank3}}회<br/>({{addPoint3}}점)</td>
        <td>{{addComma rankPoint}}점</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="15">{{isEmptyData}}</td>
    </tr>
    {{/each}}
    </tbody>
</script>
