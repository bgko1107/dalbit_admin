
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">
    <div id="page-wrapper">
        <!-- DATA TABLE -->
        <div class="row col-lg-12 form-inline mb15">
            <div class="widget-content">
                <div class="row col-md-12" style="padding:5px 15px 15px 15px;">
                    <div class="pull-left">
                        •  운영정책에 어긋난 이미지는 [삭제] 버튼으로 삭제할 수 있습니다. 이미지가 삭제되면 해당회원의 마이페이지 > 알림을 통해 확인이 가능합니다. <br/>
                        •  이미지를 삭제해도 방송공지가 삭제되지는 않습니다.

                    </div>
                </div>

                <div class="dataTables_paginate paging_full_numbers" id="noticeList_info_paginate_top"></div>
                <div class="row list-group king-gallery">
                <%--<div class="row list-group">--%>
                    <form id="noticeForm"></form>
                </div>
                <div class="dataTables_paginate paging_full_numbers" id="noticeList_info_paginate"></div>
            </div>
        </div>
        <!-- DATA TABLE END -->
    </div>
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        fnc_noticeList.init();
    });

var fnc_noticeList = {};

//=------------------------------ Init / Event--------------------------------------------
    fnc_noticeList.targetId= "noticeList";
    fnc_noticeList.formId= "noticeForm";
    fnc_noticeList.pagingInfo= new PAGING_INFO(0, 1, 54);

    fnc_noticeList.init= function() {
        fnc_noticeList.target = $("#"+fnc_noticeList.targetId);
        fnc_noticeList.targetDataTableId = "list_info_"+fnc_noticeList.targetId;
        fnc_noticeList.target.find("#list_info").attr("id", fnc_noticeList.targetDataTableId);
        fnc_noticeList.targetDataTable = fnc_noticeList.target.find("#"+fnc_noticeList.targetDataTableId);
        fnc_noticeList.divDataTable = fnc_noticeList.targetDataTable.parent("div");


        fnc_noticeList.initDataTable();
    };

    fnc_noticeList.initDataTable= function() {
        var data = {};
        data.searchText = $("input[name=searchText]").val();
        data.newSearchType = $("#searchMember").val();
        data.pageNo = fnc_noticeList.pagingInfo.pageNo;
        data.pageCnt = fnc_noticeList.pagingInfo.pageCnt;

        util.getAjaxData(fnc_noticeList.targetId, "/rest/customer/image/notice/list", data, fnc_noticeList.fn_select_success, fnc_noticeList.fn_fail);
    };


    // DataTable Button
    fnc_noticeList.initDataTableButton= function() {
    };



    fnc_noticeList.initEvent= function(){
    };


//=------------------------------ Option --------------------------------------------

    // 등록
    fnc_noticeList.insertEvent= function() {
        //등록을 위한 데이터 초기화
        initSelectDataInfo();

        $("#tab_noticeDetail").click();
    };

    // 삭제
    fnc_noticeList.deleteEvent= function(dom) {
        if(confirm("선택하신 회원 공지의 이미지를 삭제하시겠습니까?")) {
            var data = {
                idx : $(dom).data('idx')
            }
            util.getAjaxData("deleteNoticeImg", "/rest/customer/image/notice/imgDelete", data, fnc_noticeList.fn_delete_success, fnc_noticeList.fn_fail);
        }
    };

    fnc_noticeList.fn_select_success= function(dst_id, response, dst_params){
        // form 띄우기
        var template = $('#tmp_noticeSelectFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        fnc_noticeList.target.find("#"+ fnc_noticeList.formId).html(html);

        var pagingInfo = response.pagingVo;
        fnc_noticeList.pagingInfo.totalCnt = pagingInfo.totalCnt;
        util.renderPagingNavigation("noticeList_info_paginate_top", fnc_noticeList.pagingInfo);
        util.renderPagingNavigation("noticeList_info_paginate", fnc_noticeList.pagingInfo);

        fnc_noticeList.initEvent();

    };


    // 삭제 성공 시
    fnc_noticeList.fn_delete_success= function(dst_id, data, dst_params){
        alert(data.message);

        // reload
        fnc_noticeList.selectMainList();
    };



    // Ajax 실패
        fnc_noticeList.fn_fail= function(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };


    // 검색
    fnc_noticeList.selectMainList= function(){
        fnc_noticeList.initDataTable();
    };

    // 공지제목 누르면 회원/방송공지 탭이 나오도록
    function noticePop(memNo) {
        var moveTabId = '';
        if(!common.isEmpty(memNo)){
            moveTabId = '&moveTabId=' + encodeURIComponent('tab_notice');
        }

        var url = "/member/member/popup/memberPopup?memNo="+encodeURIComponent(memNo) + moveTabId;
        util.windowOpen(url, 1460, 825, 'memberInfo' + memNo);
    }
</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_noticeSelectFrm" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        {{^equal data.image_path ''}}
            {{#dalbit_if data.inner '==' 1}}
            <div class="item col-md-2 col-sm-6 mb15 bg-testMember" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
            {{else}}
            <div class="item col-md-2 col-sm-6 mb15" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
            {{/dalbit_if}}
                <div>
                    <label>NO.{{indexDesc ../../pagingVo.totalCnt data.rowNum}}</label>
                    {{#dalbit_if data.status '==' 1}}
                        <label class="pull-right" style="background-color: #fff7e5">공지상태 : <span style="color:red;">삭제</span></label>
                    {{/dalbit_if}}
                    {{#dalbit_if data.status '!=' 1}}
                        <label class="pull-right" style="background-color: #fff7e5">공지상태 : 정상</label>
                    {{/dalbit_if}}
                </div>
                <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;height: 430px;">
                <div class="thumbnail" src="{{renderImage data.image_path}}?360x360">
                    <img class="list-group-image thumbnailImg fullSize_background" style="width:360px; height:225px;" src="{{renderImage data.image_path}}" alt="" data-toggle="modal" data-target="#imgModal" />
                    <div class="caption">
                        <div class="action-buttons">
                            <a href="javascript://" class="btn btn-danger btn-xs" onclick="fnc_noticeList.deleteEvent(this)" data-idx="{{data.idx}}"><i class="fa fa-times-circle"></i> 삭제</a>
                        </div>
                    </div>
                </div>
                <div>
                    <h3 class="inner list-group-item-heading broadcast_title">
                        <a href="javascript://" data-memno="{{data.mem_no}}" onclick="noticePop({{data.mem_no}});">
                            <h5>{{data.title}}</h5>
                        </a>
                    </h3>
                    <ul class="list-unstyled">
                        <li><strong>작성일시:</strong> <br />{{data.lastUpdDateFormat}}</li>
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
