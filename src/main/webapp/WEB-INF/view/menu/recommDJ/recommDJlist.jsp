<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="widget widget-table">
    <div class="col-md-12 no-padding mt15">
        <span id="recomm_status_area" class="ml5"></span>
        <!--운영자 등록 버튼 -->
        <button type="button" class="btn btn-danger pull-right mr10" id="recommendDjDel">삭제</button>
        <button type="button" class="btn btn-primary pull-right mr10" id="memSearch" name="memSearch"><i class="fa fa-search"></i>운영자 직접 등록</button>
    </div>

    <div class="widget-content" style="border-top-width:0px;">
        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>

        <table id="specialList" class="table table-sorting table-hover table-bordered mt15">
            <colgroup>
                <col width="1%"><col width="2%"><col width="4.7%"><col width="4.7%"><col width="4.7%">
                <col width="4.7%"><col width="4.7%"><col width="4.7%"><col width="4.7%"><col width="4.7%">
                <col width="4.7%"><col width="4.7%"><col width="4.7%"><col width="4.7%"><col width="4.7%">
                <col width="4.7%"><col width="4.7%"><col width="4.7%"><col width="4.7%"><col width="4.7%">
                <col width="4.7%">
            </colgroup>
            <thead>
                <tr>
                    <th></th>
                    <th>No</th>
                    <th>이미지</th>
                    <th>프로필</th>
                    <th>회원번호<br/>닉네임</th>
                    <th>성별</th>
                    <th>연령</th>
                    <th>방송타입</th>
                    <th>게시여부</th>
                    <th>메인노출여부</th>
                    <th>누적 메인 노출 수</th>
                    <th>누적 메인 시간</th>
                    <th>기간내 팬 등록수</th>
                    <th>누적 팬등록수</th>
                    <th>기간내 관심 등록수</th>
                    <th>누적 관심등록수</th>
                    <th>최근 방송일시</th>
                    <th>최근 7일 방송시간</th>
                    <th>등록정보</th>
                    <th>게시 시작일</th>
                    <th>게시 종료일</th>
                </tr>
            </thead>
            <tbody id="recommendDj_tableBody">
            </tbody>
        </table>

        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
    </div>

    <div class="col-md-12 no-padding">
        <div class="widget-content" style="border-top-width:0px;">
            <span id="recommMemberInfo" ></span>
        </div>
    </div>
</div>
<div id="#imageFullSize"></div>
<!-- // DATA TABLE -->

