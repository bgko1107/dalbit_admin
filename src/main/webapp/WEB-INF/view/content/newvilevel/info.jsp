<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-12 no-padding">
        <div class="container-fluid col-lg-12 no-padding" id="searchContainer">
            <form id="searchForm">
                <div class="col-lg-12 form-inline no-padding">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th id="th_bottonList">
                                    <jsp:include page="../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <label><input type="text" class="form-control" id="searchText" name="searchText" placeholder="검색할 정보를 입력하세요" style="display: none"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>

                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>

                                    <span id="searchCheck">
                                        <label class="control-inline fancy-checkbox custom-color-green">
                                            <input type="checkbox" name="search_testId" id="search_testId" value="1">
                                            <span>테스트 아이디 제외</span>
                                        </label>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <!-- tab -->
    <div class="no-padding" id="infoTab">
        <jsp:include page="infoTab.jsp"/>
    </div>
    <!-- //tab -->

    <span id="eventPopupManagement"></span>
</div>


<script type="text/javascript">

    $(function(){
        slctType = 1;
        dateType();

        $(document).on('click', '#search_testId', function(){
            $("#bt_search").click();
        });
    });


    function eventPopupManagement(){
        var template = $('#tmp_eventPopupManagement').html();
        var templateScript = Handlebars.compile(template);
        // var context = response.data;
        var html = templateScript();
        $("#eventPopupManagement").html(html);
        ui.paintColor();


        $("input[name='platform']").change(function () {
            if ($(this).val() == "-1") {
                if ($(this).is(":checked")) {
                    $("input[name='platform']").each(function () {
                        this.checked = true;
                    });
                } else {
                    $("input[name='platform']").each(function () {
                        this.checked = false;
                    });
                }
            } else {
                if ($(this).is(":checked")) {
                    var cntTotal = $("input[name='platform']").length;
                    var cntChecked = $("input[name='platform']:checked").length;
                    if ((cntTotal) == (cntChecked + 1)) {
                        $("input[name='platform'][value='-1']").prop("checked", true);
                    }
                } else {
                    $("input[name='platform'][value='-1']").prop("checked", false);
                }
            }
        });

        // if(detailData.platform == "111"){
        //     fnc_pushDetail.target.find("input[name='platform']").each(function () {
        //         this.checked = true;
        //     });
        // }else{
        //     fnc_pushDetail.target.find("input[name='platform']").each(function () {
        //         this.checked = false;
        //     });
        //
        //     var arrayPlatform = detailData.platform.split('');
        //     for(var idx in arrayPlatform){
        //         if(arrayPlatform[idx] == 1){
        //             var value = parseInt(idx) + 1;
        //             fnc_pushDetail.target.find("input[name='platform'][value='"+ value +"']").prop("checked", true);
        //         }
        //     }
        // }
    }

    function preview(imageType){
        var imageUrl = imageType == "pc" ? $("#txt_pcImage").val() : $("#txt_mobileImage").val() ;
        $("#imageFullSize").html(util.imageFullSize("fullSize_background", imageUrl));
        $("#fullSize_background").modal('show');
    }


    function handlebarsPaging(targetId, pagingInfo) {
        if(targetId == "detail_paginate_top" || targetId == "detail_paginate") {
            detailPagingInfo = pagingInfo;
            getDetailList(pagingInfo.pageNo);
        }
    }


</script>



<%--<script type="text/x-handlebars-template" id="tmp_eventPopupManagement">
    <table class="table table-sorting table-bordered datatable">
        <colgroup>
            <col width="10%"><col width="10%"><col width="35%"><col width="20%"><col width="20%">
        </colgroup>
        <tr>
            <th colspan="5" class="_bgColor" data-bgcolor="#c6d9f1">이벤트 팝업 정보 <button type="button" class="btn btn-default btn-ms pull-right" onclick="">저장</button></th>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">플랫폼</th>
            <td>
                <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="platform" id="platform-1" value="-1" checked="true"><span>전체</span> </label>
                <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="platform" id="platform1" value="1" checked="true"><span>PC</span></label>
                <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="platform" id="platform2" value="2" checked="true"><span>Android</span></label>
                <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="platform" id="platform3" value="3" checked="true"><span>IOS</span></label>
            </td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">IOS 심사중 노출</th>
            <td>
                <div class="control-inline onoffswitch">
                    <input type="checkbox" name="iosJudge" class="onoffswitch-checkbox" id="iosJudge">
                    <label class="onoffswitch-label" for="iosJudge">
                        <span class="onoffswitch-inner"></span>
                        <span class="onoffswitch-switch"></span>
                    </label>
                </div>
            </td>
        </tr>
        <tr>
            <th rowspan="2" class="_bgColor" data-bgcolor="#c6d9f1">이미지 팝업</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">PC 이미지</th>
            <td>
                <div class="col-md-10 no-padding">
                    <input type="text" class="form-control" id="txt_pcImage" value="{{pcImage}}">
                </div>
                <button class="btn-default btn-xs pull-right" onclick="preview('pc');">미리보기</button>
            </td>
            <td rowspan="2">
                <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="dayNotOpen" id="dayNotOpen"><span>오늘 하루 열지 않기</span></label>
            </td>
            <td rowspan="2">
                <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="linkApply" id="linkApply" ><span>링크 적용</span></label>
            </td>
        </tr>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1">모바일 이미지</th>
            <td>
                <div class="col-md-10 no-padding">
                    <input type="text" class="form-control" id="txt_mobileImage" value="{{mobileImage}}">
                </div>
                <button class="btn-default btn-xs pull-right" onclick="preview('mobile');">미리보기</button>
            </td>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">PC 링크</th>
            <td colspan="3">
                <input type="text" class="form-control" id="txt_pcLink" value="{{pcLink}}">
            </td>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">모바일 링크</th>
            <td colspan="3">
                <input type="text" class="form-control" id="txt_mobileLink" value="{{mobileLink}}">
            </td>
        </tr>
    </table>
    <span>가입한지 2주 이내의 회원에게 보여지는 메인 팝업에 대한 관리. (띠배너는 별도 관리 없음)</span>
</script>--%>
