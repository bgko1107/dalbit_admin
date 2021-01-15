<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <!-- serachBox -->
        <div class="row col-lg-12 form-inline">
            <div class="col-md-8 no-padding">
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
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <jsp:include page="../../searchArea/dateRangeSearchArea.jsp"/>

                                <input id="onedayDate" type="text" class="form-control" >

                                <input type="hidden" name="startDate" id="startDate">
                                <input type="hidden" name="endDate" id="endDate" />

                                <%--<input name="startDate" id="startDate">--%>
                                <%--<input name="endDate" id="endDate" />--%>

                                <label><input type="text" class="form-control" id="txt_search" placeholder="검색할 정보를 입력하세요"></label>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                <a href="javascript://" class="_prevSearch">[이전]</a>
                                <a href="javascript://" class="_todaySearch">[오늘]</a>
                                <a href="javascript://" class="_nextSearch">[다음]</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="col-md-4 no-padding">
                <span id="summaryArea"></span>
            </div>
        </div>
        <!-- //serachBox -->
        <!-- tab -->
        <div class="row col-lg-12 form-inline">
            <jsp:include page="boardAdmTab.jsp"/>
        </div>
        <!-- //tab -->
    </div> <!-- //page-wrapper -->
</div> <!-- //wrapper -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    $(document).ready(function() {
        slctType = 0;
        dateType();
    });

    function handlebarsPaging(targetId, pagingInfo) {

        if(targetId == "notice_paginate_top" || targetId == "notice_paginate") {
            noticePagingInfo = pagingInfo;
            noticeList(pagingInfo.pageNo);

        }else if(targetId == "story_paginate_top" || targetId == "story_paginate"){
            StoryPagingInfo = pagingInfo;
            storyList(pagingInfo.pageNo);

        } else if(targetId == "fanBoard_paginate_top" || targetId == "fanBoard_paginate") {
            fanBoardPagingInfo = pagingInfo;
            fanBoardList(pagingInfo.pageNo);

        }else if(targetId == "fanBoardReply_paginate_top" || targetId == "fanBoardReply_paginate") {
            fanBoardReplyPagingInfo = pagingInfo;
            fanBoardReply(pagingInfo.pageNo);

        } else if(targetId == "list_info_paginate_top" || targetId == "list_info_paginate") {
            shotListPagingInfo = pagingInfo;
            profileMsgList(pagingInfo.pageNo);

        } else if(targetId == "broadNotice_paginate_top" || targetId == "broadNotice_paginate") {
            sbroadNoticePagingInfo = pagingInfo;
            broadNoticeList(pagingInfo.pageNo);

        } else if(targetId == "clipReply_paginate_top" || targetId == "clipReply_paginate"){
            clipPagingInfo = pagingInfo;
            clipReplyList(pagingInfo.pageNo);

        }else if(targetId == "profile_paginate_top" || targetId == "profile_paginate"){
            profilePagingInfo = pagingInfo;
            profileMsgList(pagingInfo.pageNo);

        }else if(targetId == "noticeReply_paginate_top" || targetId == "noticeReply_paginate"){
            noticeReplyPagingInfo = pagingInfo;
            broadNoticeReply(pagingInfo.pageNo);

        }else if(targetId == "mailbox_paginate_top" || targetId == "mailbox_paginate"){
            mailboxPagingInfo = pagingInfo;
            mailboxList(pagingInfo.pageNo);
        }
    }

    // thumbnail 명칭 겹쳐서 thumbnailImg 로 세팅
    var xOffset = 10;
    var yOffset = 30;
    var height = 0;
    $(document).on("mouseover",".thumbnailImg",function(e){ //마우스 오버
        if(common.isEmpty($(this).attr("src"))){
            return;
        }

        $("body").append("<p id='preview'><img id='previewImage' src='"+ $(this).attr("src") +"' width='300px' /></p>"); //이미지

        $("#previewImage").load(function () {
            height = $(this).height();
        });

        $("#preview")
            .css("top",(e.pageY - ((height/2) + (height/2)) + 30) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast");
    });
    $(document).on("mousemove",".thumbnailImg",function(e){ //마우스 이동
        $("#preview")
            .css("top",(e.pageY - ((height/2) + (height/2)) + 30) + "px")
            .css("left",(e.pageX + yOffset) + "px");
    });
    $(document).on("mouseout",".thumbnailImg",function(){ //마우스 아웃
        $("#preview").remove();
    });
</script>