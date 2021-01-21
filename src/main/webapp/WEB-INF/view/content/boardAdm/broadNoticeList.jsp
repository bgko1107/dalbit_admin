<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<style>
    .modal-dialog {
        overflow-y: initial !important
    }
    .modal-body {
        height: 100%;
        overflow-y: auto;
    }
</style>
<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10">
            <span id="broadNoticeListCnt"></span><br/>
            <select id="boardRoomStatus" name="boardRoomStatus" class="form-control searchType">
                <option value="0" selected="selected">공지 전체</option>
                <option value="1">정상</option>
                <option value="2">삭제</option>
            </select>

            <span id="dynamicPageBroadNoticeArea"></span>

            <div class="col-md-2 no-padding pull-right">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="15%"/><col width="65%"/>
                    </colgroup>
                    <tr>
                        <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="dataTables_paginate paging_full_numbers" id="broadNotice_paginate_top"></div>
        <table id="broadNoticeTable" class="table table-sorting table-hover table-bordered mt10">
            <colgroup>
                <col width="4%"/><col width="4%"/><col width="10%"/><col width="5%"/><col width="50%"/><col width="10%"/>
                <col width="5%"/><col width="5%"/><col width="5%"/>
            </colgroup>
            <thead>
            <tr>
                <th><input type="checkbox" class="form-control" id="allChkBroadNotice" /></th>
                <th>No</th>
                <th>등록 DJ</th>
                <th>성별</th>
                <th>회원 공지 내용</th>
                <th>이미지</th>
                <th>등록일자</th>
                <th>상태</th>
                <th>댓글 수</th>
                <th>관리</th>
            </tr>
            </thead>
            <tbody id="tb_broadNoticeList">
            </tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="broadNotice_paginate"></div>
    </div>
    <div class="widget-footer">
        <span>
            <button class="btn btn-danger btn-sm print-btn" type="button" id="deleteBroadNoticeBtn"><i class="fa fa-check"></i>선택 삭제</button>
        </span>
    </div>
</div>
<!-- //table -->

<!-- 공지 댓글 보기 -->
<div class="modal fade" id="NoticeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px;display: table;">
        <div class="modal-content">
            <div class="modal-header no-padding">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="col-md-12 no-padding" id="div_notice" style="margin-bottom: 7px"></div><br/>
                <div class="col-md-12 no-padding" id="div_noticeReply"></div>
            </div>
        </div>
    </div>
