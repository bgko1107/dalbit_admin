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
                    <div class="widget-header searchBoxRow">
                        <h3 class="title"><i class="fa fa-search"></i> 검색</h3>
                        <div>
                            <span id="searchArea"></span>
                            <label><input type="text" class="form-control" id="txt_search" name="txt_search"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                        </div>
                    </div>
                </div>
            </div>
            </form>
            <!-- //serachBox -->

            <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="rankTab">
                <%--<li class="active">
                    <a href="javascript://" role="tab" data-toggle="tab" data-rank="shot"><i class="fa fa-home"></i> 인증샷</a>
                </li>
                <li>
                    <a href="javascript://" role="tab" data-toggle="tab" data-rank="knowhow"><i class="fa fa-user"></i> 노하우</a>
                </li>--%>
            </ul>
            <!-- DATA TABLE -->
            <div class="widget widget-table">
                <div class="widget-content" style="border-top-width:0px;">
                    <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>--%>
                    <table id="shotList" class="table table-sorting table-hover table-bordered mt15">
                        <colgroup>
                            <%--<col width="2%"/>--%>
                            <col width="3%"/>
                            <col width="10%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="10%"/>
                            <col width="5%"/>
                            <col width="5%"/>
                            <col width="2%"/>
                        </colgroup>
                        <thead>
                            <tr>
                                <%--<th><input type="checkbox" id="allChk" /></th>--%>
                                <th>No</th>
                                <th>회원번호</th>
                                <th>닉네임</th>
                                <th>성별(나이)</th>
                                <th>신청일</th>
                                <th>이름</th>
                                <th>연락처</th>
                                <th>상세</th>
                            </tr>
                        </thead>
                        <tbody id="shotTableBody">
                        </tbody>
                    </table>

                    <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>

                    <div class="widget-footer">
                        <%--<span>
                            <button class="btn btn-sm btn-danger" type="button" id="deleteBtn"><i class="fa fa-trash-o"></i> 선택삭제</button>
                        </span>--%>
                        <span>
                            <button class="btn btn-sm btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i> Excel Down</button>
                        </span>
                    </div>
                </div>
            </div>
            <!-- // DATA TABLE -->

            <div class="mt15">
                <form id="webcamDetailArea"></form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
     shotListPagingInfo = new PAGING_INFO(0, 1, 50);

    $(function(){
        $("#searchArea").html(util.getCommonCodeSelect(9999, searchType));
        init();
    });

    function init(){
        var data = {
            rankType : $('input:radio[name="rankType"]:checked').val()
            , pageStart : shotListPagingInfo.pageNo
            , pageCnt : shotListPagingInfo.pageCnt
            , searchType : $('#searchType').val()
            , txt_search : $("#txt_search").val()
        }
        util.getAjaxData('shotList', "/rest/content/event/webcam/list", data, function (dst_id, response, params) {
            var template = $('#tmp_webcamList').html();
            var templateScript = Handlebars.compile(template);
            var context = response;
            var html = templateScript(context);
            $("#shotTableBody").html(html);

            var pagingInfo = response.pagingVo;
            shotListPagingInfo.totalCnt = pagingInfo.totalCnt;
            util.renderPagingNavigation('list_info_paginate_top', shotListPagingInfo);
            util.renderPagingNavigation('list_info_paginate', shotListPagingInfo);
        });

        //$("#allChk").prop('checked', false);

        $("#webcamDetailArea").empty();
    }


    $('#bt_search').on('click', function() {
        init();
    });

    $('input[id="txt_search"]').on('keydown', function(e) {
        if(e.keyCode == 13) {
            init();
        };
    });

    function handlebarsPaging(targetId, pagingInfo){
        shotListPagingInfo = pagingInfo;
        init();
    }

    $('#bt_search').on('click', function() {
        init();
    });

    $(document).on('click', '._detailBtn', function(){
        var me = $(this);
        var data = {
            idx : me.data('idx')
        }
        util.getAjaxData('good', "/rest/content/event/webcam/detail", data, function(dist_id, response){
            var template = $('#tmp_webcamDetail').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#webcamDetailArea").html(html).show();
            ui.bottomScroll();
        });

    });


    $('#excelDownBtn').on('click', function() {
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        formData.append("txt_search", $("#txt_search").val());
        formData.append("searchType", $('#searchType').val());
        formData.append("pageCnt", 99999);
        formData.append("pageStart", 1);

        util.excelDownload($(this), "/rest/content/event/photo/shot/excel", formData);
    });
</script>

<script type="text/x-handlebars-template" id="tmp_webcamList">
    {{#each this.data as |item|}}
        <tr>
            <!--<td>
                <input type='checkbox' class='_chk' data-idx='{{item.idx}}' />
            </td>-->
            <td>
                {{indexDesc ../pagingVo.totalCnt item.rowNum}}
            </td>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memNo="{{item.mem_no}}">{{item.mem_no}}</a>
            </td>
            <td>{{item.mem_nick}}</td>
            <td>{{{sexIcon item.mem_sex item.mem_birth_year}}}</td>
            <td>{{item.reg_date}}</td>
            <td>{{item.mem_name}}</td>
            <td>{{item.mem_phone}}</td>
            <td><button type="button" class="btn btn-success btn-sm _detailBtn" data-idx={{item.idx}}>상세</button></td>
        </tr>

        {{else}}
            <tr>
                <td colspan="9">{{isEmptyData}}</td>
            </tr>
        {{/each}}
</script>

<script id="tmp_webcamDetail" type="text/x-handlebars-template">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3><i class="fa fa-desktop"></i> 노하우 세부내용</h3>
        </div>
        <div class="widget-content mt15 mb15">
            <div class="row col-lg-12 form-inline">
                <table class="table table-bordered table-dalbit">
                    <colgroup>
                        <col width="10%">
                        <col width="20%">
                        <col width="10%">
                        <col width="20%">
                        <col width="10%">
                        <col width="20%">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th>회원번호</th>
                        <td>{{mem_no}}</td>
                        <th>닉네임</th>
                        <td>
                            {{mem_nick}}
                        </td>
                        <th>성별</th>
                        <td>
                            {{{sexIcon mem_sex mem_birth_year}}}
                        </td>
                    </tr>
                    <tr>
                        <th>참여일시</th>
                        <td>{{reg_date}}</td>
                        <th>참여자 이름</th>
                        <td>{{mem_name}}</td>
                        <th>휴대폰번호</th>
                        <td>{{mem_phone}}</td>
                    </tr>
                    <tr>
                        <th>우변번호</th>
                        <td>{{image_url}}</td>
                        <th>주소</th>
                        <td>{{image_url2}}</td>
                        <th>상세주소</th>
                        <td>{{image_url3}}</td>
                    </tr>
                    <tr>
                        <th>방송장비</th>
                        <td colspan="5">
                            <p style="width:100%;white-space: pre-line;">{{{replaceEnter device1}}}</p>
                        </td>
                    </tr>

                    <tr>
                        <th>방송소개</th>
                        <td colspan="5">
                            <p style="width:100%;white-space: pre-line;">{{{replaceEnter contents}}}</p>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</script>