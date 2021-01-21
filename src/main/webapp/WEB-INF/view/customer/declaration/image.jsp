
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">

    <!-- serachBox -->
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
                            <span id="reportImageArea"></span>
                            <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
    <!-- //serachBox -->

    <div class="widget-content">
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
            <li><a href="/customer/declaration/list"> 회원신고 </a></li>
            <li class="active"><a href="#image" role="tab" data-toggle="tab"> 이미지신고 </a></li>
        </ul>
    </div>

    <div id="page-wrapper">
        <!-- DATA TABLE -->
        <div class="row col-lg-12 form-inline mb15">
            <div class="widget-content">
                <div class="dataTables_paginate paging_full_numbers" id="imageList_info_paginate_top"></div>
                <div class="row list-group">
                <%--<div class="row list-group">--%>
                    <form id="imageForm"></form>
                </div>
                <div class="dataTables_paginate paging_full_numbers" id="imageList_info_paginate"></div>
            </div>
        </div>
        <!-- DATA TABLE END -->
    </div>
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/customer/customerCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {

        $("#reportImageArea").html(util.getCommonCodeSelect(-1, reportImageSlctType));

    });


//=------------------------------ Init / Event--------------------------------------------
    var imagePagingInfo= new PAGING_INFO(0, 1, 54);

    function reportImageList() {
        var data = {
            'pageNo' : imagePagingInfo.pageNo
            , 'pageCnt' : imagePagingInfo.pageCnt
            , 'searchText' : common.isEmpty($('#txt_search').val()) ? '' : $('#txt_search').val()
            , 'slctType' : $("#slctType").val()
        };

        console.log(data);
        util.getAjaxData("image", "/rest/customer/declaration/image/list", data, fn_reportImage_success, fn_fail);
    };

    function fn_reportImage_success(dst_id, response, dst_params){
        // form 띄우기
        var template = $('#tmp_imageSelectFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        $("#imageForm").html(html);

        imagePagingInfo.totalCnt = response.pagingVo.totalCnt;

        console.log(imagePagingInfo);
        util.renderPagingNavigation("imageList_info_paginate_top", imagePagingInfo);
        util.renderPagingNavigation("imageList_info_paginate", imagePagingInfo);

    };


    function fn_fail(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };

    // 공지제목 누르면 회원/방송공지 탭이 나오도록
    function imagePopUp(data){
        var popupUrl = "/member/image/popup/imageMsg?chatNo="+ data.data('chatno');
        util.windowOpen(popupUrl,"950", "1000","우체통");
    }
</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_imageSelectFrm" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        {{^equal data.image_path ''}}
            {{#dalbit_if data.inner '==' 1}}
            <div class="item col-md-2 col-sm-6 mb15 bg-testMember" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
            {{else}}
            <div class="item col-md-2 col-sm-6 mb15" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
            {{/dalbit_if}}
                <div>
                    <label>NO.{{indexDesc ../../pagingVo.totalCnt data.rowNum}}</label>
                    {{#dalbit_if data.data2 '==' 'y'}}
                        <label class="pull-right" style="background-color: #fff7e5">상태 : <span style="color:red;">삭제</span></label>
                    {{else}}
                        <label class="pull-right" style="background-color: #fff7e5">상태 : 정상</label>
                    {{/dalbit_if}}
                </div>
                <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;height: 430px;">
                <div class="thumbnail" src="{{renderImage data.imageUrl}}?360x360">
                    <img class="list-group-image thumbnailImg fullSize_background" style="width:360px; height:225px;" src="{{renderImage data.imageUrl}}" alt="" data-toggle="modal" data-target="#imgModal" />
                </div>
                <div>
                    <h4 class="inner list-group-item-heading broadcast_title">
                        <a href="javascript://" onclick="imagePopUp($(this))" data-chatno="{{data.chat_no}}">{{data.chat_no}}</a>
                    </h4>
                    <ul class="list-unstyled">
                        <li><strong>작성일시:</strong> <br />{{substr data.last_upd_date 0 19}}</li>
                        <li><strong>Nick:</strong> {{replaceHtml data.mem_nick}}</li>
                        <li><strong>No:</strong>
                            <a href="javascript://" class="_openMemberPop" data-memno="{{data.mem_no}}" >
                            {{data.mem_no}}
                            </a>
                        </li>
                        <li class="sexType"><strong>Sex:</strong> {{{sexIcon data.mem_sex data.mem_birth_year}}}</li>
                    </ul>
                </div>
                </div>
            </div>
        {{/equal}}
        {{else}}
            <div class="col-md-12" style="text-align:center">
                <label>{{isEmptyData}}</label>
            </div>
    {{/each}}
</script>