</div>
<!-- Modal 끝-->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var broadNoticePagingInfo = new PAGING_INFO(0,1,$("#dynamicPageCntBroadNotice").val());

    $(function() {
        $("#searchType_broadNotice").html(util.getCommonCodeSelect(-1, searchType_notice, "N", "searchType_broadNotice"));
        $("#dynamicPageBroadNoticeArea").html(util.renderDynamicPageCntSelect('dynamicPageCntBroadNotice'));
    });

    var memNo;
    function broadNoticeList(pagingInfo, _tabId) {
        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        $('#title').html('회원/방송공지');
        if(!common.isEmpty(pagingInfo)){
            broadNoticePagingInfo.pageNo = pagingInfo;
        }else{
            broadNoticePagingInfo.pageNo = 1;
        }

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }
        var data = {
            'pageNo': broadNoticePagingInfo.pageNo
            , 'pageCnt' : broadNoticePagingInfo.pageCnt
            , 'mem_no' : txt_search
            , 'sDate' : $("#startDate").val()
            , 'eDate' : $("#endDate").val()
            , 'searchType' : 1
            , 'status' : $("#boardRoomStatus option:selected").val()
        };

        util.getAjaxData("noticeList", "/rest/content/boardAdm/noticeList", data, fn_success_broadNoticeList);
    }

    function fn_success_broadNoticeList(dst_id, response, param) {

        for(var i=0 ; i<response.data.length;i++){
            response.data[i].contents = response.data[i].contents.replace(/\\n/gi,"<br/>");
        }

        var template = $('#tmp_broadNoticeTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#tb_broadNoticeList').html(html);

        broadNoticePagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('broadNotice_paginate_top', broadNoticePagingInfo);
        util.renderPagingNavigation('broadNotice_paginate', broadNoticePagingInfo);

        if(response.data.length == 0) {
            $("broadNoticeList").find("#broadNotice_paginate_top").hide();
            $("broadNoticeList").find('#broadNotice_paginate').hide();
        } else {
            $("broadNoticeList").find("#broadNotice_paginate_top").show();
            $("broadNoticeList").find('#broadNotice_paginate').show();
        }

        util.getAjaxData("noticeListSummary", "/rest/content/boardAdm/noticeList/summary", param, fn_success_broadNoticeSummary);
    }

    function fn_success_broadNoticeSummary(dst_id, response) {
        $("#tab_broadNoticeList").text("회원공지" + "(" + response.data.totalCnt +")");
        $("#broadNoticeListCnt").html(
            '<span style="color:black">[검색결과 : ' +  response.data.totalCnt + ' 건]</span>' +
            '<span style="color: blue;"> [남' + response.data.maleCnt + " 건]</span>" + "," +
            '<span style="color: red;"> [여' + response.data.femaleCnt + " 건]</span>" + "," +
            '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + " 건]</span>"
        );
    }

    $(document).on('click', '._broadNoticeDelBtn', function() {
        console.log($(this).data('status'));
        if($(this).data('status') == 1) {
            alert('이미 삭제된 댓글입니다.');
        } else if(confirm("삭제하시겠습니까?")) {
            var data = {
                noticeIdx: $(this).data('broadnoticeidx'),
                noticeType: $(this).data('type')
            };

            util.getAjaxData("delete", "/rest/member/notice/delete", data, function (dst_id, response){
                alert(response.message);
                broadNoticeList(broadNoticePagingInfo.pageNo);
            });
        }else return;
    });


    $('#boardRoomStatus').on('change', function () {
        broadNoticeList();
    });

    $(document).on('click', '._noticeReply', function() {
        var me = $(this);
        if(me.data('replycnt') == 0) {
            alert('해당 공지사항의 댓글이 없습니다.');
        } else if (me.data('replycnt') >  0) {
            var data = {
                idx : me.data('idx')
                , memNo : me.data('memno')
            }
            util.getAjaxData("selectNoticeReply", "/rest/content/boardAdm/selectNoticeReply", data, fn_success_selectNoticeReply);
        }
    });

    function fn_success_selectNoticeReply(dst_id, response) {
        $('#div_notice').empty();
        $('#div_noticeReply').empty();
        for(var i=0; i<response.data.length; i++) {
            var tmp = '<div class="col-md-12 no-padding" style="margin-bottom: 10px;">';
            tmp += '<div class="col-md-2">';
            tmp +=      '<form id="profileImg' + i + '" method="post" enctype="multipart/form-data">';
            tmp +=          '<img class="pull-right" id="image_section' + i + '" src="" alt="your image" style="width: 60px;height: 60px"/>';
            tmp +=      '</form>';
            tmp +=     '</div>';
            tmp +=     '<div class="col-md-10">';
            tmp +=      '<label id="nickName' + i + '"></label>';
            tmp +=      ' <label id="userId' + i + '" style="color: #6e696e"></label> - <label id="writeDateFormat' + i + '"></label> <br/>';
            tmp +=      '<lable id="contents' + i + '"></label><br>';
            tmp +=     '</div>';
            tmp +=     '</div>';
            if(response.data[i].depthType == "0"){          // notice
                $('#div_notice').append(tmp + "<br/>");
            }else{                                      // notice reply
                $('#div_noticeReply').append(tmp);
                $('#image_section' + i).attr('style', "width: 40px;height: 40px");
            }
            $('#nickName' + i).text(response.data[i].memNick);
            $('#userId' + i).text(response.data[i].memUserId);
            $('#writeDateFormat' + i).text(response.data[i].writeDateFormat);
            $('#contents' + i).text(common.replaceHtml(response.data[i].contents));
            $('#image_section' + i).prop("src" ,common.profileImage(PHOTO_SERVER_URL,response.data[i].profileImage,memSex));

            $('#NoticeModal').modal("show");
        }
    }

    $(document).on('change', '#dynamicPageCntBroadNotice', function () {
        broadNoticePagingInfo.pageCnt = $(this).val();
        broadNoticeList();
    });

    $(document).on('click', '#allChkBroadNotice', function(){
        var me = $(this);
        var checkboxs = $('._broadNotice_chk:not(.disabled)');
        if(me.prop('checked')){
            checkboxs.prop('checked', true);
        }else{
            checkboxs.prop('checked', false);
        }
    });

    $(document).on('click', '#deleteBroadNoticeBtn', function(){
        var checkboxs = $('._broadNotice_chk:checked');
        if(checkboxs.length < 1){
            alert('삭제할 회원공지를 선택해주세요.');
            return false;
        }

        if(confirm(checkboxs.length + '건을 삭제 하시겠습니까?')){

            var noticeIdxs = '';
            var noticeTypes = '';
            checkboxs.each(function(){
                var noticeIdx = $(this).data('broadnoticeidx');
                var noticeType = $(this).data('type');

                noticeIdxs += noticeIdx + ',';
                noticeTypes += noticeType + ',';
            });
            var data = {
                noticeIdxs : noticeIdxs
                , noticeTypes : noticeTypes
            }

            util.getAjaxData('multiOperate', '/rest/member/notice/multi/delete', data, function(dist_id, response){
                alert(response.message);
                broadNoticeList(broadNoticePagingInfo.pageNo);
            });
        }
    });
</script>

<script id="tmp_broadNoticeTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr {{#dalbit_if inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
            <td><input type="checkbox" class="form-control _broadNotice_chk {{#dalbit_if data.status '!=' 0}}disabled{{/dalbit_if}}" {{#dalbit_if data.status '!=' 0}}disabled{{/dalbit_if}} data-broadnoticeidx="{{idx}}" data-type="{{type}}" /></td>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td>
                {{{memNoLink mem_no mem_no}}}<br/>
                {{mem_nick}}
            </td>
            <td>
                {{{sexIcon mem_sex mem_birth_year}}}
            </td>
            <td class="word-break" style="width: 400px"><span class="pull-left">{{{replaceHtml contents}}}</span></td>
            <td>
                {{#equal image_path ''}}
                {{else}}
                <img class="thumbnail fullSize_background" alt="your image" src="{{renderImage ../image_path}}" style='height:68px; width:68px; margin: auto;' />
                {{/equal}}
            </td>
            <td>{{lastUpdDateFormat}}</td>
            <td>
                {{#dalbit_if status '==' 0}}
                    정상
                {{else}}
                    삭제 ({{op_name}})
                {{/dalbit_if}}
            </td>
            <td>
                {{addComma replyCnt}}
                <a href="javascript://" class="_noticeReply" data-idx="{{idx}}" data-replycnt="{{replyCnt}}" data-memno="{{mem_no}}">[댓글]</a>
            </td>
            <td><a href="javascript://" class="_broadNoticeDelBtn" data-broadnoticeidx="{{idx}}" data-type="{{type}}" data-status="{{status}}">[삭제]</a></td>
        </tr>
    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>