<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    var recommendDjDjPagingInfo = new PAGING_INFO(0, 1, 50);


    var recommendIdx;
    function getParam() {
        recommendDjDjPagingInfo.pageNo = 1;

        return data = {
            slctType : $("#recomm_status").val()
            , startDate : $("#startDate").val()
            , endDate :  $("#endDate").val()
            , searchText: common.isEmpty($('#searchText').val()) ? "" : $('#searchText').val()
            , pageStart: recommendDjDjPagingInfo.pageNo
            , pageCnt: recommendDjDjPagingInfo.pageCnt
            , newSearchType : $("#searchMember").val()
        };
    }

    function recommendDjList() {
        util.getAjaxData("recommendDj", "/rest/menu/recomm/dj/list", getParam(), fn_recommendDj_success);
    }

    function fn_recommendDj_success(dst_id, response) {

        response.data.totalCnt = response.pagingVo.totalCnt;
        var template = $('#tmp_recommendDjList').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        $('#recommendDj_tableBody').html(html);

        response.pagingVo.pageNo = recommendDjDjPagingInfo.pageNo;
        response.pagingVo.pageCnt = recommendDjDjPagingInfo.pageCnt;


        if(response.data.length == 0) {
            $("#list_info_paginate").hide();
            $("#list_info_paginate_top").hide();
        } else {
            recommendDjDjPagingInfo.totalCnt = response.pagingVo.totalCnt;
            util.renderPagingNavigation('list_info_paginate_top', recommendDjDjPagingInfo);
            util.renderPagingNavigation('list_info_paginate', recommendDjDjPagingInfo);
            $("#list_info_paginate").show();
            $("#list_info_paginate_top").show();
        }

        var template = $('#tmp_recommendSummaryArea').html();
        var templateScript = Handlebars.compile(template);
        var context = response.summary;
        var html = templateScript(context);
        $('#recommendSummaryArea').html(html);
    }

    function handlebarsPaging(targetId, pagingInfo){
        recommendDjDjPagingInfo = pagingInfo;
        recommendDjList();
    }

    $(document).on('click', '#recommendDjList .dt-body-center input[type="checkbox"]', function() {
        if($(this).prop('checked')) {
            $('#recommendDjList .dt-body-center input[type="checkbox"]').removeAttr('checked');
            $(this).prop('checked', 'checked');
            $(this).parent().parent().find('._dalDetail').click();
        }
    });

    $(document).on('click', '#recommendDjDel', function() {
        if(confirm("추천DJ 삭제하시겠습니까?")) {
            var checked = $('#recommendDj_tableBody > tr > td > input[type=checkbox]:checked');
            if(checked.length == 0) {
                alert('삭제할 추천DJ를 선택해주세요.');
                return false;
            }

            var memNo="";
            checked.each(function () {
                memNo += $(this).parent().parent().find('._check').data('memno') + "@@";
            });

            var data = {
                memNoList: memNo
            };

            util.getAjaxData("delete", "/rest/menu/recomm/delete", data, function (dst_id, response){
                alert(response.message);
                $("#bt_search").click();
            });
        }
    });

    function fullSize_background(url) {
        if(common.isEmpty(url)){
            return;
        }
        $("#imageFullSize").html(util.imageFullSize("fullSize_background", url));
        $('#fullSize_background').modal('show');
    }

        $('#memSearch').on('click', function() {
        showPopMemberList(recommendDjChoiceMember);
    });


    function recommendDjChoiceMember(data) {
        if(confirm('추천 DJ로 등록하시겠습니까?')){
            recommendIdx = 0;
            var obj = {
                idx : 0
                , memNo : data.mem_no
                , startDate : $("#startDate").val()
                , endDate :  $("#endDate").val()
            };
            util.getAjaxData("recomm", "/rest/menu/recomm/dj/detail", obj, fn_recommDjDetail_success);
        }
        return false;
    }

    function recommendDjDetail(data){
        recommendIdx = data.idx;
        util.getAjaxData("recomm", "/rest/menu/recomm/dj/detail", data, fn_recommDjDetail_success);
    }

    function fn_recommDjDetail_success(dst_id, response, param){

        var template = $('#tmp_recommMemberInfo').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $('#recommMemberInfo').html(html);

        recommendSetEvent();
    }

    function recommendSetEvent(){
        $(".imageUrlPreview").on('click', function(){
            getImg($("#txt_imageUrl").val(), 1);
        });

        $(".imageProfilePreview").on('click', function(){
            getImg($("#txt_imageProfile").val(), 2);
        });

    }

    function getImg(imageUrl, gubun) {
        if(gubun == 1){
            $("#imageUrl").attr('src',imageUrl);
        }else{
            $("#imageProfile").attr('src',imageUrl);
        }
    }


    function recommEdit() {
        if(confirm('추천 DJ를 저장 하시겠습니까?')) {
            var data = {
                idx : recommendIdx
                , memNo: $("#memNo").text()
                , memSex: $("input[name='memSex']:checked").val()
                , ageType: $("input[name='ageType']:checked").val()
                , viewYn: $("input[name='view_yn']:checked").val()
                , mainRecomm: $("input[name='main_recomm']:checked").val()
                , broadcastType: $("input[name='broadcastType']:checked").val()
                , imageUrl : $("#txt_imageUrl").val()
                , imageProfile : $("#txt_imageProfile").val()
                , startDate : $("#startDate").val()
                , endDate : $("#endDate").val()
            };

            console.log(data);

            util.getAjaxData("recomm", "/rest/menu/recomm/dj/edit", data, function (dst_id, response){
                alert(response.message);
                $("#recommMemberInfo").empty();
                $("#bt_search").click();
            });
        }
    }

</script>

