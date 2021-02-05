<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10 mb10">
            <div class="col-md-2 no-padding">
                <span id="buyDalList_searchType" onchange="buyDalList_searchType_click();"></span>
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
            <div class="dataTables_paginate paging_full_numbers" id="buyDal_paginate_top"></div>
            <table id="buyDalTable" class="table table-sorting table-hover table-bordered mt10">
                <colgroup>
                    <col width="3%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                    <col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/><col width="5%"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="_bgColor _fontColor" data-bgColor="#416dbb" data-fontColor="white">No</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">회원No</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">성별(나이)</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">가입구분</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">플랫폼</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">결제 달 수</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">결제 금액</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">결제 일자</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">(누적)달 결제 횟수</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">(누적)달 결제 금액</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">이전 결제일자</th>
                    <th class="_bgColor" data-bgColor="##bfbfbf">재 결제기간</th>
                </tr>
                </thead>
                <tbody id="tb_buyDalList">
                </tbody>
            </table>
            <div class="dataTables_paginate paging_full_numbers" id="buyDal_paginate"></div>
        </div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/money/resourceCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var buyDalPagingInfo = new PAGING_INFO(0,1,100);

    $(document).ready(function() {
        $("#buyDalList_searchType").html(util.getCommonCodeSelect(-1, buyDalList_searchType));
        // buyDalList();
    });

    function buyDalDataListTabClick(){
        $("#searchMemberArea").show();
        tabType = 4;
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

        // buyDalList();
    }

    function buyDalList(pagingInfo) {
        if(!common.isEmpty(pagingInfo)){
            buyDalPagingInfo.pageNo = pagingInfo;
        }else{
            buyDalPagingInfo.pageNo = 1;
        }

        var data = {
            'pageNo': buyDalPagingInfo.pageNo
            , 'pageCnt' : 100
            , 'searchText' : $("#searchText").val()
            , 'searchType' : 0
            , 'slctType' : $('input[name="searchCheck"]').is(":checked") ? "1" : "0"
            , 'orderType' : $("select[name='buyDalList']").val()
            , 'startDate' : $("#startDate").val()
            , 'newSearchType' : $("#searchMember").val()
        };

        util.getAjaxData("buyDalList", "/rest/money/resource/buyDalList", data, fn_success_buyDalList);

    }

    function fn_success_buyDalList(dst_id, response, param) {

        response.data.detailList.totalCnt = response.data.totalInfo.totalCnt;

        var template = $('#tmp_buyDalTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.detailList;
        var html = templateScript(context);

        $('#tb_buyDalList').html(html);

        buyDalPagingInfo.totalCnt = response.data.totalInfo.totalCnt;
        util.renderPagingNavigation('buyDal_paginate_top', buyDalPagingInfo);
        util.renderPagingNavigation('buyDal_paginate', buyDalPagingInfo);

        if(response.data.length == 0) {
            $("buyDalList").find("#buyDal_paginate_top").hide();
            $("buyDalList").find('#buyDal_paginate').hide();
        } else {
            $("buyDalList").find("#buyDal_paginate_top").show();
            $("buyDalList").find('#buyDal_paginate').show();
        }
    }

    function buyDalList_searchType_click(){
        buyDalPagingInfo.pageNo = 1;
        buyDalList();
    }

</script>

<script id="tmp_buyDalTable" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr {{#dalbit_if inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
    <td>{{indexDesc ../totalCnt rowNum}}</td>
    <td>
        {{{memNoLink mem_no mem_no}}}<br/>
        {{memNick}}
    </td>
    <td>{{{sexIcon memSex}}}({{memAge}})</td>
    <td>{{{renderSlct memSlct 30}}}</td>
    <td>{{{getCommonCodeLabel osType 'os_type'}}}</td>
    <td>{{addComma dalCnt}}</td>
    <td>{{addComma payAmt}}</td>
    <td>{{payDate}}</td>
    <td>{{addComma total_payCnt}}</td>
    <td>{{addComma total_payAmt}}</td>
    <td>{{prev_payDate}}</td>
    <td>{{addComma re_payDate}} 일</td>
    {{else}}
    <tr>
        <td colspan="12">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>