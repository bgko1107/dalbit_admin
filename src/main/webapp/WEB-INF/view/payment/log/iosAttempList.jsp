<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">
            <h3>IOS inApp 결제시도 확인</h3>
            <!-- searchBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">

                                    <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>

                                    <input type="text" class="form-control" id="onedayDate" name="onedayDate">

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <span id="searchTypeArea" style="display: none"></span>
                                    <span id="searchMemberArea" onchange="getErrorList();"></span>
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요."></label>

                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>

                                </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- // searchBox -->

            <!-- error log table-->
            <div class="row col-lg-12 form-inline">
                <%--<span>
                    <button class="btn btn-default print-btn" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
                </span>--%>
                <div class="widget widget-table">
                    <div class="widget-content">
                        <table class="table table-bordered table-summary" id="Summary">
                            <thead>
                            <tr>
                                <th><span id="type">총</span> : <span id="total"></span> 건 </th>
                            </tr>
                            </thead>
                            <tbody id="summaryDataTable">
                            </tbody>
                        </table>
                        <table id="errorList" class="table table-sorting table-hover table-bordered datatable">
                            <thead>
                            <th>no</th>
                            <th>회원상태</th>
                            <th>프로필이미지</th>
                            <th>회원번호</th>
                            <th>닉네임</th>
                            <th>이름</th>
                            <th>상품명</th>
                            <th>상품가격</th>
                            <th>시도일시</th>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../searchArea/daySearchFunction.jsp"/>

<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/payment/payCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    var errorPagingInfo = new PAGING_INFO(0, 1, 500);

    var slctType = 3;
    $(document).ready(function() {
        $("#searchTypeArea").html(util.getCommonCodeSelect(-1, attempSearchType));
        $("#searchMemberArea").html(util.getCommonCodeSelect(1, searchMember));

        dateType(slctType);
    });

    $('input[id="searchText"]').keydown(function(e) {
        if (e.keyCode === 13) {
            errorPagingInfo.pageNo = 1;
            getErrorList();
        };
    });

    $('#bt_search').click( function() {       //검색
        errorPagingInfo.pageNo = 1;
        getErrorList();
    });

    function getErrorList(){
        $("#pageStart").val(errorPagingInfo.pageNo);
        $("#pageCnt").val(errorPagingInfo.pageCnt);

        var data = {
            pageStart : errorPagingInfo.pageNo
            ,pageCnt : errorPagingInfo.pageCnt
            ,txt_startSel : $('#startDate').val()
            ,txt_endSel : $('#endDate').val()
            ,searchType : $('#searchType').val()
            ,searchText : $("#searchText").val()
            ,newSearchType : $("#searchMember").val()
        };

       util.getAjaxData("attempList", "/rest/payment/pay/iosAttempList", data, fn_success);
    }

    function fn_success(dst_id, response) {
        var template = $('#tmp_errorList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $("#tableBody").html(html);
        $("#total").html(response.data.attempCnt);

        errorPagingInfo.totalCnt = response.data.totalCnt;
        console.log(errorPagingInfo);
        util.renderPagingNavigation("list_info_paginate", errorPagingInfo);

        if(response.data.length == 0) {
            $("#list_info_paginate").hide();
        } else {
            $("#list_info_paginate").show();
        }

    }

    function handlebarsPaging(targetId, pagingInfo){
        errorPagingInfo = pagingInfo;
        getErrorList();
    }

    $("#excelDownBtn").on('click', function() {
        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);
        formData.append("pageStart", $("#pageStart").val());
        formData.append("pageCnt", $("#pageCnt").val());
        formData.append("txt_startSel", $("#startDate").val());
        formData.append("txt_endSel", $("#endDate").val());
        formData.append("ostype", $("#ostype").val());
        formData.append("searchText", $("#searchText").val());

        util.excelDownload($(this), "/rest/sample/errorListExcel", formData);
    });

</script>

<script id="tmp_errorList" type="text/x-handlebars-template">
    {{#each this.attempList}}
        <tr>
            <td>{{indexDesc ../attempCnt rowNum}}</td>
            <td>{{{getMemStateName mem_state}}}</td>
            <td>
                <img src="{{renderProfileImage image_profile}}" class="thumbnail fullSize_background no-padding no-margin" style='width:68px;height:68px;margin-bottom: 0px' />
            </td>
            <td>{{{memNoLink mem_no mem_no}}}</td>
            <td>{{mem_nick}}</td>
            <td>{{mem_name}}</td>
            <td>{{product_nm}}</td>
            <td>{{product_price}}</td>
            <td>{{attempt_date}}</td>
        </tr>
    {{else}}
        <tr>
            <td colspan="9">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>