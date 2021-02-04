<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
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
                                    <span id="search_os_area"></span>
                                    <button type="button" class="btn btn-success btn-sm" id="bt_search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>

            <div class="row col-lg-12 form-inline">
                <div class="widget">
                    <div class="widget-header">
                        <h3>IOS 심사중여부</h3>
                        <div class="widget-header-toolbar">
                            <div class="control-inline toolbar-item-group">
                                <span class="control-title _fontColor font-bold" data-fontColor="red"><i class="fa fa-mobile-phone"></i>심사중여부</span>
                                <div class="control-inline onoffswitch">
                                    <input type="checkbox" name="iosJudge" class="onoffswitch-checkbox" id="iosJudge">
                                    <label class="onoffswitch-label" for="iosJudge">
                                        <span class="onoffswitch-inner"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="widget-content">
                        <span>
                            심사중여부를 "ON"으로 설정 시 <br />
                            배너와 공지사항의 [IOS 심사 중 노출여부]가 체크된 항목을 보이지 않도록 합니다.
                        </span>
                    </div>
                </div>
            </div>

            <div class="row col-lg-12 form-inline" id="insertBtn">
                [현재 최신버전]<br/>
                <div class="col-md-9 no-padding">
                    <div class="col-md-3 no-padding">
                        IOS: <span id="ios"></span><br/>
                        <input type="text" class="form-control mb5" id="iosVersion" placeholder="직접입력" maxlength="10">
                        <button type="button" class="btn btn-default btn-sm mb5" id="iosUpdateBtn">IOS업데이트</button>
                    </div>
                    <div class="col-md-3 no-padding">
                        AOS: <span id="aos"></span><br/>
                        <input type="text" class="form-control mb5" id="aosVersion" placeholder="직접입력" maxlength="10">
                        <button type="button" class="btn btn-default btn-sm mb5" id="aosUpdateBtn">AOS업데이트</button>
                    </div>
                </div>
                <div class="col-md-3 no-padding"><br/>
                    <button type="button" class="btn btn-default btn-sm pull-right mb5" id="bt_insert">등록</button>
                </div>
            </div>

            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i>검색결과</h3>
                    </div>
                </div>
                <div class="widget-content">
                    <table id="list_info" class="table table-sorting table-hover table-bordered">
                        <thead></thead>
                        <tbody id="tableBody"></tbody>
                    </table>
                </div>
                <%--<div class="widget-footer">--%>
                <%--<span>--%>
                <%--<button type="button" class="btn btn-danger" id="bt_delete">선택삭제</button>--%>
                <%--</span>--%>
                <%--<span>--%>
                <%--<button class="btn btn-default print-btn pull-right hide" type="button" id="bt_edit">수정하기</button>--%>
                <%--</span>--%>
                <%--</div>--%>
            </div> <!-- #DataTable -->
            <form id="appList"></form>
        </div> <!-- #container-fluid -->
    </div><!-- #page-wrapper -->
