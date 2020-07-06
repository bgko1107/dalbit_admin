<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
            <div class="row col-lg-12 form-inline">
                <input type="hidden" name="pageStart" id="pageStart">
                <input type="hidden" name="pageCnt" id="pageCnt">
                <div class="widget widget-table searchBoxArea">
                    <div class="widget-header searchBoxRow">
                        <h3 class="title"><i class="fa fa-search"></i> 추천/인기DJ 검색</h3>
                        <div>
                            <span id="searchArea"></span>
                            <label><input type="text" class="form-control" id="txt_search" name="txt_search"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                        </div>
                    </div>
                </div>
                <div>
                    <label id="lb_title" style="display: none"><b>· 선택 날짜의 전주 랭킹을 확인할 수 있습니다.</b></label>
                </div>
            </div>
            </form>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">

                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="rankTab">
                    <li class="active">
                        <a href="#djRankList" role="tab" data-toggle="tab" data-rank="djRankList"><i class="fa fa-home"></i> DJ랭킹</a>
                    </li>
                    <li>
                        <a href="#fanRankList" role="tab" data-toggle="tab" data-rank="fanRankList"><i class="fa fa-user"></i> Fan랭킹</a>
                    </li>
                </ul>
                <div>
                    <div>
                        <div class="row col-lg-12 form-inline">
                            <div class="table-comment pt10 pull-left">
                                DJ/Fan랭킹 Main 노출 수는 1위부터 5위까지 총5명입니다.
                            </div>

                            <div class="table-option pt10 pull-right">
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

                                <div class="input-group date" id="oneDayDatePicker">
                                    <label for="onedayDate" class="input-group-addon">
                                        <span><i class="fa fa-calendar" id="onedayDateBtn"></i></span>
                                    </label>
                                    <input type="text" class="form-control" id="onedayDate" name="onedayDate">
                                </div>

                                <div class="input-group date" id="rangeDatepicker" style="display: none">
                                    <label for="monthDate" class="input-group-addon">
                                        <span><i class="fa fa-calendar"></i></span>
                                    </label>
                                    <input id="monthDate" type="text" class="form-control" style="width: 168px;"/>
                                </div>

                                <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                <input class="hide" name="endDate" id="endDate" style="width: 100px">

                                <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                <%--<input name="endDate" id="endDate" style="width: 100px">--%>

                            </div>
                        </div>

                        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>

                        <table id="list_info" class="table table-sorting table-hover table-bordered">
                        </table>
                        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
                    </div>


                    <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate">--%>
                        <%--<ul class="pagination borderless">
                            <li class="paginate_button first" aria-controls="list_info" tabindex="0"
                                id="list_info_first"><a href="#">처음</a></li>
                            <li class="paginate_button previous" aria-controls="list_info" tabindex="0"
                                id="list_info_previous"><a href="#">이전</a></li>
                            <li class="paginate_button active" aria-controls="list_info" tabindex="0"><a href="#">1</a>
                            </li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">2</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">3</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">4</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">5</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">6</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">7</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">8</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">9</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">10</a></li>
                            <li class="paginate_button next" aria-controls="list_info" tabindex="0" id="list_info_next">
                                <a href="#">다음</a></li>
                            <li class="paginate_button last" aria-controls="list_info" tabindex="0" id="list_info_last">
                                <a href="#">마지막</a></li>
                        </ul>--%>
                    <%--</div>--%>

                </div>
            </div>
            <!-- DATA TABLE END -->
        </div>
    </div>
