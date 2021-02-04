
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
                <div class="dataTables_paginate paging_full_numbers" id="broadcastList_info_paginate_top"></div>
                <div class="row list-group king-gallery">
                <%--<div class="row list-group">--%>
                    <form id="broadcastListForm"></form>
                </div>
                <div class="dataTables_paginate paging_full_numbers" id="broadcastList_info_paginate"></div>
            </div>
        </div>
        <!-- DATA TABLE END -->
    </div>
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/broadcast/broadCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        fnc_broadcastList.init();
    });

var fnc_broadcastList = {};

//=------------------------------ Init / Event--------------------------------------------
    fnc_broadcastList.targetId= "broadcastList";
    fnc_broadcastList.formId= "broadcastListForm";
    fnc_broadcastList.pagingInfo= new PAGING_INFO(0, 1, 54);

    fnc_broadcastList.init= function() {
        fnc_broadcastList.target = $("#"+fnc_broadcastList.targetId);
        fnc_broadcastList.targetDataTableId = "list_info_"+fnc_broadcastList.targetId;
        fnc_broadcastList.target.find("#list_info").attr("id", fnc_broadcastList.targetDataTableId);
        fnc_broadcastList.targetDataTable = fnc_broadcastList.target.find("#"+fnc_broadcastList.targetDataTableId);
        fnc_broadcastList.divDataTable = fnc_broadcastList.targetDataTable.parent("div");


        fnc_broadcastList.initDataTable();
    };


    fnc_broadcastList.initDataTable= function() {
        console.log(fnc_broadcastList.pagingInfo)

        $("#pageStart").val(fnc_broadcastList.pagingInfo.pageNo);
        $("#pageCnt").val(fnc_broadcastList.pagingInfo.pageCnt);

        util.getAjaxData(fnc_broadcastList.targetId, "/rest/customer/image/broadcast/list", $("#searchForm").serialize(), fnc_broadcastList.fn_select_success, fnc_broadcastList.fn_fail);
    };


    // DataTable Button
    fnc_broadcastList.initDataTableButton= function() {
    };



    fnc_broadcastList.initEvent= function(){
    };


//=------------------------------ Option --------------------------------------------

    // 등록
    fnc_broadcastList.insertEvent= function() {
        //등록을 위한 데이터 초기화
        initSelectDataInfo();

        $("#tab_broadcastDetail").click();
    };

    // 삭제
    fnc_broadcastList.deleteEvent= function() {
        var checkDatas = fnc_broadcastList.dtList_info.getCheckedData();

        if(checkDatas.length <= 0){
            alert("삭제할 정보를 선택해주세요.");
            return false;
        }

        dalbitLog(checkDatas);
        if(confirm("선택하신 " + checkDatas.length + "건의 정보를 삭제 하시겠습니까?")){

            var itemCodes = "";
            for(var idx=0; idx < checkDatas.length; idx++){
                var dataInfo = checkDatas[idx];
                if(common.isEmpty(dataInfo.item_code)){
                    dalbitLog("[delete] Item code does not exist. : ");
                    dalbitLog(dataInfo);
                    continue;
                }

                itemCodes += "," + dataInfo.item_code;
            }
            itemCodes = itemCodes.substring(1);

            var data = new Object();
            data.item_code = itemCodes;

            util.getAjaxData(fnc_broadcastList.targetId, "/rest/content/item/broadcast/delete",data, fnc_broadcastList.fn_delete_success, fnc_broadcastList.fn_fail);
        };
    };

    // 수정
    fnc_broadcastList.updateData= function(dom) {
        console.log(dom);
        var data = $(dom).data("info");
        console.log(data);

        if(data.state == "4"){
            alert("종료된 방송방은 수정이 불가능 합니다.");
            return;
        }

        if(data.image_background.path.indexOf("/bg_3/roombg") > -1){
            alert("이미 기본 배경이미지 입니다.");
            return;
        }

        if(confirm("대상의 이미지를 초기화 하시겠습니까?")){
            report = "/customer/image/popup/imagePopup?memNo='" + data.mem_no + "'&room_no='" + data.room_no + "'&memId='" + data.mem_userid + "'&memNick='" + common.replaceHtml(data.mem_nick) + "'&memSex='" + data.mem_sex + "'&targetId='" + fnc_broadcastList.targetId + "'";
            console.log(report);
            util.windowOpen(report,"600","450","방송방 배경 초기화");
        }
    };

    fnc_broadcastList.fn_select_success= function(dst_id, response, dst_params){
        // form 띄우기
        var template = $('#tmp_broadcastSelectFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);
        fnc_broadcastList.target.find("#"+ fnc_broadcastList.formId).html(html);

        var pagingInfo = response.pagingVo;
        fnc_broadcastList.pagingInfo.totalCnt = pagingInfo.totalCnt;
        console.log(fnc_broadcastList.pagingInfo);
        util.renderPagingNavigation("broadcastList_info_paginate_top", fnc_broadcastList.pagingInfo);
        util.renderPagingNavigation("broadcastList_info_paginate", fnc_broadcastList.pagingInfo);

        fnc_broadcastList.initEvent();
    };


    // 삭제 성공 시
    fnc_broadcastList.fn_update_success= function(dst_id, data, dst_params){
        alert(data.message);

        // reload
        fnc_broadcastList.selectMainList();
    };


    // Ajax 실패
    fnc_broadcastList.fn_fail= function(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };


    // 검색
    fnc_broadcastList.selectMainList= function(){
        fnc_broadcastList.initDataTable();
    };

</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_broadcastSelectFrm" type="text/x-handlebars-template">
    {{#each data as |user|}}
        {{#dalbit_if inner '==' 1}}
        <div class="item col-md-2 col-sm-6 bg-testMember" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
        {{else}}
        <div class="item col-md-2 col-sm-6" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
        {{/dalbit_if}}
            <div>
                <label>NO.{{indexDesc ../pagingVo.totalCnt user.rowNum}}</label>
            </div>
            <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;height: 430px;">
                    {{{getCommonCodeLabel user.state 'broadcast_state_icon'}}}
                <div class="thumbnail">
                    <img class="list-group-image thumbnailImg fullSize_background" style="width:360px; height:225px" src="{{user.image_background.url}}" alt="" data-toggle="modal" data-target="#imgModal" />
                    <div class="caption">
                        <div class="action-buttons">
                            <a href="javascript://" class="btn btn-danger btn-xs" onclick="fnc_broadcastList.updateData(this)" data-info="{{json user}}"><i class="fa fa-undo"></i> 초기화</a>
                        </div>
                    </div>
                </div>
                <div>
                    <h3 class="inner list-group-item-heading broadcast_title">
                        <a href="javascript://" class="_openBroadcastPop" data-roomno="{{user.room_no}}"><h5>{{user.title}}</h5></a>
                    </h3>
                    <ul class="list-unstyled">
                        <li><strong>ID:</strong>
                            <a href="javascript://" class="_openMemberPop" data-memno="{{user.mem_no}}">
                                {{user.mem_no}}
                            </a>
                        </li>
                        <li><strong>Nick:</strong> {{replaceHtml user.mem_nick}}</li>
                        <li class="sexType"><strong>Sex:</strong> {{{sexIcon user.mem_sex user.mem_birth_year}}}</li>
                        <li><strong>No:</strong> {{user.mem_no}}</li>
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