</div> <!-- #wrapper -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var dtList_info;
    $(document).ready(function () {
        versionSelect();
        init();
        ui.checkBoxInit('list_info')
    });

    $("#bt_search").click(function () {
        getAppList();
    });

    /** Data Table **/
    function init() {
        var dtList_info_data = function (data) {
        };
        dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, AppDataTableSource.appInfo, $("#searchForm"));
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(true);
        dtList_info.createDataTable();

        $("#search_os_area").html(util.getCommonCodeSelect(-1, content_selectApp));

        getAppList();

        //IOS 심사중여부 가져오기
        getIosJudgeState();

    }

    function getAppList() {
        dtList_info.reload();
        ui.toggleSearchList();
    }

    function fn_detail_success(dst_id, response) {
        var template = $("#tmp_appList").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $("#appList").html(html);
        disabled();
    }

    $(document).on('click', '._appDetail', function () {

        var data = {
            'idx': $(this).data('idx')
        };
        util.getAjaxData("detail", "/rest/content/app/detail", data, fn_detail_success);
        if($("#bt_insert").removeClass("hide")) {
            $("#bt_insert").show();
        }
        if($("#bt_edit").removeClass("hide")) {
            $("#bt_edit").show();
        }
    });

    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function () {
        if ($(this).prop('checked')) {
            $(this).prop('checked', 'checked');
            $(this).parent().parent().find('._appDetail').click();
        } else {
            $("#appList").empty();
            $("#bt_edit").hide();
        }
    });

    function disabled() {
        if($("#bt_insert").length > 0) {
            $('input:radio[name="os"]').attr("disabled", "disabled");
            $('input:text[name="version"]').attr("disabled", "disabled");
            $('#build_no').attr("disabled", "disabled");
            $('#upBuild_no').attr("disabled", "disabled");
            $('input:radio[name="is_use"]').attr("disabled", "disabled");
            $('#memo').attr("disabled", "disabled");
        }
    }


    $("#bt_insert").on('click', function () {
        $("#appList").empty();
        $(this).hide();
        $("#bt_edit").hide();
        generateForm();

        ui.unCheck('list_info');

        var today = new Date();
        var year = today.getFullYear();
        var month = common.lpad(today.getMonth() + 1, 2, '0');
        var date = common.lpad(today.getDate(), 2, '0');
        var hour = common.lpad(today.getHours(), 2, '0');
        var min = common.lpad(today.getMinutes(), 2, '0');

        var day = year + "." + month + "." + date + " " + hour + ":" + min;
        $("#day").html(day);
    });

    function generateForm() {
        var template = $('#tmp_appList').html();
        var templateScript = Handlebars.compile(template);
        $("#appList").html(templateScript);
    }

    function isValid() {
        var os = $('input:radio[name="os"]:checked').val();
        if(common.isEmpty(os)) {
            alert("os타입을 선택해주세요.");
            return false;
        }

        var version = $('input:text[name="version"]').val();
        if(common.isEmpty(version)) {
            alert("version을 입력해주세요.");
            return false;
        }

        var isForce = $('#build_no').val();
        if(common.isEmpty(isForce)) {
            alert("build_no을 입력해주세요.");
            return false;
        }

        var isForce = $('#upBuild_no').val();
        if(common.isEmpty(isForce)) {
            alert("upBuild_no 입력해주세요.");
            return false;
        }

        var isUse = $('input:radio[name="is_use"]:checked').val();
        if(common.isEmpty(isUse)) {
            alert("사용 여부를 선택해주세요.");
            return false;
        }

        return true;
    }

    $(document).on('click', '#insertAppBtn', function () {
        if(isValid()) {
            if (confirm("등록하시겠습니까?")) {
                util.getAjaxData("insert", "/rest/content/app/insert", $("#appList").serialize(), fn_success, fn_fail);
            } else {
                return;
            }
        }
    });

    // // 수정하기
    // $("#bt_edit").on('click', function() {
    //     $(this).hide();
    //     $('input:radio[name="os"]').removeAttr("disabled");
    //     $('input:radio[name="is_use"]').removeAttr("disabled");
    //     $('input:radio[name="is_force"]').removeAttr("disabled");
    //     $('input:text[name="version"]').removeAttr("disabled");
    //
    //     $("#updateAppBtn").removeClass("hide");
    // });

    // $(document).on('click', '#updateAppBtn', function() {
    //     if(isValid()) {
    //         if (confirm("수정하시겠습니까?")) {
    //             util.getAjaxData("update", "/rest/content/app/update", $("#appList").serialize(), fn_success, fn_fail);
    //         } else {
    //             return;
    //         }
    //     }
    // });

    function fn_success(dst_id, response) {
        alert(response.message);
        generateForm();
        dtList_info.reload();
        $('html').animate({scrollTop : 0}, 100);

        $("#appList").empty();
        $("#bt_insert").show();
    }

    function fn_fail() {
        dalbitLog("#####실패");
    }

    // // 삭제하기
    // $("#bt_delete").on('click', function() {
    //     var checked = $('#list_info .dt-body-center input[type="checkbox"]:checked');
    //     if(checked.length == 0) {
    //         alert("삭제할 공지사항을 선택해주세요.");
    //         return
    //     }
    //
    //     if(confirm("삭제하시겠습니까?")) {
    //         var data = {
    //             'idx': obj.idx
    //         };
    //         util.getAjaxData("delete", "/rest/content/app/delete", data, fn_delete_success, fn_fail);
    //     }
    // });
    //
    // function fn_delete_success(dst_id, response) {
    //     alert(response.message);
    //     dtList_info.reload();
    //     $("#appList").empty();
    //     $("#bt_edit").hide();
    // }

    //등록된 최신버전 가져오기
    function versionSelect(){
        util.getAjaxData("versionSelect", "/rest/content/app/select", "", fn_version_select_success);
    }


    //AOS 버전 업데이트
    $("#aosUpdateBtn").on('click', function () {
        if(common.isEmpty($("#aosVersion").val())){
            alert("버전을 입력해주세요");
            return false;
        }
        var data = {
            'os': 1
            ,'version' : $("#aosVersion").val()
        };
        util.getAjaxData("versionUpdate", "/rest/content/app/update", data, fn_version_update_success);
    });

    //IOS 버전 업데이트
    $("#iosUpdateBtn").on('click', function () {
        if(common.isEmpty($("#iosVersion").val())){
            alert("버전을 입력해주세요");
            return false;
        }
        var data = {
            'os': 2
            ,'version' : $("#iosVersion").val()
        };
        util.getAjaxData("versionUpdate", "/rest/content/app/update", data, fn_version_update_success);
    });

    function fn_version_select_success(dst_id, response){
        console.log("등록된 최신버전 가져오기");
        $('#ios').text(response.data.iosVersion);
        $('#aos').text(response.data.aosVersion);
    }

    function fn_version_update_success(){
        alert("업데이트 되었습니다.");
        $("#aosVersion").val("");
        $("#iosVersion").val("");
        versionSelect();
    }

    function getIosJudgeState(){
        var data = {
            type : 'system_config'
            , code : 'IOS_심사중여부'
        }
        util.getAjaxData("iosJudgeState", "/common/getCodeDefine", data, function(dst_id, response){
            if(response.result == 'success'){
                if(common.isEmpty(response.data)){
                    alert('IOS 심사중 상태 조회에 실패했습니다.')
                    return false;
                }
                var code = response.data.code;
                if(code.value == 'Y'){
                    $("#iosJudge").prop('checked', 'checked');
                }
            }else{
                alert('IOS 심사중 상태 조회에 실패했습니다.')
            }
        });
    }

    $('#iosJudge').on('click', function(e){
        var me = $(this);
        if(confirm(me.prop('checked') ? "IOS 심사중 상태로 변경하시겠습니까?" : "IOS 심사중 상태를 OFF 하시겠습니까?")){
            var data = {
                type : 'system_config'
                , code : 'IOS_심사중여부'
                , value : me.prop('checked') ? 'Y' : 'N'
            }
            util.getAjaxData("iosJudgeState", "/common/updateCodeDefine", data, function(dst_id, response){
                var resultMsg = 'IOS 심사중 상태 변경에 실패했습니다.';
                if(response.result == 'success'){
                    if(response.data.updateResult == 1){
                        resultMsg = 'IOS 심사중 상태가 변경되었습니다.';
                    }
                }
                alert(resultMsg);
            });
        }else{
            e.preventDefault();
            return false;
        }
    })

