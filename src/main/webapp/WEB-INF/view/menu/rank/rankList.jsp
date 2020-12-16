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
                                        <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                        <div id="div_yearButton" ><jsp:include page="../../searchArea/yearSearchArea.jsp"/></div>
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
                                    <label class="control-inline fancy-radio custom-color-green">
                                        <input type="radio" name="rankType" value='3' />
                                        <span><i></i>월간</span>
                                    </label>
                                    <label class="control-inline fancy-radio custom-color-green">
                                        <input type="radio" name="rankType" value='4' />
                                        <span><i></i>연간</span>
                                    </label>

                                    <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>

                                    <input id="onedayDate" type="text" class="form-control" style="width: 196px;"/>
                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;"/>
                                    <input id="yearDate" type="text" class="form-control" style="width: 196px;"/>

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
                <%--<div>--%>
                    <%--<label id="lb_title" style="display: none"><b>· 선택 날짜의 전주 랭킹을 확인할 수 있습니다.</b></label>--%>
                <%--</div>--%>
            </form>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">

                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="rankTab">
                    <li class="active">
                        <a href="#djRankList" role="tab" data-toggle="tab" data-rank="djRankList"><i class="fa fa-home"></i> DJ랭킹</a>
                    </li>
                    <li>
                        <a href="#djRankList" role="tab" data-toggle="tab" data-rank="fanRankList"><i class="fa fa-user"></i> Fan랭킹</a>
                    </li>
                    <li><a href="/menu/rank/addDjPoint" id="tab_addDjPoint">DJ가산점</a></li>
                    <li><a href="/menu/rank/goodRank" id="tab_goodRank">좋아요 랭킹</a></li>
                    <li><a href="/menu/rank/awardsVote" id="tab_awardsVote">어워즈 투표현황</a></li>
                    <li><a href="/menu/rank/awardsDj" id="tab_awardsDj">어워즈 수상 DJ</a></li>
                    <li><a href="/menu/rank/awardsFan" id="tab_awardsFan">어워즈 수상 팬</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active " id="djRankList">
                        <div class="row col-lg-12 form-inline">
                            <div class="col-md-7 no-padding mt10">
                                <span id="tab_title">ㆍDJ 랭킹 점수 산출 방법<br/>
                                                        : 받은 별(부스터 제외) 1점 + 누적 청취자 2점 + 받은 좋아요(부스터 제외) 1점 + 부스터 횟수 20점
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
            <!-- DATA TABLE END -->
        </div>
    </div>
