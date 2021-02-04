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
                                        <div id="div_yearButton"><jsp:include page="../../searchArea/yearSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
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
            </form>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="rankTab">
                    <li><a href="/menu/rank/djRankList?tabType=0" id="tab_rankList"><i class="fa fa-home"></i> DJ랭킹</a></li>
                    <li><a href="/menu/rank/djRankList?tabType=1" id="tab_rankFanList"><i class="fa fa-user"></i> Fan랭킹</a></li>
                    <li><a href="/menu/rank/addDjPoint" id="tab_addDjPoint">DJ가산점</a></li>
                    <li><a href="/menu/rank/goodRank" id="tab_goodRank">좋아요랭킹</a></li>
                    <li><a href="/menu/rank/awardsVote" id="tab_awardsVote">어워즈 투표현황</a></li>
                    <li><a href="/menu/rank/awardsVoteMember" id="tab_awardsVoteMember">투표 참여자목록</a></li>
                    <li class="active"><a href="#awardsDj" id="tab_awardsDj">어워즈 수상 DJ</a></li>
                    <li><a href="/menu/rank/awardsFan" id="tab_awardsFan">어워즈 수상 팬</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade in active " id="addDjPointList">
                        <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
                        <div class="col-md-12 no-padding">
                            <button type="button" class="btn btn-primary pull-right mr5" id="memSearch" name="memSearch"><i class="fa fa-search"></i>운영자 직접 등록</button>
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



<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="_layerTitle">어워즈 수상 소감 등록</h4>
            </div>
            <div class="modal-body no-padding">
                <table class="table table-sorting table-hover table-bordered no-margin">
                    <tr>
                        <th>회원번호</th>
                        <td><span id="mem_no"></span></td>
                        <th>회원닉네임</th>
                        <td><span id="mem_nick"></span></td>
                    </tr>
                    <tr>
                        <th colspan="4">DJ소개</th>
                    </tr>
                    <tr>
                        <td colspan="4"><textarea type="textarea" class="form-control" id="djIntroduce" name="djIntroduce" style="width: 100%; height: 100%; min-height: 100px"></textarea></td>
                    </tr>
                    <tr>
                        <th colspan="4">수상소감</th>
                    </tr>
                    <tr>
                        <td colspan="4"><textarea type="textarea" class="form-control" id="awardsImpression" name="awardsImpression" style="width: 100%; height: 100%; min-height: 250px"></textarea></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer no-margin">
                <button type="button" class="btn btn-custom-primary" onclick="addAwardsImpression();"><i class="fa fa-check-circle"></i> 저장</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/view/common/util/select_specialList.jsp"></jsp:include>

