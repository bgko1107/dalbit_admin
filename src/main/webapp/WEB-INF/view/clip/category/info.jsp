<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_tabMove = request.getParameter("tabMove");
%>

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
                                        <div id="div_dayButton"><jsp:include page="../../searchArea/daySearchArea.jsp"/></div>
                                        <div id="div_monthButton"><jsp:include page="../../searchArea/monthSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <span id="sp_radioGroup" style="display: none">
                                        <label class="control-inline fancy-radio custom-color-green">
                                            <input type="radio" name="rankType" value='1' checked="checked" />
                                            <span><i></i>일간</span>
                                        </label>
                                        <label class="control-inline fancy-radio custom-color-green">
                                            <input type="radio" name="rankType" value='2' />
                                            <span><i></i>주간</span>
                                        </label>
                                    </span>
                                    <input id="onedayDate" type="text" class="form-control" style="width: 196px;"/>
                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요."></label>

                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>

                                    <span id="sp_prevGroup" style="display: none">
                                        <a href="javascript://" class="_prevSearch">[이전]</a>
                                        <a href="javascript://" class="_todaySearch">[오늘]</a>
                                        <a href="javascript://" class="_nextSearch">[다음]</a>
                                    </span>

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
</div>


<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/clip/clipHistoryDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/clip/clipCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    var tabMove = <%=in_tabMove%>;
    var tabId = 'tab_new';

    $(function(){
        // tab_id 이동
        if(!common.isEmpty(tabMove)){
            if(tabMove == 3){
                $('.nav-tabs li:eq(3) a').tab('show');
                slctType = 1;
            }else{
                slctType = 99;
            }
        }else{
            slctType = 99;
        }
        dateType();

        $('input[id="searchText"]').keydown(function() {
            if (event.keyCode === 13) {
                $("#bt_search").click();
            };
        });

        if(tabMove == 3){
            tabId = 'tab_recommendList';
            getRecommendList();
        }
    });

    $(document).on('click', '#search_testId', function(){
        $("#bt_search").click();
    });

    $('input[name="rankType"]').on('change', function(){
        if($('input:radio[name="rankType"]:checked').val() == 1){
            slctType = 0;
        }else if($('input:radio[name="rankType"]:checked').val() == 2){
            slctType = 4;
        }
        dateType();
        if($('input:radio[name="rankType"]:checked').val() == 2){       // 주간
            setMonday();
        }
    });



    //클립 운영자 인증 요청
    function editClipConfirm(clipNo, confirmData){
        console.log(clipNo);
        console.log(confirmData);
        if(confirm("운영자 관리 여부를 수정 하시겠습니까?")) {
            var data = Object();
            data.cast_no = clipNo;
            data.editSlct = 8;
            data.confirm = confirmData === 1 ? 0 : 1;
            data.sendNoti = 0;

            editClipDetailData(data);
        }
    }

    //클립 수정
    var isAlertShow = true;
    function editClipDetailData(data, isAlert){
        isAlertShow = true;
        if(!common.isEmpty(isAlert)){
            isAlertShow = isAlert
        }

        util.getAjaxData("clipDetailInfoEdit", "/rest/clip/history/info/edit", data, fn_detailInfo_Edit_success);
    }

    function fn_detailInfo_Edit_success(dst_id, response, dst_params) {
        console.log(response);
        // dtList_info.reload(selectCallback_hotHistory, false);
        $("#bt_search").click();
        if(isAlertShow){alert(response.message)};
    }

    //클립 신고 팝업 오픈
    function openClipReportPopup(){
        var report = "/member/member/popup/reportPopup?"
            + "memNo=" + encodeURIComponent(clipInfoData.cast_mem_no)
            + "&memId=" + encodeURIComponent(clipInfoData.cast_userId)
            + "&memNick=" + encodeURIComponent(common.replaceHtml(clipInfoData.cast_nickName))
            + "&memSex=" + encodeURIComponent(clipInfoData.cast_memSex)
            + "&deviceUuid=" + clipInfoData.cast_deviceUuid
            + "&ip=" + clipInfoData.cast_ip;

        util.windowOpen(report,"750","910","clipReport");
    }

    // 클립 신고 팝업 완료 콜백 함수
    function getMemNo_info_reload(memNo){
        if(!common.isEmpty(clipInfoData)){
            var data = Object();
            data.memNo = memNo;
            data.cast_no = clipInfoData.castNo;
            data.editSlct = 4;
            data.state = 5;
            data.sendNoti = 1;

            editClipDetailData(data, false);
        }
        // dtList_info.reload(selectCallback_hotHistory, false);
    }

    function recommendConfirmEdit(data){
        editClipConfirm(data.castno,data.confirm);
    }


    // 댓글 목록 리스트
    $(document).on('click', '._selectReply', function() {
        if($(this).data('reply') == 0) {
            alert('해당 클립에는 등록된 댓글이 없습니다.');
        } else if($(this).data('reply') > 0) {
            var data = {
                'targetClipNo' : $(this).data('cast_no')
            };
            util.getAjaxData("selectReply", "/rest/clip/history/reply/list", data, fn_success_selectReply);
        }
    });

    function fn_success_selectReply(dst_id, response) {
        $('#div_reply').empty();
        console.log("------------------------------- 1");
        for(var i=0 ; i<response.data.length; i++){
            var tmp = '<div class="col-md-12 no-padding" style="margin-bottom: 10px;">';
            tmp +=    '<div class="col-md-2">';
            tmp +=      '<form id="profileImg' + i + '" method="post" enctype="multipart/form-data">';
            tmp +=          '<img class="pull-right" id="image_section' + i + '" src="" alt="your image" style="width: 40px;height: 40px"/>';
            tmp +=      '</form>';
            tmp +=     '</div>';
            tmp +=     '<div class="col-md-10">';
            if(response.data[i].status == "2"){
                tmp +=      '<i class="fa fa-lock" style="padding-left: 3px;padding-right: 3px"></i>';
            }
            tmp +=      '<label id="nickName' + i + '"></label>';
            tmp +=      '<label id="userId' + i + '" style="color: #6e696e"></label> - <label id="writeDateFormat' + i + '"></label> <br/>';
            tmp +=      '<lable id="contents' + i + '"></label><br>';
            tmp +=     '</div>';
            tmp +=     '</div>';


            console.log(tmp);
            $('#div_reply').append(tmp);

            $('#nickName' + i).text(response.data[i].memNick);
            $('#userId' + i).text(response.data[i].memNo);
            $('#writeDateFormat' + i).text(response.data[i].writeDate);
            $('#contents' + i).text(response.data[i].contents);
            $('#image_section' + i).prop("src" ,common.profileImage(PHOTO_SERVER_URL,response.data[i].profileImage,memSex));

            $('#clipReplyModal').modal("show");
        }
    }


</script>
