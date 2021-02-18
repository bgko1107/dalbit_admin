
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
                        •  운영정책에 어긋난 이미지는 [이미지초기화]버튼을 통해 서비스 제공 이미지로 초기화가 되고, 해당회원의 마이페이지>알림을 통해 확인이 가능합니다.<br>
                        •  PC와 Mobile 사이즈는 PC 프로필: 500px X500px /Mobile 프로필 : 120X120px (각각 1:1 비율)입니다.

                    </div>
                </div>

                <div class="dataTables_paginate paging_full_numbers" id="clipList_info_paginate_top"></div>
                <div class="row list-group king-gallery">
                <%--<div class="row list-group">--%>
                    <form id="clipListForm"></form>
                </div>
                <div class="dataTables_paginate paging_full_numbers" id="clipList_info_paginate"></div>
            </div>
        </div>
        <!-- DATA TABLE END -->
    </div>
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        fnc_clipList.init();
    });

var fnc_clipList = {};

//=------------------------------ Init / Event--------------------------------------------
    fnc_clipList.targetId= "clipList";
    fnc_clipList.formId= "clipListForm";
    fnc_clipList.pagingInfo= new PAGING_INFO(0, 1, 54);

    fnc_clipList.init= function() {
        fnc_clipList.target = $("#"+fnc_clipList.targetId);
        fnc_clipList.targetDataTableId = "list_info_"+fnc_clipList.targetId;
        fnc_clipList.target.find("#list_info").attr("id", fnc_clipList.targetDataTableId);
        fnc_clipList.targetDataTable = fnc_clipList.target.find("#"+fnc_clipList.targetDataTableId);
        fnc_clipList.divDataTable = fnc_clipList.targetDataTable.parent("div");


        fnc_clipList.initDataTable();
    };


    fnc_clipList.initDataTable= function() {
        var data = {};
        data.searchText = $("input[name=searchText]").val();
        data.newSearchType = $("#searchMember").val();
        data.pageNo = fnc_clipList.pagingInfo.pageNo;
        data.pageCnt = fnc_clipList.pagingInfo.pageCnt;
        data.orderByType = 6;

        util.getAjaxData(fnc_clipList.targetId, "/rest/customer/image/clip/list", data, fnc_clipList.fn_select_success, fnc_clipList.fn_fail);
    };


    // DataTable Button
    fnc_clipList.initDataTableButton= function() {
    };



    fnc_clipList.initEvent= function(){
    };


