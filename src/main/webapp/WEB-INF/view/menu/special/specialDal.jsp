<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- DATA TABLE -->
<div class="widget widget-table">
    <%--<div class="widget-header">--%>
        <%--<h3><i class="fa fa-desktop"></i> 검색결과</h3>--%>
    <%--</div>--%>
        <div class="row col-md-12 mt15">
            <div class="pull-left ml5 mb15">
                ㆍ 해당 월의 스페셜 DJ입니다. <br/>
                ㆍ 운영자 직접 등록 시 해당 월 1일부터 바로 스페셜 DJ가 적용됩니다. <br/>
                ㆍ 스페셜 DJ 자격은 1개월(당월 1일~당월 말일) 동안 유지됩니다.
            </div>

            <!-- summary & 운영자 등록 버튼 -->
            <div class="pull-right ml5 mb15">
                <button type="button" class="btn btn-primary pull-right mt10 mr15" id="memSearch" name="memSearch"><i class="fa fa-search"></i>운영자 직접 등록</button>
            </div>
            <!-- //summary -->
        </div>

    <div class="widget-content" style="border-top-width:0px;">
        <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>--%>

        <table id="specialList" class="table table-sorting table-hover table-bordered mt15">
            <thead>
                <tr>
                    <th></th>
                    <th>No</th>
                    <th>방송상태</th>
                    <th>프로필</th>
                    <th>회원번호</th>
                    <th>User닉네임</th>
                    <th>성별</th>
                    <th>보유팬</th>
                    <th>누적 방송시간</th>
                    <th>누적 받은 별</th>
                    <th>받은 좋아요</th>
                    <th>받은 부스터</th>
                    <th>최근 3개월 내 방송일</th>
                    <th>정지기록</th>
                    <th>관리자 등록여부</th>
                    <th>등록자</th>
                    <th style="display:none;">순서</th>
                </tr>
            </thead>
            <tbody id="special_tableBody">
            </tbody>
        </table>

        <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>--%>

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

    var specialDjPagingInfo = new PAGING_INFO(0, 1, 99999);

    function init() {
        specialList();
    }

    function getParam() {
        return data = {
            select_year : common.substr($("#startDate").val(),0,4)
            , select_month :  common.substr($("#startDate").val(),5,2)
            , txt_search: $('#searchText').val()
            , searchType: $('#searchType').val()
            , pageStart: specialDjPagingInfo.pageNo
            , pageCnt: specialDjPagingInfo.pageCnt
        };
    }

    function specialList() {
        util.getAjaxData("special", "/rest/menu/special/dalList", getParam(), fn_dalList_success);
    }


    var totalCnt;
    function fn_dalList_success(dst_id, response) {
        var template = $('#tmp_specialList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $('#special_tableBody').html(html);

        var pagingInfo = response.pagingVo;
        specialDjPagingInfo.totalCnt = pagingInfo.totalCnt;
        totalCnt = specialDjPagingInfo.totalCnt;
        console.log(specialDjPagingInfo);
        util.renderPagingNavigation('list_info_paginate_top', specialDjPagingInfo);
        util.renderPagingNavigation('list_info_paginate', specialDjPagingInfo);

        if(response.data.length == 0) {
            $("#list_info_paginate").hide();
            $("#list_info_paginate_top").hide();
        } else {
            $("#list_info_paginate").show();
            $("#list_info_paginate_top").show();
        }
    }

    var approveDal;
    function fn_compareSummary(dst_id, response) {
        approveDal = response.data.approveDal;
    }



    function handlebarsPaging(targetId, pagingInfo){
        specialDjPagingInfo = pagingInfo;
        init();
    }

    $(document).on('click', '._dalDetail', function() {

        var me = $(this);

        var obj = {
            req_idx : me.data('reqidx')
            , mem_no : me.parent().find('._openMemberPop').data('memno')
            , select_year:  common.substr($("#startDate").val(),0,4)
            , select_month: common.substr($("#startDate").val(),5,2)
        };
        util.getAjaxData("detail", "/rest/menu/special/dalDetail", obj, fn_success_dalDetail);
    });

    $(document).on('click', '#specialList .dt-body-center input[type="checkbox"]', function() {
        if($(this).prop('checked')) {
            $('#specialList .dt-body-center input[type="checkbox"]').removeAttr('checked');
            $(this).prop('checked', 'checked');
            $(this).parent().parent().find('._dalDetail').click();
        } else {
            $('#dalList').empty();
            $('#sampleDalList').empty();
        }
    });

    function fn_success_dalDetail(dst_id, response) {
        if(response.data.is_force == 0) {
            var template = $('#tmp_dalList').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);

            $('#dalList').html(html);
            $('#sampleDalList').hide();
            $('#dalList').show();
            ui.scrollIntoView('dalList');
            $('#contents').attr("disabled", "disabled");

        } else if(response.data.is_force == 1) {
            var template = $('#tmp_sampleDalList').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $('#sampleDalList').html(html);
            $('#dalList').hide();
            $('#sampleDalList').show();
            ui.scrollIntoView('sampleDalList');
            $('#sampleDalList').focus();
        }
    }

    $(document).on('click', '#bt_reqCancel, #bt_reqCancel_2', function() {
        if(confirm("스페셜 DJ에서 일반 DJ로 승인 취소하시겠습니까?")) {
           var checkbox = $('#specialList > tbody > tr > td.dt-body-center > input[type=checkbox]:checked');
           var data = {
               'req_idx' : checkbox.parent().parent().find('._dalDetail').data('reqidx')
               , 'mem_no' : checkbox.parent().parent().find('._openMemberPop').data('memno')
               , select_year:  common.substr($("#startDate").val(),0,4)
               , select_month: common.substr($("#startDate").val(),5,2)
           };
            dalbitLog(data);
            util.getAjaxData("cancel", "/rest/menu/special/reqCancel", data, fn_success_cancel);
        }
        return false;
    });

    function fn_success_cancel(dst_id, response) {
        alert(response.message);
        getList();
    }

    $('#bt_edit').on('click', function() {
        if(approveDal > totalCnt) {
            alert('순위 변경은 스페셜 DJ 전체목록에서 가능합니다.');
            return false;
        }
        var orderDataArr = new Array();
        $('._noTr').each(function(i) {
            var mem_no = $(this).find('._openMemberPop').data('memno');
            var order = i + 1;
            var data = {
                mem_no : mem_no
                , order : order
            };
            orderDataArr.push(data);
        });

        var param = {
            orderJsonData : JSON.stringify(orderDataArr)
        };

        util.getAjaxData("updateOrder", "/rest/menu/special/updateOrder", param, fn_updateOrder_success);
    });

    function fn_updateOrder_success(dst_id, response) {
        alert(response.message);
        init();
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
        showPopMemberList(choiceMember);
    });