</div>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
     djRankListPagingInfo = new PAGING_INFO(0, 1, 50);

     var dateTime = new Date();
     dateTime = moment(dateTime).format("YYYY.MM.DD");
     setTimeDate(dateTime);

    $(function(){
        $("#searchArea").html(util.getCommonCodeSelect(9999, searchType));
        init();

        $('#onedayDate').datepicker("onedayDate", new Date()).on('changeDate', function (dateText, inst) {
            var selectDate = moment(dateText.date).format("YYYY.MM.DD");
            $("#startDate").val(selectDate);
        });

        $('#monthDate').datepicker({
            minViewMode: 'months',
            format: 'yyyy.mm',
            keyboardNavigation: false,
            forceParse: false,
            autoclose: true,
            language: 'kr',
        });

        $("#onedayDate").on('change', function () {
            if($('input:radio[name="rankType"]:checked').val() == 2){
                setMonday();
            }else{
                $("#endDate").val($("#startDate").val());
            }
        });

        $("#monthDate").on('change', function () {
            var monthLastDate = new Date($("#monthDate").val().substr(0,4),$("#monthDate").val().substr(5,6),-1);
            $("#startDate").val($("#monthDate").val() + '.01');
            $("#endDate").val($("#monthDate").val() + "." +  (monthLastDate.getDate() + 1));
            init();
        });

        $("#monthDate").val(moment(new Date()).format('YYYY.MM'));
    });

    function init(tabName){
        var rank = common.isEmpty(tabName) ? $('#rankTab li.active a').data('rank') : tabName;

        var data = {
            rankType : $('input:radio[name="rankType"]:checked').val()
            , pageStart : djRankListPagingInfo.pageNo
            , pageCnt : djRankListPagingInfo.pageCnt
            , selectGubun : $('#searchArea').val()
            , txt_search : $("#txt_search").val()
            , sDate : $("#startDate").val()
            , eDate : $("#endDate").val()
        }
        util.getAjaxData(rank, "/rest/menu/rank/"+rank, data, fn_succ_list);
    }

     function setTimeDate(dateTime){
         $("#onedayDate").val(dateTime);
         $("#startDate").val(dateTime);
         $("#endDate").val(dateTime);
     }

    function fn_succ_list(dst_id, response, params) {
        dalbitLog(dst_id);
        dalbitLog(response);

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

     rankTypeChange();
    $('input[name="rankType"]').on('change', function(){
        rankTypeChange();
    });
    function rankTypeChange(){
        if($('input:radio[name="rankType"]:checked').val() == 3){
            $("#rangeDatepicker").show();
            $("#oneDayDatePicker").hide();
            $("#monthDate").val(moment(new Date()).format('YYYY.MM'));
            $("#startDate").val(moment(new Date()).format('YYYY.MM.01'));
            $("#endDate").val(moment(moment(new Date()).format('YYYY.MM.01')).add('months', 1).add('days', -1).format('YYYY.MM.DD'));
        }else{
            $("#oneDayDatePicker").show();
            $("#rangeDatepicker").hide();
            $("#startDate").val(moment(new Date()).format('YYYY.MM.DD'));
            $("#endDate").val(moment(new Date()).format('YYYY.MM.DD'));
            $("#onedayDate").val(moment(new Date()).format('YYYY.MM.DD'));
            if($('input:radio[name="rankType"]:checked').val() == 2){       // 주간
                setMonday();
            }
        }
        if($('input:radio[name="rankType"]:checked').val() == 2){
            $("#lb_title").show();
        }else{
            $("#lb_title").hide();
        }
        djRankListPagingInfo.pageNo = 1;
        init();
    }

     function getMonday(str) {
         var y = str.substr(0, 4);
         var m = str.substr(5, 2);
         var d = str.substr(8, 2);
         d = new Date(y,m-1,d);
         var day = d.getDay(),
             diff = d.getDate() - day + (day == 0 ? -6:1);
         return new Date(d.setDate(diff));
     }
     function setMonday(){
         var monday = getMonday($("#startDate").val());       // 선택한 날의 월요일
         var endDate = new Date();
         endDate.setFullYear(monday.getFullYear());
         endDate.setMonth(monday.getMonth() + 1);
         endDate.setDate(monday.getDate()-1); //하루 전
         var startDate = new Date();
         startDate.setFullYear(monday.getFullYear());
         startDate.setMonth(monday.getMonth() + 1);
         startDate.setDate(monday.getDate()-8);
         $("#startDate").val(startDate.getFullYear() + "." + common.lpad(startDate.getMonth(),2,"0") + "." + common.lpad(startDate.getDate(),2,"0"));
         $("#endDate").val(endDate.getFullYear() + "." + common.lpad(endDate.getMonth(),2,"0") + "." + common.lpad(endDate.getDate(),2,"0"));
     }

    $('#rankTab li').on('click', function(){
        var rank = $(this).find('a').data('rank');
        djRankListPagingInfo.pageNo = 1;
        init(rank);
    });

    $('#bt_search').on('click', function() {
        init($('#rankTab li.active a').data('rank'));
    });

    $('input[id="txt_search"]').on('keydown', function(e) {
        if(e.keyCode == 13) {
            init($('#rankTab li.active a').data('rank'));
        };
    });

    function handlebarsPaging(targetId, pagingInfo){
        djRankListPagingInfo = pagingInfo;
        init();
    }
</script>

<script type="text/x-handlebars-template" id="tmp_djRankList">
    <thead id="djtableTop">
    <tr>
        <th>순위</th>
        <th>프로필 이미지</th>
        <th>User ID</th>
        <th>User 닉네임</th>
        <th>성별</th>
        <th>랭킹점수</th>
        <th>받은 별</th>
        <th>누적 청취자</th>
        <th>받은 좋아요</th>
        <th>방송진행 시간</th>
    </tr>
    </thead>
    <tbody id="djRankListBody">
    {{#each this as |rank|}}
        <tr>
            <td>
                {{djRank}} <br /><br />
                {{upDown}}
            </td>
            <td style="width: 50px">
                <img class="thumbnail fullSize_background" src="{{renderProfileImage rank.image_profile rank.mem_sex}}" style='height:68px; width:68px;margin-bottom: 0px' />
            </td>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memNo="{{memNo}}">{{mem_id}}</a>
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
            <td>{{{sexIcon mem_sex}}}</td>
            <td>{{addComma rankPoint}}점</td>
            <td>{{addComma itemCnt}}개</td>
            <td>{{addComma listenCnt}}번</td>
            <td>{{addComma goodCnt}}번</td>
            <td>{{timeStamp airTime}}</td>
        </tr>

        {{else}}
            <tr>
                <td colspan="11">{{isEmptyData}}</td>
            </tr>
        {{/each}}
    </tbody>
</script>

<script type="text/x-handlebars-template" id="tmp_fanRankList">
    <thead id="tableTop">
    <tr>
        <th>순위</th>
        <th>프로필 이미지</th>
        <th>User ID</th>
        <th>User 닉네임</th>
        <th>성별</th>
        <th>랭킹 점수</th>
        <th>보낸 달</th>
        <th>청취 시간</th>
    </tr>
    </thead>
    <tbody id="fanRankListBody">
    {{#each this as |fan|}}
        <tr>
            <td>
                {{fanRank}} <br /><br />
                {{upDown}}
            </td>
            <td style="width: 50px">
                <img class="thumbnail fullSize_background" src="{{renderProfileImage fan.image_profile fan.mem_sex}}" style='height:68px; width:68px;margin-bottom: 0px' />
            </td>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memNo="{{mem_no}}">{{mem_id}}</a> <br /> <br />
                레벨 : {{level}} <br />
                등급 : {{grade}}
            </td>
            <td>{{mem_nick}}</td>
            <td>{{{sexIcon mem_sex}}}</td>
            <td>{{addComma rankPoint}}점</td>
            <td>{{addComma itemCnt}}개</td>
            <td>{{timeStamp airTime}}</td>
        </tr>

    {{else}}
        <tr>
            <td colspan="11">{{isEmptyData}}</td>
        </tr>
    {{/each}}
    </tbody>
</script>