</script>

<script id="tmp_appList" type="text/x-handlebars-template">
    {{#idx}}<input type="hidden" name="idx" value="{{idx}}"/>{{/idx}}
    <div class="row col-lg-12 mt15">
        <div class="col-md-12 no-padding">
            <span>
                {{^idx}}<button class="btn btn-default btn-sm pull-right mb15" type="button" id="insertAppBtn">등록하기</button>{{/idx}}
                <%--{{#idx}}<button class="btn btn-default pull-right mb15 hide" type="button" id="updateAppBtn">수정완료</button>{{/idx}}--%>
            </span>
        </div>
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="5%"/>
                <col width="10%"/>
            </colgroup>
            <tr>
                <th>플랫폼</th>
                <td>
                    {{{getCommonCodeRadio os 'content_radioApp' 'Y' 'os'}}}
                </td>
            </tr>
            <tr>
                <th>version</th>
                <td>
                    <input type="text" class="_trim" name="version" id="version" value="{{version}}" maxlength="10"/>
                </td>
            </tr>
            <tr>
                <th>빌드번호</th>
                <td>
                    <input type="number" class="_trim" name="build_no" id="build_no" value="{{build_no}}" maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                </td>
            </tr>
            <tr>
                <th>최소 업데이트 빌드번호</th>
                <td>
                    <input type="number" class="_trim" name="upBuild_no" id="upBuild_no" value="{{upBuild_no}}" maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '');"/>
                </td>
            </tr>
            <tr>
                <th>사용여부</th>
                <td>
                    {{{getCommonCodeRadio is_use 'content_isUse' 'Y' 'is_use'}}}
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td id = "day">
                    {{convertToDate reg_date "YYYY.MM.DD HH:mm"}}
                </td>
            </tr>
            <tr>
                <th>운영자 메모</th>
                <td>
                    <textarea type="textarea" class="form-control" id="memo" name="memo" style="width: 100%; height: 100px">{{memo}}</textarea>
                </td>
            </tr>
        </table>
    </div>
</script>