</div>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
     djRankListPagingInfo = new PAGING_INFO(0, 1, 50);

     var tabType = <%=in_tabType%>;

    $(function(){
        $("#searchArea").html(util.getCommonCodeSelect(9999, searchType));

        slctType = 0;
        dateType();

        if(!common.isEmpty(tabType)){
            $('#rankTab li:eq(' + tabType + ') a').tab('show');
            if(tabType == 0){
                var tmp = "djRankList";
            }else if(tabType == 1){
                var tmp = "fanRankList";
            }
            init(tmp);
        }else{
            init();
        }
    });

    function init(tabName){
        var rank = common.isEmpty(tabName) ? $('#rankTab li.active a').data('rank') : tabName;

        var data = {
            rankType : $('input:radio[name="rankType"]:checked').val()
            , pageStart : djRankListPagingInfo.pageNo
            , pageCnt : djRankListPagingInfo.pageCnt
            , selectGubun : $('#searchArea').val()
            , txt_search : $("#searchText").val()
            , sDate : $("#startDate").val()
            , eDate : $("#endDate").val()
            , onedayDate : $("#onedayDate").val()
        }
        util.getAjaxData(rank, "/rest/menu/rank/"+rank, data, fn_succ_list);
    }

    function fn_succ_list(dst_id, response, params) {
        dalbitLog(dst_id);
        dalbitLog(response);

        response.data.rankType = $('input:radio[name="rankType"]:checked').val();

        if(dst_id == "djRankList"){
            for(var i=0;i<response.data.length;i++){
                response.data[i]["recByeol"] = response.data[i].itemCnt + Number(response.data[i].boostByeol);
                response.data[i]["totalGoodCnt"] = response.data[i].goodCnt + (response.data[i].boostCnt * 10);
            }
        }else if(dst_id == "fanRankList"){
            for(var i=0;i<response.data.length;i++){
                response.data[i]["giftDal"] = response.data[i].itemCnt + Number(response.data[i].boostDal);
                response.data[i]["totalGoodCnt"] = response.data[i].goodCnt + (response.data[i].boostCnt * 10);
            }
        }

        var template = $('#tmp_'+dst_id).html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#list_info").html(html);

        var pagingInfo = response.pagingVo;
        djRankListPagingInfo.totalCnt = pagingInfo.totalCnt;
        util.renderPagingNavigation('list_info_paginate_top', djRankListPagingInfo);
        util.renderPagingNavigation('list_info_paginate', djRankListPagingInfo);
    }

    $('input[name="rankType"]').on('change', function(){
        if($('input:radio[name="rankType"]:checked').val() == 1){
            slctType = 0;
        }else if($('input:radio[name="rankType"]:checked').val() == 2){
            slctType = 4;
        }else if($('input:radio[name="rankType"]:checked').val() == 3){
            slctType = 1;
        }else if($('input:radio[name="rankType"]:checked').val() == 4){
            slctType = 2;
        }
        dateType();
        if($('input:radio[name="rankType"]:checked').val() == 2){       // 주간
            setMonday();
        }
    });

    $('#rankTab li').on('click', function(){
        var rank = $(this).find('a').data('rank');
        if(rank == "djRankList"){
            $("#tab_title").text("DJ 랭킹 점수는 받은 별(부스터 제외) 1점, 누적 청취자 2점, 받은 좋아요 1점, 부스터 횟수 20점으로 반영됩니다.");
        }else if(rank == "fanRankList"){
            $("#tab_title").text("FAN 랭킹 점수는 보낸 달 1점, 1분 좋아요 1점으로 반영 됩니다.");
        }

        djRankListPagingInfo.pageNo = 1;
        init(rank);
    });

    $('#bt_search').on('click', function() {
        init($('#rankTab li.active a').data('rank'));
    });

    $('input[id="searchText"]').on('keydown', function(e) {
        if(e.keyCode == 13) {
            init($('#rankTab li.active a').data('rank'));
        };
    });

    function handlebarsPaging(targetId, pagingInfo){
        djRankListPagingInfo = pagingInfo;
        init();
    }

    function awardsClick(data){
        var slctType = data.data('awards') > 0 ? 0 : 1;
        var data = {
            mem_no : data.data('memno')
            , slctTarget : data.data('type')
            , selectYear : $("#startDate").val().substr(0,4)
            , slctType : slctType
        };

        console.log(data);
        util.getAjaxData("regist", "/rest/menu/rank/awards/regist", data, fn_regist_success);
    }

    function fn_regist_success(dst_id, response){
        if(response.result == "success"){
            alert("어워즈 후보 등록 수정");
            init();
        }
    }

</script>

