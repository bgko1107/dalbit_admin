<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10">
            <span id ="profileMsgListCnt"></span>
        </div>
        <div class="dataTables_paginate paging_full_numbers" id="profile_paginate_top"></div>
        <table id="noticeTable" class="table table-sorting table-hover table-bordered mt10">
            <colgroup>
                <col width="5%"/>
                <col width="10%"/>
                <col width="15%"/>
                <col width="55%"/>
                <col width="10%"/>
                <col width="5%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>프로필이미지</th>
                    <th>등록자</th>
                    <th>프로필 메시지 내용</th>
                    <th>최근접속일시</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody id="tb_profileList">
            </tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="profile_paginate"></div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var profilePagingInfo = new PAGING_INFO(0,1,40);

    $(document).ready(function() {
        // profileMsgList();
    });

    var memNo;
    function profileMsgList() {
        $('#title').html('회원/방송공지');

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }
        var data = {
            'pageStart': profilePagingInfo.pageNo
            , 'pageCnt' : profilePagingInfo.pageCnt
            , 'searchText' : txt_search
            , 'sDate' : $("#startDate").val()
            , 'eDate' : $("#endDate").val()
            , 'searchType' : 0
        };

        util.getAjaxData("profileMsgList", "/rest/content/boardAdm/profileMsgList", data, fn_success_profileMsgList);
    }

    function fn_success_profileMsgList(dst_id, response, param) {

        var template = $('#tmp_profileMsgTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#tb_profileList').html(html);

        profilePagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('profile_paginate_top', profilePagingInfo);
        util.renderPagingNavigation('profile_paginate', profilePagingInfo);

        util.getAjaxData("profileMsgSummary", "/rest/content/boardAdm/profileMsg/summary", param, fn_success_profileMsgSummary);
    }
    function fn_success_profileMsgSummary(dst_id, response) {
        $("#tab_profileMsgList").text("프로필 메시지" + "(" + response.data.totalCnt +")");
        $("#profileMsgListCnt").html(
            '<span style="color:black">[검색결과 : ' +  response.data.totalCnt + ' 건]</span>' +
            '<span style="color: blue;"> [남' + response.data.maleCnt + " 건]</span>" + "," +
            '<span style="color: red;"> [여' + response.data.femaleCnt + " 건]</span>" + "," +
            '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + " 건]</span>"
        );
    }

    $(document).on('click', '._profileMsgDelBtn', function() {
        if(confirm("프로필 메시지를 삭제하시겠습니까?")) {
            var data = {
                mem_no: $(this).data('memno')
            };

            console.log(data);
            util.getAjaxData("delete", "/rest/content/boardAdm/profileMsg/del", data, profileMsgDel_success);
        }else return;
    });

    function profileMsgDel_success(dst_id, response){
        alert(response.message);
        profileMsgList();
    }

</script>

<script id="tmp_profileMsgTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td><img class="thumbnail fullSize_background" alt="your image" src="{{renderProfileImage image_profile mem_sex}}" style='height:68px; width:68px; margin: auto;' /></td>
            <td>
                {{{memNoLink_sex mem_no mem_no mem_sex}}}<br/>
                {{{memNoLink_sex mem_nick mem_no mem_sex}}}
            </td>
            <td>{{{replaceEnter msg_profile}}}</td>
            <td>{{last_upd_date}}</td>
            <td><a href="javascript://" class="_profileMsgDelBtn" data-memno="{{mem_no}}">[삭제]</a></td>
        </tr>
    {{else}}
        <tr>
            <td colspan="9">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>