</script>

<script id="tmp_specialList" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr {{#dalbit_if inner '==' 1}} class="_noTr bg-testMember" {{else}} class="_noTr" {{/dalbit_if}} id="row_{{order}}">
        <td class=" dt-body-center"><input type="checkbox"/></td>
        <td class="_noTd">
            <input type="hidden" name="sortNo" value="{{sortNo}}"/>
        </td>
        <td>{{{renderOnAir onAir}}}</td>
        <td style="width: 65px;height:65px;">
            <img class="thumbnail" src="{{renderProfileImage data.image_profile data.mem_sex}}" style="width: 65px;height:65px; margin-bottom: 0px;" onclick="fullSize_background(this.src);"/>
        </td>
        <td><a href="javascript://" class="_openMemberPop" data-memno="{{mem_no}}">{{mem_no}}</a>
            <a href="javascript://" style="display:none;" class="_dalDetail" data-reqidx="{{req_idx}}"></a>
        </td>
        <td>{{mem_nick}}</td>
        <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
        <td>{{addComma fanCnt}} 명</td>
        <td>{{timeStampDay airTime}}</td>
        <td>{{addComma giftedRuby}} 개</td>
        <td>{{addComma likeCnt}} 개</td>
        <td>{{addComma boostCnt}} 개</td>
        <td>{{addComma broadcastCnt}} 일</td>
        <td>{{addComma reportCnt}} 회</td>
        <td>{{{getCommonCodeLabel is_force 'special_isForce'}}}</td>
        <td style="display:none;">{{order}}</td>
        <td>{{op_name}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="15">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>

<script id="tmp_dalList" type="text/x-handlebars-template">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3><i class="fa fa-desktop"></i> 스페셜 달D 세부사항</h3>
        </div>
        <div class="widget-content mt15">
            <div class="row col-lg-12 form-inline">
                <table class="table table-bordered table-dalbit">
                    <input type="hidden" name="reqIdx" data-idx="{{req_idx}}"/>
                    <tr>
                        <th>신청일시</th>
                        <td>{{convertToDate request_date 'YYYY-MM-DD HH:mm:ss'}}</td>
                        <th>승인일시</th>
                        <td>{{convertToDate reg_date 'YYYY-MM-DD HH:mm:ss'}}</td>
                        <th>관리자 등록 여부</th>
                        <td>
                            {{#equal is_force '0'}}N{{/equal}}
                            {{^equal is_force '0'}}Y{{/equal}}
                        </td>
                    </tr>

                    <tr>
                        <th>제목</th>
                        <td colspan="5">{{title}}</td>
                    </tr>
                    <tr>
                        <th>신청내용</th>
                        <td colspan="5" style="height:300px">
                            <textarea type="textarea" class="form-control" id="contents" name="contents" style="width: 100%; height: 100%">{{contents}}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <th>스페셜DJ 선정 연도</th>
                        <td colspan="2">{{select_year}}년</td>
                        <th>선정 월</th>
                        <td colspan="2">{{select_month}}월</td>
                    </tr>
                </table>
                <!-- 승인취소 -->
                <button type="button" class="btn btn-danger btn-sm mb15" id="bt_reqCancel">승인취소</button>
            </div>
        </div>
    </div>
</script>

<script id="tmp_sampleDalList" type="text/x-handlebars-template">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3><i class="fa fa-desktop"></i> 스페셜 달D 세부사항</h3>
        </div>
        <div class="widget-content mt15">
            <div class="row col-lg-12 form-inline">
                <table class="table table-bordered table-dalbit">
                    <input type="hidden" name="reqIdx" data-idx="{{req_idx}}"/>
                    <colgroup>
                        <col width="15%"/>
                        <col width="15%"/>
                        <col width="15%"/>
                        <col width="15%"/>
                        <col width="15%"/>
                        <col width="15%"/>
                    </colgroup>
                    <tr>
                        <th>등록일시</th>
                        <td>{{convertToDate reg_date 'YYYY-MM-DD HH:mm:ss'}}</td>
                        <th>스페셜DJ 선정 년/월</th>
                        <td >{{select_year}}년 {{select_month}}월</td>
                        <th>관리자 등록 여부</th>
                        <td>
                            {{#equal is_force '0'}}N{{/equal}}
                            {{^equal is_force '0'}}Y{{/equal}}
                        </td>
                    </tr>
                </table>
                <!-- 승인취소-->
                <button type="button" class="btn btn-danger btn-sm mb15" id="bt_reqCancel_2">승인취소</button>
            </div>
        </div>
    </div>
</script>