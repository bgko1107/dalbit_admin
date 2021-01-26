
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">

    <!-- serachBox -->
    <form id="searchForm">
        <div class="col-lg-12 no-padding form-inline">
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
        <div class="col-lg-12 form-inline no-padding">
            <div class="widget-content">
                <div class="dataTables_paginate paging_full_numbers" id="imageList_info_paginate_top"></div>
                <div class="list-group">
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
        $('input[id="searchText"]').on('keydown', function(e) {    // textBox 처리
            if(e.keyCode == 13) {
                $("#bt_search").click();
            };
        });

        $("#bt_search").on('click', function() {  // 버튼의 클릭이벤트
            reportImageList();
        });

        $("#reportImageArea").html(util.getCommonCodeSelect(-1, reportImageSlctType));
        reportImageList();
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

    function delConfirm(data){

        var reportidx = data.reportidx;
        var report_mem_no = data.reportmemno;
        var report_nick = data.reportnick;
        var report_userid = data.reportuserid;
        var report_sex = data.reportsex;
        var device_uuid = data.deviceuuid;
        var ip = data.ip;

        $.confirm({
            title: '이미지를 삭제 하시겠습니까?',
            content: '',
            buttons: {
                취소: function () {
                },
                삭제: function () {
                    if(confirm("확인 완료처리 됩니다. 삭제 처리 하시겠습니까?")){
                        var data = {
                            reportIdx : reportidx
                            , deleteYn : 1
                            , opCode : 0
                            , sendNoti : 0
                        };

                        console.log(data);
                        util.getAjaxData("image", "/rest/customer/declaration/image/operate", data, fn_reportImage_operate_success, fn_fail);
                    }
                },
                somethingElse: {
                    text: '삭제 후 신고',
                    btnClass: 'btn-red',
                    keys: ['enter'],
                    action: function(){
                        var report = "/customer/declaration/popup/reportPopup?"
                            + "memNo=" + encodeURIComponent(report_mem_no)
                            + "&memId=" + encodeURIComponent(report_userid)
                            + "&memNick=" + encodeURIComponent(report_nick)
                            + "&memSex=" + encodeURIComponent(report_sex)
                            + "&deviceUuid=" + encodeURIComponent(device_uuid)
                            + "&ip=" + encodeURIComponent(ip)
                            + "&reportidx=" + reportidx
                            + "&fnCallBack=" + encodeURIComponent("reportImageList");
                        console.log(report);
                        util.windowOpen(report,"750","910","이미지신고");

                        // var data = {
                        //     reportIdx : reportidx
                        // };
                        // util.getAjaxData("image", "/rest/customer/declaration/image/operate", data, fn_reportImage_operate_success, fn_fail);
                    }
                }
            }
        });
    }

    function fn_reportImage_operate_success(dst_id, response, dst_params){
        $("#bt_search").click();
    }
</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_imageSelectFrm" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <%--{{#dalbit_if data.inner '==' 1}}--%>
        <%--<div class="item col-md-2 col-sm-6 mb15 bg-testMember" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">--%>
        <%--{{else}}--%>
        <div class="item col-md-2 col-sm-6 mb15" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
        <%--{{/dalbit_if}}--%>
            <div>
                <label>NO.{{indexDesc ../pagingVo.totalCnt data.rowNum}}</label>
                {{#dalbit_if data.data2 '==' 'y'}}
                    <label class="pull-right" style="background-color: #fff7e5">상태 : <span style="color:red;">{{data.viewState}}</span></label>
                {{else}}
                    <label class="pull-right" style="background-color: #fff7e5">상태 : {{data.viewState}}</label>
                {{/dalbit_if}}
            </div>
            <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;height: 470px;">
                <div class="thumbnail" src="{{renderImage data.imageUrl}}?360x360">
                    <img class="list-group-image thumbnailImg fullSize_background" style="width:360px; height:225px;" src="{{renderImage data.imageUrl}}" alt="" data-toggle="modal" data-target="#imgModal" />
                </div>
                <div>
                    <ul class="list-unstyled">
                        <strong>분류:</strong>
                        {{#dalbit_if data.imageType '==' 1}}
                            우체통
                        {{/dalbit_if}}
                        {{#dalbit_if data.data2 '!=' 'y'}}
                            <a href="javascript://" class="btn btn-danger btn-xs pull-right" onclick="delConfirm($(this).data())"
                               data-reportidx="{{data.reportIdx}}"
                               data-reportmemno="{{data.report_mem_no}}"
                               data-reportuserid="{{data.report_userid}}"
                               data-reportnick="{{data.report_nick}}"
                               data-reportsex="{{data.report_sex}}"
                               data-ip="{{data.ip}}"
                               data-deviceuuid="{{data.device_uuid}}"
                            >삭제</a>
                        {{/dalbit_if}}
                        <br/>
                        <strong>업로드 회원정보</strong><br/>
                        {{data.upload_nick}} {{{sexIcon data.upload_sex}}} ({{upload_age}}세)<br/>
                        <a href="javascript://" class="_openMemberPop" data-memno="{{data.upload_mem_no}}" > {{data.upload_mem_no}} </a><br/>
                        <br/>
                        업로드 일시 : {{substr uploadDate 0 19}}<br/>
                        <br/>
                        <strong>신고 회원정보</strong><br/>
                        {{data.report_nick}} {{{sexIcon data.report_sex}}} ({{report_age}}세)<br/>
                        <a href="javascript://" class="_openMemberPop" data-memno="{{data.report_mem_no}}" > {{data.report_mem_no}} </a><br/>
                    </ul>
                </div>
            </div>
        </div>
    {{else}}
    <div class="col-md-12" style="text-align:center">
        <label>{{isEmptyData}}</label>
    </div>
    {{/each}}
</script>