<script id="tmp_recommendDjList" type="text/x-handlebars-template">
    {{#each this.data}}
    <tr {{#dalbit_if inner '==' 1}} class="bg-testMember" {{/dalbit_if}} >
        <td class=" dt-body-center">
            <input type="checkbox" class="form-control _check" data-memno="{{memNo}}"/>
        </td>
        <td>{{rowNumDesc ../pagingVo/totalCnt @index ../pagingVo/pageNo ../pagingVo/pageCnt}}</td>
        <td style="width: 65px;height:65px;">
            <img class="thumbnail" src="{{renderImage imageUrl}}" style="width: 65px;height:65px; margin-bottom: 0px;" onclick="fullSize_background(this.src);"/>
        </td>
        <td style="width: 65px;height:65px;">
            <img class="thumbnail" src="{{renderImage imageProfile}}" style="width: 65px;height:65px; margin-bottom: 0px;" onclick="fullSize_background(this.src);"/>
        </td>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memno="{{memNo}}">{{memNo}}</a><br/>
            <a href="javascript://" class="" onclick="recommendDjDetail($(this).data())" data-idx="{{idx}}" data-memno="{{memNo}}">{{memNick}}</a>
        </td>
        <td>{{{sexIcon memSex memBirthYear}}}</td>
        <td>{{{getCommonCodeLabel ageType 'ageType'}}}</td>
        <td>{{{getCommonCodeLabel broadcastType 'broadcastType'}}}</td>
        <td>{{{getCommonCodeLabel viewYn 'content_viewOn'}}}</td>
        <td>{{{getCommonCodeLabel mainRecomm 'content_viewOn'}}}</td>
        <td>{{addComma mainRecommendCnt}}</td>
        <td>{{timeStamp mainRecommendTime}}</td>
        <td>{{addComma recommendFanCnt}}</td>
        <td>{{addComma fanCnt}}</td>
        <td></td>
        <td></td>
        <td>{{substr lastBroadcast 0 19}}</td>
        <td>{{timeStampDay broadcastTime}}</td>
        <td>{{regOpName}}<br/>{{updOpName}}</td>
        <td>{{substr recommendStart 0 19}}</td>
        <td>{{substr recommendEnd 0 19}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="13">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>


<script id="tmp_recommMemberInfo" type="text/x-handlebars-template">

    <button type="button" class="btn btn-success pull-right" id="recommEdit" onclick="recommEdit();">저장</button>

    <table class="table table-sorting table-hover table-bordered mt15" style="width: 100%">
        <colgroup>
            <col width="8%"><col width="7%"><col width="10%"><col width="7%"><col width="10%">
            <col width="12%"><col width="10%"><col width="10%"><col width="10%"><col width="10%">
        </colgroup>
        <tr>
            <th>No</th>
            <td>{{idx}}</td>
            <th>회원번호</th>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memno="{{memNo}}" id="memNo">{{memNo}}</a>
            </td>
            <th>닉네임</th>
            <td>{{memNick}}</td>
            <th>등록일시</th>
            <td>{{regDate}}</td>
            <th>등록자</th>
            <td>{{regOpName}}</td>
        </tr>
        <tr>
            <th>게시여부</th>
            <td>{{{getCommonCodeRadio viewYn 'content_viewOn' 'N' 'view_yn'}}}</td>
            <th>메인 추천 DJ</th>
            <td>{{{getCommonCodeRadio mainRecomm 'content_viewOn' 'N' 'main_recomm'}}}</td>
            <th>방송타입</th>
            <td>{{{getCommonCodeRadio broadcastType 'broadcastType'}}}</td>
            <th>최종수정일시</th>
            <td>{{updDate}}</td>
            <th>최종수정자</th>
            <td>{{updOpName}}</td>

        </tr>
        <tr>
            <th>나이</th>
            <td colspan="3">{{{getCommonCodeRadio ageType 'ageType'}}}</td>
            <th>성별</th>
            <td>{{{getCommonCodeRadio memSex 'memSex'}}}</td>
            <th>최근 3개월 방송 시간</th>
            <td>{{timeStampDay broadcastTime}}</td>
            <th>최근 3개월 방송 횟수</th>
            <td>{{timeStampDay broadcastCnt}} 회</td>


        </tr>
        <tr>
            <th>소개 이미지 등록</th>
            <td colspan="2">
                <input type="text" class="form-control pull-left" id="txt_imageUrl" style="width: 100%;" value="{{imageUrl}}">
            </td>
            <td>
                <input type="button" class="btn-default imageUrlPreview" value="미리보기" style="margin-top: 3px;">
            </td>
            <td>
                <img class="thumbnail fullSize_background no-padding" src="{{renderImage imageUrl}}" id="imageUrl" style='height:auto; width:100%;margin-bottom: 0px' />
            </td>

            <th>프로필 이미지 등록</th>
            <td colspan="2">
                <input type="text" class="form-control pull-left" id="txt_imageProfile" style="width: 100%;" value="{{imageProfile}}">
            </td>
            <td>
                <input type="button" class="btn-default imageProfilePreview" value="미리보기" style="margin-top: 3px;">
            </td>
            <td>
                <img class="thumbnail fullSize_background no-padding" src="{{renderImage imageProfile}}" id="imageProfile" style='height:auto; width:100%;margin-bottom: 0px' />
            </td>
        </tr>
    </table>
</script>


<script id="tmp_recommendSummaryArea" type="text/x-handlebars-template">

    <table class="table table-sorting table-hover table-bordered" style="width: 100%">
        <colgroup>
            <%--<col width="8%">--%>
        </colgroup>
        <tr>
            <th rowspan="2"></th>
            <th rowspan="2">전체</th>
            <th colspan="2">성별</th>
            <th colspan="2">방송</th>
        </tr>
        <tr>
            <th>남성</th>
            <th>여성</th>
            <th>영상</th>
            <th>라디오</th>
        </tr>
        <tr>
            <th>DJ 등록수</th>
            <td>{{totalCnt}}</td>
            <td>{{maleCnt}}</td>
            <td>{{femaleCnt}}</td>
            <td>{{audioCnt}}</td>
            <td>{{videoCnt}}</td>
        </tr>
        <tr>
            <th>팬 등록수</th>
            <td>{{fanCnt}}</td>
            <td>{{fanMaleCnt}}</td>
            <td>{{fanFemaleCnt}}</td>
            <td>{{fanAudioCnt}}</td>
            <td>{{fanVideoCnt}}</td>
        </tr>
    </table>
</script>