<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="widget widget-table">
    <div class="row col-md-12 mt15">
        <div class="pull-left ml5 mb15">
            · 다음 달을 선택 후 대상자 직접등록을 하면, 다음달 15일부터 샤이닝DJ가 적용됩니다.<br/>
            · 샤이닝 DJ 자격은 1개월(당월 15일~익월 14일) 동안 유지됩니다.
        </div>

        <!--운영자 등록 버튼 -->
        <button type="button" class="btn btn-primary pull-right" id="memSearch" name="memSearch"><i class="fa fa-search"></i>운영자 직접 등록</button>
    </div>

    <div class="widget-content" style="border-top-width:0px;">
        <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>--%>

        <table id="specialList" class="table table-sorting table-hover table-bordered mt15">
            <thead>
                <tr>
                    <th></th>
                    <th>No</th>
                    <th>프로필</th>
                    <th>회원번호</th>
                    <th>닉네임</th>
                    <th>성별</th>
                    <th>보유팬</th>
                    <th>누적 방송시간</th>
                    <th>누적 받은 별</th>
                    <th>받은 좋아요</th>
                    <th>최근 3개월 내 방송일</th>
                    <th>정지기록</th>
                    <th>등록자</th>
                </tr>
            </thead>
            <tbody id="shining_tableBody">
            </tbody>
        </table>

        <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>--%>
        <button type="button" class="btn btn-danger mb10" id="shiningDel">삭제</button>
    </div>
</div>
<div id="#imageFullSize"></div>
<!-- // DATA TABLE -->

<div class="mt15">
    <form id="dalList"></form>
    <form id="sampleDalList"></form>
</div>

<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    var shiningDjPagingInfo = new PAGING_INFO(0, 1, 99999);


    function getParam() {
        shiningDjPagingInfo.pageNo = 1;

        return data = {
            startDate : $("#startDate").val()
            , endDate :  $("#endDate").val()
            , searchText: $('#searchText').val()
            , pageStart: shiningDjPagingInfo.pageNo
            , pageCnt: shiningDjPagingInfo.pageCnt
        };
    }

    function shiningList() {
        util.getAjaxData("shining", "/rest/menu/shining/list", getParam(), fn_shiningList_success);
    }

    function fn_shiningList_success(dst_id, response) {

        response.data.totalCnt = response.pagingVo.totalCnt;
        var template = $('#tmp_shiningList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $('#shining_tableBody').html(html);

        if(response.data.length == 0) {
            $("#list_info_paginate").hide();
            $("#list_info_paginate_top").hide();
        } else {
            shiningDjPagingInfo.totalCnt = response.pagingVo.totalCnt;
            util.renderPagingNavigation('list_info_paginate_top', shiningDjPagingInfo);
            util.renderPagingNavigation('list_info_paginate', shiningDjPagingInfo);
            $("#list_info_paginate").show();
            $("#list_info_paginate_top").show();
        }
    }

    function handlebarsPaging(targetId, pagingInfo){
        shiningDjPagingInfo = pagingInfo;
        shiningList();
    }

    $(document).on('click', '#shiningList .dt-body-center input[type="checkbox"]', function() {
        if($(this).prop('checked')) {
            $('#shiningList .dt-body-center input[type="checkbox"]').removeAttr('checked');
            $(this).prop('checked', 'checked');
            $(this).parent().parent().find('._dalDetail').click();
        } else {
            $('#dalList').empty();
            $('#sampleDalList').empty();
        }
    });

    $(document).on('click', '#shiningDel', function() {
        if(confirm("샤이닝DJ 취소하시겠습니까?")) {
            var checked = $('#shining_tableBody > tr > td > input[type=checkbox]:checked');
            if(checked.length == 0) {
                alert('삭제할 샤이닝DJ를 선택해주세요.');
                return false;
            }

            var memNo="";
            checked.each(function () {
                memNo += $(this).parent().parent().find('._check').data('memno') + "@@";
            });

            var data = {
                memNo: memNo
                , startDate: $("#startDate").val().substr(0,7) + ".15"
                , badgeType : 10
            };

            util.getAjaxData("delete", "/rest/menu/shining/delete", data, fn_shiningDelete_success);
        }
    });

    function fn_shiningDelete_success(dst_id, response) {
        alert(response.message);
        $("#bt_search").click();
    }

    function fullSize_background(url) {
        if(common.isEmpty(url)){
            return;
        }

        $("#imageFullSize").html(util.imageFullSize("fullSize_background", url));
        $('#fullSize_background').modal('show');
    }

    function modal_close(){
        $("#fullSize_background").modal('hide');
    }

    $('#memSearch').on('click', function() {
        showPopMemberList(shiningChoiceMember);
    });


    function shiningChoiceMember(data) {
        if(confirm($("#startDate").val().substr(0,7) + ' 월의 샤이닝 DJ로 등록하시겠습니까?')){
            var endDate = moment($("#startDate").val()).add('months', 1).format('YYYY.MM');
            var obj = {
                memNo : data.mem_no
                ,badgeType : 10
                ,badgeRank : 1
                ,startDate : $("#startDate").val().substr(0,7) + ".15"
                ,endDate : endDate + ".14"
            };
            util.getAjaxData("addShining", "/rest/menu/shining/add", obj, fn_addShining_success);
        }
        return false;
    }
</script>

<script id="tmp_shiningList" type="text/x-handlebars-template">
    {{#each this}}
    <tr {{#dalbit_if inner '==' 1}} class="bg-testMember" {{/dalbit_if}} >
        <td class=" dt-body-center">
            <input type="checkbox" class="form-control _check" data-memno="{{memNo}}"/>
        </td>
        <td>{{indexDesc ../totalCnt rowNum}}</td>
        <td style="width: 65px;height:65px;">
            <img class="thumbnail" src="{{renderProfileImage profileImage memSex}}" style="width: 65px;height:65px; margin-bottom: 0px;" onclick="fullSize_background(this.src);"/>
        </td>
        <td><a href="javascript://" class="_openMemberPop" data-memno="{{memNo}}">{{memNo}}</a></td>
        <td>{{nickName}}</td>
        <td>{{{sexIcon memSex memBirthYear}}}</td>
        <td>{{addComma fanCnt}} 명</td>
        <td>{{timeStampDay broadCastTime}}</td>
        <td>{{addComma totalByeol}} 개</td>
        <td>{{addComma totalGood}} 개</td>
        <td>{{broadCastDate}}</td>
        <td>{{addComma reportCnt}} 회</td>
        <td>{{opName}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="12">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>
