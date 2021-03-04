<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="main-header">
    <div id="page-wrapper">

        <div class="row col-lg-12 form-inline">
            <table id="banner_stat" class="table table-sorting table-hover table-bordered" style="border-left:#FFFFFF;">
                <colgroup>
                    <col width="50%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                    <col width="3%" />
                </colgroup>
                <thead>
                    <tr>
                        <th class="_bgColor _noBorder" data-bgcolor="#FFF"></th>
                        <th class="_bgColor" data-bgcolor="#d8d8d8">구분</th>
                        <th colspan="2" class="_bgColor" data-bgcolor="#d8d8d8">게시</th>
                        <th colspan="3" class="_bgColor" data-bgcolor="#d8d8d8">플랫폼 게시</th>
                        <th colspan="8" class="_bgColor" data-bgcolor="#d8d8d8">배너위치별 게시</th>
                    </tr>
                    <tr>
                        <th class="_bgColor _noBorder" data-bgcolor="#FFF"></th>
                        <th>형태</th>
                        <th class="_fontColor" data-fontcolor="red">ON</th>
                        <th>OFF</th>
                        <th>PC</th>
                        <th>AOS</th>
                        <th>IOS</th>
                        <th>Main<br />Top</th>
                        <th>Main<br />Center</th>
                        <th>클립<br />Center</th>
                        <th>GNB<br />(PC)</th>
                        <th>시작<br />팝업</th>
                        <th>종료<br />팝업</th>
                        <th>팝업<br />(이미지)</th>
                        <th>팝업<br />(텍스트)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="_bgColor _noBorder" data-bgcolor="#FFF"></td>
                        <td class="_bgColor" data-bgcolor="#c5d8f1">수치</td>
                        <td id="stat_on" class="_bgColor _fontColor" data-bgcolor="#c5d8f1" data-fontcolor="red">0</td>
                        <td id="stat_off" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_pc" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_aos" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_ios" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_mainTop" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_mainCenter" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_clipCenter" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_gnb" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_start" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_end" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_image" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                        <td id="stat_text" class="_bgColor" data-bgcolor="#c5d8f1">0</td>
                    </tr>
                    <tr>
                        <td class="_bgColor _noBorder" data-bgcolor="#FFF"></td>
                        <td class="_bgColor font-bold" data-bgcolor="#ffe699">총 합</td>
                        <td id="stat_sum_onOff" colspan="2" class="_bgColor _fontColor" data-bgcolor="#fff2cc" data-fontcolor="red">0</td>
                        <td id="stat_sum_platform" colspan="3" class="_bgColor _fontColor" data-bgcolor="#fff2cc" data-fontcolor="red">0</td>
                        <td id="stat_sum_position" colspan="8" class="_bgColor _fontColor" data-bgcolor="#fff2cc" data-fontcolor="red">0</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- DATA TABLE -->
        <div class="row col-lg-12 form-inline mb10">
            <div class="widget widget-table">
                <div class="widget-header">
                    <h3><i class="fa fa-desktop"></i> 검색결과</h3>
                </div>
                <div class="widget-content">
                    <span id="search_bannerType_aria" onchange="btSearchClick();"></span>
                    <span id="search_platformGroup_aria" onchange="btSearchClick();"></span>
                    <table id="list_info" class="table table-sorting table-hover table-bordered">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- DATA TABLE END -->
    </div>
</div>

<script src="../../../js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script>
    $(document).ready(function() {
        fnc_bannerList.init();
    });

var fnc_bannerList = {};