//=------------------------------ Option --------------------------------------------

    // 등록
    fnc_clipList.insertEvent= function() {
        //등록을 위한 데이터 초기화
        initSelectDataInfo();

        $("#tab_clipDetail").click();
    };

    // 삭제
    // fnc_profileList.deleteEvent= function() {
    //     var checkDatas = fnc_profileList.dtList_info.getCheckedData();
    //
    //     if(checkDatas.length <= 0){
    //         alert("삭제할 정보를 선택해주세요.");
    //         return false;
    //     }
    //
    //     dalbitLog(checkDatas);
    //     if(confirm("선택하신 " + checkDatas.length + "건의 정보를 삭제 하시겠습니까?")){
    //
    //         var itemCodes = "";
    //         for(var idx=0; idx < checkDatas.length; idx++){
    //             var dataInfo = checkDatas[idx];
    //             if(common.isEmpty(dataInfo.item_code)){
    //                 dalbitLog("[delete] Item code does not exist. : ");
    //                 dalbitLog(dataInfo);
    //                 continue;
    //             }
    //
    //             itemCodes += "," + dataInfo.item_code;
    //         }
    //         itemCodes = itemCodes.substring(1);
    //
    //         var data = new Object();
    //         data.item_code = itemCodes;
    //
    //         util.getAjaxData(fnc_profileList.targetId, "/rest/content/item/profile/delete",data, fnc_profileList.fn_delete_success, fnc_profileList.fn_fail);
    //     };
    // };

    //수정
    fnc_clipList.updateData= function(dom) {
        var data = $(dom).data("info");

        if(data.imageBackground.indexOf("/clip_3/") > -1){
            alert("이미 기본 배경이미지 입니다.");
            return;
        }

        if(confirm("대상의 이미지를 초기화 하시겠습니까?")){
            report = "/customer/image/popup/imagePopup?memNo='" + data.memNo + "'&cast_no='" + data.castNo + "'&editSlct='1'&backgroundImage='/clip_3/clipbg_200910_0.jpg'&sendNoti='1'&targetId='" + fnc_clipList.targetId + "'";
            console.log(report);
            util.windowOpen(report,"600","450","클립 배경 초기화");
        }
    };

    fnc_clipList.fn_select_success= function(dst_id, response, dst_params){
        // form 띄우기
        var template = $('#tmp_clipSelectFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        fnc_clipList.target.find("#"+ fnc_clipList.formId).html(html);

        var pagingInfo = response.pagingVo;
        fnc_clipList.pagingInfo.totalCnt = pagingInfo.totalCnt;
        util.renderPagingNavigation("clipList_info_paginate_top", fnc_clipList.pagingInfo);
        util.renderPagingNavigation("clipList_info_paginate", fnc_clipList.pagingInfo);

        fnc_clipList.initEvent();

    };


    // // 삭제 성공 시
    // fnc_profileList.fn_update_success= function(dst_id, data, dst_params){
    //     alert(data.message);
    //
    //     // reload
    //     fnc_profileList.selectMainList();
    // };
    //
    //

    // Ajax 실패
        fnc_clipList.fn_fail= function(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };


    // 검색
    fnc_clipList.selectMainList= function(){
        fnc_clipList.initDataTable();
    };
</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_clipSelectFrm" type="text/x-handlebars-template">
    {{#each data as |clip|}}
        {{#dalbit_if inner '==' 1}}
        <div class="item col-md-2 col-sm-6 mb15 bg-testMember" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
        {{else}}
        <div class="item col-md-2 col-sm-6 mb15" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
        {{/dalbit_if}}
            <div>
                <label>NO.{{indexDesc ../pagingVo.totalCnt clip.rowNum}}</label>
                {{#dalbit_if clip.state '!=' 1}}
                <label class="pull-right" style="background-color: #fff7e5">클립상태 : <span style="color:red;">삭제</span></label>
                {{/dalbit_if}}
                {{#dalbit_if clip.state '==' 1}}
                    {{#dalbit_if clip.hide '==' 1}}
                <label class="pull-right" style="background-color: #fff7e5">클립상태 : <span style="color:blue;">숨김</span></label>
                    {{/dalbit_if}}
                    {{#dalbit_if clip.hide '==' 0}}
                        <label class="pull-right" style="background-color: #fff7e5">클립상태 : 정상</label>
                    {{/dalbit_if}}
                {{/dalbit_if}}
            </div>
            <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;height: 430px;">
            <div class="thumbnail" src="{{renderImage clip.imageBackground}}?360x360">
                <img class="list-group-image thumbnailImg fullSize_background" style="width:360px; height:225px;" src="{{renderImage clip.imageBackground}}" alt="" data-toggle="modal" data-target="#imgModal" />
                <div class="caption">
                    <div class="action-buttons">
                        <a href="javascript://" class="btn btn-danger btn-xs" onclick="fnc_clipList.updateData(this)" data-info="{{json clip}}"><i class="fa fa-undo"></i> 초기화</a>
                    </div>
                </div>
            </div>
            <div>
                <h3 class="inner list-group-item-heading broadcast_title">
                    <a href="javascript://" class="_openClipInfoPop" data-clipNo="{{clip.castNo}}">
                        <h5>{{clip.title}}</h5>
                    </a>
                </h3>
                <ul class="list-unstyled">
                    <li><strong>클립번호:</strong>
                        {{clip.castNo}}
                    </li>
                    <li><strong>Nick:</strong> {{replaceHtml clip.memNick}}</li>
                    <li><strong>No:</strong>
                        <a href="javascript://" class="_openMemberPop" data-memno="{{clip.memNo}}" >
                        {{clip.memNo}}
                        </a>
                    </li>
                    <li class="sexType"><strong>Sex:</strong> {{{sexIcon clip.memSex clip.memBirthYear}}}</li>
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