<script type="text/x-handlebars-template" id="tmp_djRankList">
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
        <th>랭킹 점수</th>
        <th style="background-color: #4472c4;color: white">받은 별<br/>(부스터 제외)<br/>x1점</th>
        <th style="background-color: #4472c4;color: white">누적 청취자<br/>x2점</th>
        <th style="background-color: #4472c4;color: white">받은 좋아요<br/>(부스터 제외)<br/>x1점</th>
        <th style="background-color: #4472c4;color: white">부스터 횟수<br/>x20점</th>
        <th>방송진행 시간</th>
        <th>어워즈<br/>후보 등록</th>
    </tr>
    </thead>
    <tbody id="djRankListBody">
    {{#each this as |rank|}}
    <tr {{#dalbit_if inner '==' 1}} class="bg-testMember" {{/dalbit_if}}>
            <td>
                {{djRank}}
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
            <td>
                {{#dalbit_if badgeImage '==' ''}}
                {{else}}
                    <img class="" src="{{badgeImage}}" style='width:42px; height:26px; margin-bottom: 0px;'/><br/>
                    {{#dalbit_if ../rankType '==' '1'}} 일간 DJ TOP {{reward_rank}} {{/dalbit_if}}
                    {{#dalbit_if ../rankType '==' '2'}} 주간 DJ TOP {{reward_rank}} {{/dalbit_if}}
                    {{#dalbit_if ../rankType '==' '3'}} 월간 DJ TOP {{reward_rank}} {{/dalbit_if}}
                {{/dalbit_if}}
            </td>
            <td>
                {{#dalbit_if badgeImage '==' ''}}
                {{else}}
                    {{rewardStartDate}}<br/>
                    보상 달 : {{addComma reward_dal}}<br/>
                    보상 경험치 : {{addComma reward_exp}}<br/>
                {{/dalbit_if}}
            </td>
            <td>
                {{#dalbit_if rewardEndDate '!=' ''}}
                    {{rewardEndDate}}<br />
                    {{#dalbit_if ../rankType '==' '1'}} (23:59:59){{/dalbit_if}}
                    {{#dalbit_if ../rankType '==' '2'}} (일요일 23:59:59){{/dalbit_if}}
                {{/dalbit_if}}
            </td>
            <td>{{addComma rankPoint}}점</td>
            <td>{{addComma recByeol}}개<br/>({{addComma itemCnt}}개)</td>
            <td>{{addComma listenCnt}}명</td>
            <td>{{addComma totalGoodCnt}}<br/>({{addComma goodCnt}}개)</td>
            <td>{{addComma boostCnt}}개</td>$(this)
            <td>{{timeStamp airTime}}</td>
            <td>
                <a href="javascript://" onclick="awardsClick($(this));" data-memNo="{{memNo}}" data-type="1" data-awards="{{awards}}">
                    {{#dalbit_if awards '>' 0}}해제{{else}}등록{{/dalbit_if}}
                </a>
            </td>
        </tr>

        {{else}}
            <tr>
                <td colspan="16">{{isEmptyData}}</td>
            </tr>
        {{/each}}
    </tbody>
</script>

<script type="text/x-handlebars-template" id="tmp_fanRankList">
    <thead id="tableTop">
    <tr>
        <th>순위</th>
        <th>프로필<br/>이미지</th>
        <th>회원번호</th>
        <th>닉네임</th>
        <th>성별</th>
        <th style="width: 110px">보상 배지</th>
        <th>배지 시작일</th>
        <th>배지 종료일</th>
        <th>랭킹 점수</th>
        <th style="background-color: #4472c4;color: white">보낸 달<br/>x1점</th>
        <th style="background-color: #4472c4;color: white">1분 좋아요<br/>x1점</th>
        <th>부스터 횟수</th>
        <th>청취 시간</th>
        <th>어워즈<br/>팬 선정</th>
    </tr>
    </thead>
    <tbody id="fanRankListBody">
    {{#each this as |fan|}}
        <tr {{#dalbit_if inner '==' 1}} class="bg-testMember" {{/dalbit_if}}>
            <td>
                {{fanRank}}
            </td>
            <td style="width: 50px">
                <img class="thumbnail fullSize_background" src="{{renderProfileImage fan.image_profile fan.mem_sex}}" style='height:68px; width:68px;margin-bottom: 0px' />
            </td>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_no}}</a> <br /> <br />
                레벨 : {{level}} <br />
                등급 : {{grade}}
            </td>
            <td>{{mem_nick}}</td>
            <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
            <td>
                {{#dalbit_if badgeImage '==' ''}}
                {{else}}
                    <img class="" src="{{badgeImage}}" style='width:42px; height:26px; margin-bottom: 0px;'/><br/>
                    {{#dalbit_if ../rankType '==' '1'}} 일간 FAN TOP {{reward_rank}} {{/dalbit_if}}
                    {{#dalbit_if ../rankType '==' '2'}} 주간 FAN TOP {{reward_rank}} {{/dalbit_if}}
                {{/dalbit_if}}
            </td>
            <td>
                {{#dalbit_if badgeImage '==' ''}}
                {{else}}
                    {{rewardStartDate}}<br/>
                    보상 달 : {{addComma reward_dal}}<br/>
                    보상 경험치 : {{addComma reward_exp}}<br/>
                {{/dalbit_if}}
            </td>
            <td>
                {{#dalbit_if rewardEndDate '!=' ''}}
                    {{rewardEndDate}}<br/>
                    {{#dalbit_if ../rankType '==' '1'}} (23:59:59) {{/dalbit_if}}
                    {{#dalbit_if ../rankType '==' '2'}} (일요일 23:59:59) {{/dalbit_if}}
                {{/dalbit_if}}
            </td>
            <td>{{addComma rankPoint}}점</td>
            <td>{{addComma giftDal}}개</td>
            <td>{{addComma goodCnt}}개</td>
            <td>{{addComma boostCnt}}개</td>
            <td>{{timeStamp airTime}}</td>
            <td>
                <a href="javascript://" onclick="awardsClick($(this));" data-memNo="{{mem_no}}" data-type="2" data-awards="{{awards}}">
                    {{#dalbit_if awards '>' 0}}해제{{else}}등록{{/dalbit_if}}
                </a>
            </td>
        </tr>

    {{else}}
        <tr>
            <td colspan="16">{{isEmptyData}}</td>
        </tr>
    {{/each}}
    </tbody>
</script>