//=------------------------------ Init / Event--------------------------------------------
    fnc_bannerList.targetId= "bannerList",

    fnc_bannerList.init= function() {
        fnc_bannerList.target = $("#" + fnc_bannerList.targetId);
        fnc_bannerList.targetDataTableId = "list_info_" + fnc_bannerList.targetId;
        fnc_bannerList.target.find("#list_info").attr("id", fnc_bannerList.targetDataTableId);
        fnc_bannerList.targetDataTable = fnc_bannerList.target.find("#" + fnc_bannerList.targetDataTableId);
        fnc_bannerList.divDataTable = fnc_bannerList.targetDataTable.parent("div");

        fnc_bannerList.initDataTable();
        fnc_bannerList.initEvent();

        fnc_bannerList.getBannerStat();


        if($("#bannerTab").length == 0){
            var template = $('#tmp_banner_tab').html();
            var templateScript = Handlebars.compile(template);
            var context = null;
            var html=templateScript(context);
            $("#list_info_bannerList").before(html);
        }
    };


    fnc_bannerList.dtList_info= "";
    fnc_bannerList.dtList_statistics_info= "";
    fnc_bannerList.initDataTable= function() {
        //=---------- Main DataTable ----------
        var dtList_info_data = function (data) {
            data.position = $('#position').val();
            data.platform = $("#platform").val();
        };

        fnc_bannerList.dtList_info = new DalbitDataTable(fnc_bannerList.targetDataTable, dtList_info_data, BannerDataTableSource.list, $("#searchForm"));
        fnc_bannerList.dtList_info.useCheckBox(true);
        fnc_bannerList.dtList_info.useIndex(true);
        fnc_bannerList.dtList_info.setPageLength(1000);
        fnc_bannerList.dtList_info.createDataTable();
        //fnc_bannerList.dtList_info.createDataTable(this.initSummary);

        //---------- Main DataTable ----------=

        fnc_bannerList.initDataTableButton();
    };


    fnc_bannerList.initSummary= function(json) {
        //------------- 우측 상단 통계 -----------------------------------
        var template = $('#tmp_bannerListStatisticsFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = json.summary;
        var html=templateScript(context);

        /*fnc_bannerList.divDataTable = fnc_bannerList.targetDataTable.parent("div");
        fnc_bannerList.target.find("#div_summary").remove();
        fnc_bannerList.divDataTable.find(".top-right").prepend(html);*/

        fnc_bannerList.bindOrderEvent();
    };


    // DataTable Button
    fnc_bannerList.initDataTableButton= function() {
        var delBtn = '<input type="button" value="선택 삭제" class="btn btn-danger btn-sm" id="btn_delete" style="margin-right: 3px;"/>'
        var addBtn = '<input type="button" value="등록" class="btn btn-success btn-sm" id="btn_insert" style="margin-left: 3px;"/>'
        // var excelBtn = '<button class="btn btn-default print-btn btn-sm" type="button" style="margin-left: 3px;"><i class="fa fa-print"></i>Excel Down</button>'

        var delBtn_2 = '<input type="button" value="선택 삭제" class="btn btn-danger btn-sm" id="btn_delete2" style="margin-right: 3px;"/>'
        var addBtn_2 = '<input type="button" value="등록" class="btn btn-success btn-sm" id="btn_insert2" style="margin-left: 3px;"/>'

        $('.comments').before(delBtn_2);
        fnc_bannerList.divDataTable.find(".top-right").append(addBtn_2);

        fnc_bannerList.divDataTable.find(".footer-left").append(delBtn);
        fnc_bannerList.divDataTable.find(".footer-right").append(addBtn);
        // fnc_bannerList.divDataTable.find(".footer-right").append(excelBtn);

    };

    fnc_bannerList.bindOrderEvent = function(){
        dragEventBind();
    };

    $(document).on('click', '#btn_order', function(){

        if($('#position').val() == -1){
            alert('배너 구분이 전체 상태에선 순서변경이 불가합니다.');
            return false;
        }

        if(confirm('순서를 변경하시겠습니까?')){
            var bannerList = new Array();
            $('._getNoticeDetail').each(function(index){
                bannerList.push({
                    banner_idx : $(this).data('banner-idx')
                    , order : index
                });
            });

            var data = {
                jsonParam : JSON.stringify(bannerList)
            }
            util.getAjaxData('setOrder', "/rest/content/banner/updateOrder", data, function(dst_id, data){
                alert(data.message);
                fnc_bannerList.selectMainList();
            });
        }
    })

    fnc_bannerList.initEvent= function(){
        fnc_bannerList.target.find("#btn_insert, #btn_insert2").on("click", function () { //등록
            fnc_bannerList.insertEvent();
        })

        fnc_bannerList.target.find("#btn_delete, #btn_delete2").on("click", function () { //삭제
            fnc_bannerList.deleteEvent();
        })

        // Detail 선택 이벤트
        fnc_bannerList.target.on('click', '._getNoticeDetail', function(){
            var code = $(this).data('idx');
            var data = fnc_bannerList.dtList_info.getDataRow(code);

            fnc_bannerList.updateData(data);
        });

        // CheckBox 이벤트
        fnc_bannerList.target.find('tbody').on('change', 'input[type="checkbox"]', function () {
            if($(this).prop('checked')){
                $("#bannerListContent").show();
                $(this).parent().parent().find('._getNoticeDetail').click();
            }else{
                $("#bannerListContent").hide();
            }
        });
    };

    fnc_bannerList.getBannerStat = function(){
        util.getAjaxData('bannerStat', "/rest/content/banner/bannerStat", null, function(dst_id, response){
            var data = response.data;
            $("#stat_on").html(common.addComma(data.on_cnt));
            $("#stat_off").html(common.addComma(data.off_cnt));
            $("#stat_pc").html(common.addComma(data.pc_cnt));
            $("#stat_aos").html(common.addComma(data.aos_cnt));
            $("#stat_ios").html(common.addComma(data.ios_cnt));
            $("#stat_mainTop").html(common.addComma(data.mainTop_cnt));
            $("#stat_mainCenter").html(common.addComma(data.mainCenter_cnt));
            $("#stat_clipCenter").html(common.addComma(data.clipCenter_cnt));
            $("#stat_gnb").html(common.addComma(data.gnb_cnt));
            $("#stat_start").html(common.addComma(data.start_cnt));
            $("#stat_end").html(common.addComma(data.end_cnt));
            $("#stat_image").html(common.addComma(data.image_cnt));
            $("#stat_text").html(common.addComma(data.text_cnt));

            $("#stat_sum_onOff").html(common.addComma(data.on_cnt + data.off_cnt));
            $("#stat_sum_platform").html(common.addComma(data.on_cnt));

            var sum_position = data.mainTop_cnt;
            sum_position += data.mainCenter_cnt;
            sum_position += data.clipCenter_cnt;
            sum_position += data.gnb_cnt;
            sum_position += data.start_cnt;
            sum_position += data.end_cnt;
            sum_position += data.image_cnt;
            sum_position += data.text_cnt;
            $("#stat_sum_position").html(common.addComma(sum_position));
        });
    }


//=------------------------------ Option --------------------------------------------

    // 등록
    fnc_bannerList.insertEvent= function() {
        //등록을 위한 데이터 초기화
        initSelectDataInfo();

        $("#tab_bannerDetail").click();
        ui.unCheck(fnc_bannerList.targetDataTableId);
    };

    // 삭제
    fnc_bannerList.deleteEvent= function() {
        var checkDatas = fnc_bannerList.dtList_info.getCheckedData();

        if(checkDatas.length <= 0){
            alert("삭제할 정보를 선택해주세요.");
            return false;
        }

        if(confirm("선택하신 " + checkDatas.length + "건의 정보를 삭제 하시겠습니까?")){

            var itemCodes = "";
            for(var idx=0; idx < checkDatas.length; idx++){
                var dataInfo = checkDatas[idx];
                if(common.isEmpty(dataInfo.banner_idx)){
                    dalbitLog("[delete] Item code does not exist. : ");
                    dalbitLog(dataInfo);
                    continue;
                }

                itemCodes += "," + dataInfo.banner_idx;
            }
            itemCodes = itemCodes.substring(1);

            var data = new Object();
            data.banner_idx = itemCodes;

            util.getAjaxData(fnc_bannerList.targetId, "/rest/content/banner/delete",data, fnc_bannerList.fn_delete_success, fnc_bannerList.fn_fail);
        };
    };

    // 수정
    fnc_bannerList.updateData= function(data) {
        // 정보전달을 위한 값 셋팅
        setSelectDataInfo("data", data);

        var selectTabId = "bannerDetail";
        if(fnc_bannerList.target.find("#contentTab").find(".active").length != 0){
            selectTabId = $("#contentTab").find(".active").find("a").prop("id").split("_")[1];
        }
        console.log(selectTabId)
        var targetFnc = eval("fnc_"+selectTabId);

        // targetFnc.updateDetail();
        $("#tab_" + selectTabId).click();
    };

    // 삭제 성공 시
    fnc_bannerList.fn_delete_success= function(dst_id, data, dst_params){
        alert(data.message +'\n- 성공 : ' + data.data.sucCnt + '건\n- 실패 : ' + data.data.failCnt +'건');

        // reload
        fnc_bannerList.selectMainList();

        //상단 이동
        $('html').animate({scrollTop : 0}, 100);
        $("#"+fnc_bannerDetail.formId).empty();
    };


    // Ajax 실패
    fnc_bannerList.fn_fail= function(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    };


    // 검색
    fnc_bannerList.selectMainList= function(isResetPaging){
        /* 엑셀저장을 위해 조회조건 임시저장 */
        // tmp_search = $('#txt_search').val();
        // tmp_gubun = $("select[name='selectGubun']").val();

        // Summary를 위한 재생성
        fnc_bannerList.dtList_info.reload(this.initSummary, isResetPaging);

    };

    // /*=---------- 엑셀 ----------*/
    // $('#excelDownBtn').on('click', function(){
    //     var formElement = document.querySelector("form");
    //     var formData = new FormData(formElement);
    //
    //     formData.append("search", tmp_search);
    //     formData.append("date", tmp_date);
    //     formData.append("gubun", tmp_gubun);
    //     formData.append("checkDate", tmp_checkDate);
    //     formData.append("stDate", tmp_stDate);
    //     formData.append("edDate", tmp_edDate);
    //     /*formData.append("test003", "test003");*/
    //     excelDownload($(this), "/rest/member/member/listExcel", formData, fn_success_excel, fn_fail_excel)
    // });

    // $("#excelBtn").on("click", function () {
    //     $("#list_info").table2excel({
    //         exclude: ".noExl",
    //         name: "Excel Document Name",
    //         filename: "report" +'.xls', //확장자를 여기서 붙여줘야한다.
    //         fileext: ".xls",
    //         exclude_img: true,
    //         exclude_links: true,
    //         exclude_inputs: true
    //     });
    // });
    //
    // function fn_success_excel(){
    //     console.log("fn_success_excel");
    // }
    //
    // function fn_fail_excel(){
    //     console.log("fn_fail_excel");
    // }
    /*----------- 엑셀 ---------=*/


    /*ondrop="fnc_castList.drop(event)"
    ondragover="fnc_castList.allowDrop(event)"
    draggable="true"
    ondragstart="fnc_castList.drag(event)"*/

    var dragInfo = {
        index : null
        , tr : null
    }
    function dragEventBind(){

        if($("#position").val() == -1){
            return false;
        }

        var sortBtn = '<input type="button" value="순서변경" class="btn btn-success btn-sm" id="btn_order" style="margin-left: 3px;"/>'
        fnc_bannerList.divDataTable.find(".top-right").html(sortBtn);

        var dragTarget = $('#list_info_bannerList tbody tr');

        dragTarget.attr('draggable', 'true');

        dragTarget.on('drop', function(event){
            event.preventDefault();
            var drag_index = dragInfo.index;

            var target_index = dragTarget.index(event.target.closest('tr'));
            if(target_index < drag_index){
                event.target.closest('tr').before(dragInfo.tr);
            }else{
                event.target.closest('tr').after(dragInfo.tr);
            }
        });

        dragTarget.on('drag', function(event){
            dragInfo.index = dragTarget.index(event.target);
            dragInfo.tr = event.target.closest('tr');
        });

        dragTarget.on('dragover', function(event){
            event.preventDefault();
        });

        dragTarget.on('dragstart', function(event){

        });
    }

    $(document).on('click', "#bannerTab ul li", function(){
        var me = $(this);
        var activeClass = 'active';

        $("#bannerTab ul li").removeClass(activeClass);
        me.addClass(activeClass);
        $('#is_view').val(me.data('is_view'));
        $('#bt_search').click();
    });

    $(document).on('click', "#bannerTab ul li", function(){
        var me = $(this);
        var activeClass = 'active';

        $("#bannerTab ul li").removeClass(activeClass);
        me.addClass(activeClass);
        $('#is_view').val(me.data('is_view'));
        $('#bt_search').click();
    });

    $(document).on('click', '._down', function(){
        if($('#position').val() == -1){
            alert('배너 구분이 전체 상태에선 순서변경이 불가합니다.');
            return false;
        }

        var targetTr = $(this).closest('tr');
        var selector = $('#list_info_bannerList tbody tr');
        var targetIndex = selector.index(targetTr);
        if(selector.index(targetTr) < selector.length -1){
            $(selector[targetIndex+1]).after(targetTr);
        }
    });

    $(document).on('click', '._up', function(){
        if($('#position').val() == -1){
            alert('배너 구분이 전체 상태에선 순서변경이 불가합니다.');
            return false;
        }

        var targetTr = $(this).closest('tr');
        var selector = $('#list_info_bannerList tbody tr');
        var targetIndex = selector.index(targetTr);
        if(0 < selector.index(targetTr)){
            $(selector[targetIndex-1]).before(targetTr);
        }
    });
</script>



<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_bannerListStatisticsFrm" type="text/x-handlebars-template">

    <div id="div_summary" style="float:left">
        <table class="table table-sorting table-hover table-bordered dataTable no-footer" style="width:400px;">
            <colgroup>
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th colspan="3">ON 배너</th>
                <th colspan="3">ON 배너 클릭</th>
                <th colspan="3"><label style="color: blue">남</label></th>
                <th colspan="3"><label style="color: red">여</label></th>
            </tr>
            <tr>
                <td style="text-align:center;" colspan="3">{{banner_col1}}건</td>
                <td style="text-align:center;" colspan="3">{{banner_col1}}건 ({{banner_col1}}%)</td>
                <td style="text-align:center;" colspan="3">{{banner_col1}}명</td>
                <td style="text-align:center;" colspan="3">{{banner_col1}}명</td>
            </tr>
            </tbody>
        </table>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_banner_tab">
    <div id="bannerTab" style="margin-bottom: -7px;">
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
            <li data-is_view='-1'>
                <a href="javascript://">전체</a>
            </li>
            <li class="active" data-is_view='1'>
                <a href="javascript://">게시 ON</a>
            </li>
            <li data-is_view='0'>
                <a href="javascript://">게시 OFF</a>
            </li>
        </ul>
    </div>
</script>