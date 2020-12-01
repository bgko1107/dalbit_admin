<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>
<%
    String in_clipNo = request.getParameter("clipNo");
    String in_year = request.getParameter("year");
    String in_month = request.getParameter("month");
%>


<div id="wrapper">
    <div id="page-wrapper">
        <div class="no-padding">
            <h4>클립 청취 횟수 상세 보기</h4>
            <!-- 클립상세정보 -->
            <form id="clipDetail"></form>

            <!-- 검색 조건 -->
            <div class="widget widget-table searchBoxArea">
                <table>
                    <tr>
                        <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                            <i class="fa fa-search"></i><br/>검색
                        </th>
                    </tr>
                    <tr>
                        <td><span id="search_year"></span></td>
                        <td><span id="search_month"></span></td>
                        <td><span id="search_memInfo"></span></td>
                            <input type="hidden" name="startDate" id="startDate">
                            <input type="hidden" name="endDate" id="endDate" />
                        <td>
                            <label><input type="text" class="form-control" id="txt_search" placeholder="검색할 정보를 입력하세요"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- 청취 내역 리스트 -->
            <div class="widget widget-table">
                <div class="widget-content">
                    <div class="widget-content">
                        <div class="dataTables_paginate paging_full_numbers" id="copyrightDetailList_paginate_top"></div>
                        <table class="table table-sorting table-hover table-bordered mt15">
                            <thead>
                            <colgroup>
                                <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                            </colgroup>
                            <tr>
                                <th>No</th>
                                <th>청취 일시</th>
                                <th>청취 회원</th>
                                <th>청취 회원 IP</th>
                                <th>누적 청취 수</th>
                            </tr>
                            </thead>
                            <tbody id="copyrightDetailList"></tbody>
                        </table>
                        <div class="dataTables_paginate paging_full_numbers" id="copyrightDetailList_paginate"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/money/exchangeCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/clip/clipCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    var copyrightDetailPagingInfo = new PAGING_INFO(0,1,50);

    var clipNo = "<%=in_clipNo%>";
    var year = "<%=in_year%>";
    var month = "<%=in_month%>";

    $(document).ready(function() {
       $('#search_year').html(util.getCommonCodeSelect(year, search_exchange_years, 'N', 'searchYear'));
       $('#search_month').html(util.getCommonCodeSelect(month, search_exchange_months, 'N', 'searchMonth'));
       $('#search_memInfo').html(util.getCommonCodeSelect('0', clip_copyrightDetail_searchType, 'N', 'searchType'));

        getCopyrightDetail();
    });

    $('#bt_search').on('click', function() {
        getCopyrightDetail();
    });

    $('input[id="txt_search"]').on('keydown', function(e) {
        if(e.keyCode == 13) {
            getCopyrightDetail();
        }
    });

    function getCopyrightDetail() {
        var data = {
            cast_no : clipNo
            , year : $('#searchYear').val()
            , month : $('#searchMonth').val()
            , searchType : $('#searchType').val()
            , searchText : $('#txt_search').val()
            , inner : 1 // todo - 기획서에 inner조건이 없으나, 프로시저에는 검색 조건에 있어서 추가해두었습니다.
            , pageNo : copyrightDetailPagingInfo.pageNo
            , pageCnt : copyrightDetailPagingInfo.pageCnt
        }
        util.getAjaxData("getCopyrightDetail", "/rest/clip/history/copyright/detail", data, function fn_getCopyrightDetail_success(dst_id, response) {
            var template = $('#tmp_copyrightDetailList').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data.list
            var html = templateScript(context);

            $('#copyrightDetailList').html(html);

            copyrightDetailPagingInfo.totalCnt = response.data.summary.totalCnt;
            util.renderPagingNavigation('copyrightDetailList_paginate_top', copyrightDetailPagingInfo);
            util.renderPagingNavigation('copyrightDetailList_paginate', copyrightDetailPagingInfo);

            if(response.data.length == 0) {
                $('#copyrightDetailList_paginate_top').hide();
                $('#copyrightDetailList_paginate').hide();
            } else {
                $('#copyrightDetailList_paginate_top').show();
                $('#copyrightDetailList_paginate').show();
            }

            getClipInfo(response.data.summary);
        });
    }

    function getClipInfo(summary) {
        var template = $('#tmp_clipDetail').html();
        var templateScript = Handlebars.compile(template);
        var context = summary
        var html = templateScript(context);

        $('#clipDetail').html(html);
    }

    function handlebarsPaging(targetId, pagingInfo){
        copyrightDetailPagingInfo = pagingInfo;
        getCopyrightDetail();
    }

</script>

<script id="tmp_clipDetail" type="text/x-handlebars-template">
    <table class="table table-bordered table-dalbit borderBlack">
        <colgroup>
            <col width="6%"/>
            <col width="12%"/>
            <col width="6%"/>
            <col width="12%"/>
        <tbody>
        <tr>
            <th>클립 제목</th>
            <td>{{title}}</td>

            <th>회원 닉네임</th>
            <td>{{nickName}}</td>
        </tr>
        <tr>
            <th>클립 번호</th>
            <td><a href="javascript://" class="_openClipInfoPop" data-clipno="{{cast_no}}">{{cast_no}}</a></td>

            <th>회원번호</th>
            <td>{{{memNoLink mem_no mem_no}}}</td>
        </tr>
        </tbody>
    </table>
</script>

<script id="tmp_copyrightDetailList" type="text/x-handlebars-template">
    {{#each this as |data|}}
        <tr>
            <td>{{data.rowNum}}</td>
            <td>{{convertToDate data.playDate "YYYY-MM-DD HH:mm:ss"}}</td>
            <td>
                {{{memNoLink mem_no mem_no}}}
                <br /> {{nickName}}
            </td>
            <td>
                {{ip}}
            </td>
            <td>{{repeatCnt}}</td>
        </tr>
    {{else}}
        <tr>
            <td colspan="5">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>