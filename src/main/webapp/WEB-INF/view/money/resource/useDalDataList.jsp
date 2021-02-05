<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10 mb10">
            <div class="col-md-2 no-padding">
                <span id="useDalList_searchType" onchange="useDalList_searchType_click();"></span>
            </div>
            <div class="col-md-2 no-padding pull-right">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="15%"/><col width="65%"/>
                    </colgroup>
                    <tr>
                        <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="col-md-12 no-padding">
            <div class="dataTables_paginate paging_full_numbers" id="useDal_paginate_top"></div>
            <table id="useDalTable" class="table table-sorting table-hover table-bordered mt10">
                <colgroup>
                    <col width="3%"/><col width="6.4%"/><col width="6.4%"/><col width="6.4%"/><col width="6.4%"/>
                    <col width="6.4%"/><col width="6.4%"/><col width="6.4%"/><col width="6.4%"/><col width="6.4%"/>
                    <col width="6.4%"/><col width="6.4%"/><col width="6.4%"/><col width="6.4%"/><col width="6.4%"/>
                    <col width="6.4%"/><col width="6.4%"/><col width="6.4%"/><col width="6.4%"/><col width="6.4%"/>
                    <col width="6.4%"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="_bgColor _fontColor" data-bgColor="#416dbb" data-fontColor="white">No</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">사용자<br/>플랫폼</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">사용자<br/>구분</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">사용자<br/>회원No</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">사용자<br/>성별(나이)</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">대상자<br/>플랫폼</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">대상자<br/>구분</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">대상자<br/>회원No</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">대상자<br/>성별(나이)</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">아이템<br/>이미지</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">아이템 명</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">비밀선물 여부</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">사용 달 수</th>
                    <%--<th class="_bgColor" data-bgColor="##bfbfbf">달 금액</th>--%>
                    <th class="_bgColor" data-bgColor="##bfbfbf">사용일자</th>
                </tr>
                </thead>
                <tbody id="tb_useDalList">
                </tbody>
            </table>
            <div class="dataTables_paginate paging_full_numbers" id="useDal_paginate"></div>
        </div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/money/resourceCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var useDalPagingInfo = new PAGING_INFO(0,1,100);

    $(document).ready(function() {
        $("#useDalList_searchType").html(util.getCommonCodeSelect(-1, useDalList_searchType));
        // useDalList();
    });

    function useDalDataListTabClick(){
        $("#searchMemberArea").show();
        tabType = 5;
        slctType = 0;
        dateType(slctType);
        $("#resourceState").hide();
        $("._prevSearch").show();
        $("._todaySearch").show();
        $("._nextSearch").show();
        $("#div_input").show();
        $("#searchText").show();
        $("#searchCheck").show();
        $("#liveResourceData").hide();

    }

    function useDalList(pagingInfo) {
        if(!common.isEmpty(pagingInfo)){
            useDalPagingInfo.pageNo = pagingInfo;
        }else{
            useDalPagingInfo.pageNo = 1;
        }

        var data = {
            'pageNo': useDalPagingInfo.pageNo
            , 'pageCnt' : 100
            , 'searchText' : $("#searchText").val()
            , 'searchType' : 0
            , 'slctType' : $('input[name="search_testId"]').is(":checked") ? "1" : "0"
            , 'orderType' : $("select[name='searchCheck']").val()
            , 'startDate' : $("#startDate").val()
            , 'slctSecret' : 0
            , 'newSearchType' : $("#searchMember").val()
        };

        util.getAjaxData("useDalList", "/rest/money/resource/useDalList", data, fn_success_useDalList);

    }

    function fn_success_useDalList(dst_id, response, param) {

        response.data.detailList.totalCnt = response.data.totalInfo.totalCnt;

        var template = $('#tmp_useDalTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.detailList;
        var html = templateScript(context);

        $('#tb_useDalList').html(html);

        useDalPagingInfo.totalCnt = response.data.totalInfo.totalCnt;
        util.renderPagingNavigation('useDal_paginate_top', useDalPagingInfo);
        util.renderPagingNavigation('useDal_paginate', useDalPagingInfo);

        if(response.data.length == 0) {
            $("useDalList").find("#useDal_paginate_top").hide();
            $("useDalList").find('#useDal_paginate').hide();
        } else {
            $("useDalList").find("#useDal_paginate_top").show();
            $("useDalList").find('#useDal_paginate').show();
        }
    }

    function useDalList_searchType_click(){
        useDalPagingInfo.pageNo = 1;
        useDalList();
    }

</script>

<script id="tmp_useDalTable" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr {{#dalbit_if inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
        <td>{{indexDesc ../totalCnt rowNum}}</td>
        <td>{{{getCommonCodeLabel osType 'os_type'}}}</td>
        <td>{{{renderSlct memSlct 30}}}</td>
        <td>
            {{{memNoLink mem_no mem_no}}}<br/>
            {{mem_nick}}
        </td>
        <td>{{{sexIcon mem_sex}}}({{memAge}})</td>
        <td>{{{renderSlct gifted_memSlct 30}}}</td>
        <td>{{{getCommonCodeLabel gifted_osType 'os_type'}}}</td>
        <td>
            {{{memNoLink gifted_mem_no gifted_mem_no}}}<br/>
            {{gifted_memNick}}
        </td>
        <td>{{{sexIcon gifted_mem_sex}}}({{gifted_memAge}})</td>
        <td><img class="_webpImage" src="{{item_thumbnail}}" width="50" height="50" data-webpImage="{{webp_image}}"/></td>
        <td>{{item_name}}</td>
        <td>{{#dalbit_if secret '==' 1}}비밀선물{{/dalbit_if}}</td>
        <%--<td>{{addComma item_cnt}}</td>--%>
        <td>{{addComma item_price}} 개</td>
        <td>{{lastUpdDateFormat}}</td>
    {{else}}
    <tr>
        <td colspan="15">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>