<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    listPagingInfo = new PAGING_INFO(0, 1, 50);

    var mem_no;
    $(function(){
        slctType = 2;
        dateType();
    });

    function init(){
        var data = {
            pageNo : listPagingInfo.pageNo
            , pageCnt : listPagingInfo.pageCnt
            , selectYear : $("#startDate").val().substr(0,4)
        };
        util.getAjaxData("addDjPoint", "/rest/menu/rank/awards/dj", data, fn_succ_list);
    }

    function fn_succ_list(dst_id, response, params) {

        var template = $('#tmp_list_info').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#list_info").html(html);

        if(response.result == "success") {
            var pagingInfo = response.pagingVo;
            listPagingInfo.totalCnt = pagingInfo.totalCnt;
            util.renderPagingNavigation('list_info_paginate_top', listPagingInfo);
            util.renderPagingNavigation('list_info_paginate', listPagingInfo);
        }
    }

    $('#bt_search').on('click', function() {
        init();
    });

    $('input[id="searchText"]').on('keydown', function(e) {
        if(e.keyCode == 13) {
            $('#bt_search').click();
        };
    });

    function handlebarsPaging(targetId, pagingInfo){
        listPagingInfo = pagingInfo;
        $('#bt_search').click();
    }

    $('#memSearch').on('click', function() {
        showPopMemberList(awardsFanChoiceMember);
    });

    function awardsFanChoiceMember(data) {
        if(confirm(data.mem_nick + '님을 어워즈 수상 명단에 등록하시겠습니까?')){
            var data = {
                mem_no : data.mem_no
                , selectYear : $("#startDate").val().substr(0,4)
                , slctType : 1
            };
            util.getAjaxData("regist", "/rest/menu/rank/awards/dj/regist", data, fn_regist_success);
        }else{
            return false;
        }
    }

    function fn_regist_success(dst_id, response){
        if(response.result == "success"){
            alert("어워즈 후보 등록 수정");
            $('#bt_search').click();
        }
    }

    function awardsClick(data){
        if(confirm(data.data('memnick') + "님을 어워즈 수상 해제 하시겠습니까?")){
            var data = {
                mem_no : data.data('memno')
                , selectYear : $("#startDate").val().substr(0,4)
                , slctType : 0
            };

            console.log(data);
            util.getAjaxData("regist", "/rest/menu/rank/awards/dj/regist", data, fn_regist_success);
        }else{
            return false;
        }
    }

    function awardsImpression(data){
        mem_no = data.data('memno');
        $("#myModal").modal("show");
        $("#mem_no").html('<a href="javascript://" class="_openMemberPop" data-memNo="' + mem_no + '"> ' + data.data('memno') + '</a>');
        $("#mem_nick").text(data.data('memnick'));

        var data = {
            mem_no : mem_no
            , slctType : 1
            , selectYear : $("#startDate").val().substr(0,4)
        };

        console.log(data);
        util.getAjaxData("impression", "/rest/menu/rank/awards/dj/sel/impression", data, fn_selImpression_success);
    }

    function fn_selImpression_success(dst_id, response, param){
        $("#djIntroduce").val(response.data.title);
        $("#awardsImpression").val(response.data.msg);
    }
    function addAwardsImpression(){
        var data = {
            mem_no : mem_no
            , selectYear : $("#startDate").val().substr(0,4)
            , slctType : 1
            , title : $("#djIntroduce").val()
            , msg : $("#awardsImpression").val()
        };

        console.log(data);
        util.getAjaxData("regist", "/rest/menu/rank/awards/dj/add/impression", data, fn_impression_success);

    }

    function fn_impression_success(dst_id, response){
        if(response.result == "success"){
            alert("어워즈 소감 등록");
            $("#myModal").modal("hide");
            $('#bt_search').click();
        }
    }

    /*=============엑셀==================*/
    /*$('#excelDownBtn').on('click', function(){
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("selectYear", $("#startDate").val().substr(0,4));
        formData.append("searchText", $("#searchText").val());
        formData.append("pageStart", 1);
        formData.append("pageCnt", 10000);

        util.excelDownload($(this), "/rest/menu/rank/awards/vote/listExcel", formData, fn_success_excel, fn_fail_excel)
    });

    function fn_success_excel(){
        console.log("fn_success_excel");
    }

    function fn_fail_excel(){
        console.log("fn_fail_excel");
    }*/
    /*==================================*/

</script>

<script type="text/x-handlebars-template" id="tmp_list_info">
    <thead>
        <tr>
            <th>순위</th>
            <th>프로필<br/>이미지</th>
            <th>회원번호</th>
            <th>닉네임</th>
            <th>성별</th>
            <th>1위 팬<br/>회원정보</th>
            <th>2위 팬<br/>회원정보</th>
            <th>3위 팬<br/>회원정보</th>
            <th>어워즈<br/>수상 해제</th>
            <th>어워즈<br/>소감 등록</th>
        </tr>
    </thead>
    <tbody id="listBody">
    {{#each this}}
        <tr {{#dalbit_if inner '==' 1}} class="bg-testMember" {{/dalbit_if}}>
        <td>
            {{rank}}
        </td>
        <td style="width: 50px">
            <img class="thumbnail fullSize_background" src="{{renderProfileImage profileImage memSex}}" style='height:68px; width:68px;margin-bottom: 0px' />
        </td>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memNo="{{memNo}}">{{memNo}}</a>
            <br /> <br />
            레벨 : {{level}} <br />
            등급 : {{grade}}
        </td>
        <td>
            {{#dalbit_if memNick '!=' ''}}
                {{memNick}}
            {{else}}
                {{{fontColor '탈퇴회원 입니다.' 0 'red'}}}
            {{/dalbit_if}}
        </td>
        <td>{{{sexIcon memSex memBirthYear}}}</td>
        <td><a href="javascript://" class="_openMemberPop" data-memNo="{{fan1_memNo}}">{{fan1_memNo}}</a><br/>{{fan1_memNick}}</td>
        <td><a href="javascript://" class="_openMemberPop" data-memNo="{{fan2_memNo}}">{{fan2_memNo}}</a><br/>{{fan2_memNick}}</td>
        <td><a href="javascript://" class="_openMemberPop" data-memNo="{{fan3_memNo}}">{{fan3_memNo}}</a><br/>{{fan3_memNick}}</td>
        <td>
            <a href="javascript://" onclick="awardsClick($(this));" data-memno="{{memNo}}" data-memnick="{{memNick}}" data-type="1">
                해제
            </a>
        </td>
        <td>
            <a href="javascript://" onclick="awardsImpression($(this));" data-memno="{{memNo}}" data-memnick="{{memNick}}">
                {{#dalbit_if existsMsg '==' 0}}
                    등록
                {{else}}
                    수정
                {{/dalbit_if}}
            </a>
        </td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11">{{isEmptyData}}</td>
    </tr>
    {{/each}}
    </tbody>
</script>
