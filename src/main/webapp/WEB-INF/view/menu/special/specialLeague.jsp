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
                점수 산정방식 <br/>
                -방송 중 받은 별 1,000개를 달성할 때마다 1,000점 획득 <br/>
                -방송 중 누적 청취자 50명을 달성 할 때마다 500점 획득 <br/>
                -방송 중 좋아요 100개를 달성할 때마다 100점 획득 (1분 좋아요+유료 부스터) <br/>
                -점수 동일 시 레벨(경험치) 순 노출
            </div>

        </div>

    <div class="widget-content" style="border-top-width:0px;">
        <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>--%>

        <table id="specialList" class="table table-sorting table-hover table-bordered mt15">
            <thead>
                <tr>
                    <th>순위</th>
                    <th>프로필<br/>이미지</th>
                    <th>회원번호</th>
                    <th>닉네임</th>
                    <th>성별</th>
                    <th><span style="color: blue">랭킹<br/>점수</span></th>
                    <th>받은 별</th>
                    <th><span style="color: blue">받은 별<br/>점수<br/>(1,000개 x 1)</span></th>
                    <th>누적<br/>청취자</th>
                    <th><span style="color: blue">누적 청취자<br/>점수<br/>(50명 x 10)</span></th>
                    <th>받은<br/>좋아요 합계</th>
                    <th>1분<br/>좋아요</th>
                    <th>부스터<br/>좋아요</th>
                    <th><span style="color: blue">받은<br/>좋아요<br/>점수<br/>(100개 x 1)</span></th>
                </tr>
            </thead>
            <tbody id="specialLeague_tableBody">
            </tbody>
        </table>

        <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>--%>

    </div>
</div>
<div id="#imageFullSize"></div>
<!-- // DATA TABLE -->

<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    var specialLeaguePagingInfo = new PAGING_INFO(0, 1, 99999);

    function getParam() {
        return data = {
            select_year : common.substr($("#startDate").val(),0,4)
            , select_month :  common.substr($("#startDate").val(),5,2)
            , roundNo : 9
            , searchText: $('#searchText').val()
            , pageStart: specialLeaguePagingInfo.pageNo
            , pageCnt: specialLeaguePagingInfo.pageCnt
            , newSearchType : $("#searchMember").val()
        };
    }

    function initSpecialLeague() {
        util.getAjaxData("special", "/rest/menu/special/specialLeague", getParam(), fn_specialLeagueList_success);
    }


    function fn_specialLeagueList_success(dst_id, response) {
        var template = $('#tmp_specialLeague').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $('#specialLeague_tableBody').html(html);

        // var pagingInfo = response.pagingVo;
        // specialLeaguePagingInfo.totalCnt = pagingInfo.totalCnt;
        // var totalCnt;
        // totalCnt = specialLeaguePagingInfo.totalCnt;
        // console.log(specialLeaguePagingInfo);
        // util.renderPagingNavigation('list_info_paginate_top', specialLeaguePagingInfo);
        // util.renderPagingNavigation('list_info_paginate', specialLeaguePagingInfo);

        // if(response.data.length == 0) {
        //     $("#list_info_paginate").hide();
        //     $("#list_info_paginate_top").hide();
        // } else {
        //     $("#list_info_paginate").show();
        //     $("#list_info_paginate_top").show();
        // }
    }

    function handlebarsPaging(targetId, pagingInfo){
        specialLeaguePagingInfo = pagingInfo;
        init();
    }

    function modal_close(){
        $("#fullSize_background").modal('hide');
    }

</script>

<script id="tmp_specialLeague" type="text/x-handlebars-template">
    {{#each this as |data|}}
    <tr {{#dalbit_if inner '==' 1}} class="_noTr bg-testMember" {{else}} class="_noTr" {{/dalbit_if}} id="row_{{order}}">
        <td>{{addComma rank}}</td>
        <td style="width: 65px;height:65px;">
            <img class="thumbnail fullSize_background" src="{{renderProfileImage data.profileImage data.mem_sex}}" style="width: 65px;height:65px; margin-bottom: 0px;"/>
        </td>
        <td>
            <a href="javascript://" class="_openMemberPop" data-memno="{{mem_no}}">{{mem_no}}</a>
            <a href="javascript://" style="display:none;" class="_dalDetail" data-reqidx="{{req_idx}}"></a>
        </td>
        <td>{{mem_nick}}</td>
        <td>{{{sexIcon mem_sex mem_birth_year}}}</td>
        <td>{{addComma totalPoint}}</td>
        <td>{{addComma byeolCount}}</td>
        <td>{{addComma giftPoint}}</td>
        <td>{{addComma listenerCount}}</td>
        <td>{{addComma listenerPoint}}</td>
        <td>{{addComma totalGoodCnt}}</td>
        <td>{{addComma goodCount}}</td>
        <td>{{addComma boosterCount}}</td>
        <td>{{addComma goodPoint}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="15">{{isEmptyData}}</td>
    </tr>
    {{/each}}
</script>