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
<div class="no-padding col-lg-12 form-inline">
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active">
            <div class="widget-content">
                <div class="col-md-12 no-padding mt10">
                    <div class="col-md-6 no-padding">
                        <span id="fanboardListCnt"></span><br/>
                        <span style="color: red">* 팬보드 작성 글 수(비밀글 수)를 표기한 정보입니다.</span><br/>

                        <select id="fanBoardOwner" name="fanBoardOwner" class="form-control searchType">
                            <option value="0" selected="selected">팬보드주인(전체)</option>
                            <option value="1">주인</option>
                            <option value="2">등록자</option>
                        </select>

                        <select id="fanBoardStatus" name="fanBoardStatus" class="form-control searchType">
                            <option value="0" selected="selected">게시글(전체)</option>
                            <option value="1">정상</option>
                            <option value="2">삭제</option>
                        </select>

                        <select id="isSecret" name="isSecret" class="form-control searchType">
                            <option value="0" selected="selected">비밀글 여부(전체)</option>
                            <option value="1">비밀 X</option>
                            <option value="2">비밀 O</option>
                        </select>

                        <select id="isWithdarwal" name="isWithdarwal" class="form-control searchType">
                            <option value="0" selected="selected">회원/탈퇴(전체)</option>
                            <option value="1">회원</option>
                            <option value="2">탈퇴</option>
                        </select>

                        <select id="isMemblock" name="isMemblock" class="form-control searchType">
                            <option value="0" selected="selected">차단회원(전체)</option>
                            <option value="1">차단 X</option>
                            <option value="2">차단 O</option>
                        </select>


                        <span id="dynamicPageAreaFanboard"></span>

                        <%--<label class="control-inline fancy-checkbox custom-color-green ml15 mt5">
                            <input type="checkbox" name="isSecret" id="isSecret" value="1">
                            <span>비밀글 모아보기</span>
                        </label>
                        <label class="control-inline fancy-checkbox custom-color-green ml15 mt5">
                            <input type="checkbox" name="isWithdarwal" id="isWithdarwal" value="1">
                            <span>탈퇴회원 모아보기</span>
                        </label>--%>
                    </div>
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
                <%--<div class="col-md-6 no-padding mt10">--%>
                    <%--<span id="searchType_board" onchange="fanBoardList();"></span>--%>
                <%--</div>--%>
                <div class="col-md-6 no-padding mt10" >
                    <span id="fanBoardTable_summary"></span>
                </div>
                <div class="col-md-12 no-padding">
                    <div class="dataTables_paginate paging_full_numbers" id="fanBoard_paginate_top"></div>
                    <div id="fanBoardTable"></div>
                    <div class="dataTables_paginate paging_full_numbers" id="fanBoard_paginate"></div>
                </div>
            </div>

            <div class="widget-footer">
                <span>
                    <button class="btn btn-danger btn-sm print-btn" type="button" id="deleteFanboardBtn"><i class="fa fa-check"></i>선택 삭제</button>
                </span>
            </div>
        </div>
    </div>
</div>
<!-- //table -->
<!-- 팬보드 댓글 보기 -->
<div class="modal fade" id="fanboardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px;display: table;">
        <div class="modal-content">
            <div class="modal-header no-padding">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="col-md-12 no-padding" id="div_fanboard" style="margin-bottom: 7px"></div><br/>
                <div class="col-md-12 no-padding" id="div_fanboardReply"></div>
            </div>
        </div>
    </div>
</div>
<!-- Modal 끝 -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/member/memberCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var fanBoardPagingInfo = new PAGING_INFO(0, 1, $("#dynamicPageCntFanboard").val());

    $(function() {
        $("#dynamicPageAreaFanboard").html(util.renderDynamicPageCntSelect('dynamicPageCntFanboard'));
    });

    function fanBoardList(pagingNo, _tabId) {
        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        $('#title').html('팬보드검색');
        if(!common.isEmpty(pagingNo)){
            fanBoardPagingInfo.pageNo = pagingNo;
        }else{
            fanBoardPagingInfo.pageNo = 1;
        }

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }
        var data = {
            'pageStart' : fanBoardPagingInfo.pageNo
            , 'pageCnt' : fanBoardPagingInfo.pageCnt
            , 'txt_search' : txt_search
            , 'start_sel' : $("#startDate").val()
            , 'end_sel' : $("#endDate").val()
            , 'searchType' : 0
            , 'boardType' : 1
            , 'status' : Number($("#fanBoardStatus option:selected").val())
            // , 'isSecret' : $('input:checkbox[name="isSecret"]').prop('checked') ? 0 : 1
            // , 'isWithdarwal' : $('input:checkbox[name="isWithdarwal"]').prop('checked') ? 1 : 0
            , 'isSecret' : Number($("#isSecret option:selected").val())
            , 'isWithdarwal' : Number($("#isWithdarwal option:selected").val())
            , 'fanBoardOwner' : Number($("#fanBoardOwner option:selected").val())
            , 'isMemblock' : Number($("#isMemblock option:selected").val())
            , 'newSearchType' : $("#searchMember").val()
        };

        console.log(data);

        util.getAjaxData("fanBoardList", "/rest/content/boardAdm/fanBoardList", data, fn_success_fanBoardList);
    }

    function fn_success_fanBoardList(dst_id, response, param) {

        var template = $('#tmp_fanBoardTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#fanBoardTable').html(html);

        fanBoardPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('fanBoard_paginate_top', fanBoardPagingInfo);
        util.renderPagingNavigation('fanBoard_paginate', fanBoardPagingInfo);
        //fanBoardPagingInfo.pageNo=1;

        if(response.data.length == 0) {
            $("#fanBoard_paginate_top").hide();
            $('#fanBoard_paginate').hide();
        } else {
            $("#fanBoard_paginate_top").show();
            $('#fanBoard_paginate').show();
        }

        util.getAjaxData("fanBoardListSummary", "/rest/content/boardAdm/fanBoardList/summary", param, fn_success_fanBoardSummary);
    }
    function fn_success_fanBoardSummary(dst_id, response) {
        $("#tab_fanBoardList").text("팬보드" + "(" + response.data.totalCnt +")");



        $("#fanboardListCnt").html(
            '<span style="color:black">[검색결과 : ' +  response.data.totalCnt + '(' + response.data.secretTotalCnt + ') 건]</span>' +
            '<span style="color: blue;"> [남' + response.data.maleCnt + '(' + response.data.secretMaleCnt + ') 건]</span>' + "," +
            '<span style="color: red;"> [여' + response.data.femaleCnt + '(' + response.data.secretFemaleCnt + ') 건]</span>' + "," +
            '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + '(' + response.data.secretNoneCnt + ') 건]</span>'
        );


        // var template = $('#fanboard_tableSummary').html();
        // var templateScript = Handlebars.compile(template);
        // var context = response.data;
        // var html = templateScript(context);
        //
        // $('#fanBoardTable_summary').html(html);
    }

    $(document).on('click', '._selectFanReply', function() {
        // if($(this).data('status') == 2) {
        //     alert('삭제된 댓글입니다');
        // } else
        if($(this).data('reply') == 0) {
            alert('해당 팬보드의 댓글이 없습니다.');
        } else if($(this).data('reply') > 0) {
            var data = {
              'mem_no' : $(this).data('mem_no')
              , 'board_no' : $(this).data('board_no')
            };
            util.getAjaxData("selectReply", "/rest/content/boardAdm/selectReply", data, fn_success_selectFanReply);
        }
    });

    function fn_success_selectFanReply(dst_id, response) {
        $('#div_fanboardReply').empty();
        $('#div_fanboard').empty();
        for(var i=0 ; i<response.data.length; i++){
            var tmp = '<div class="col-md-12 no-padding" style="margin-bottom: 10px;">';
            tmp +=    '<div class="col-md-2">';
            tmp +=      '<form id="profileImg' + i + '" method="post" enctype="multipart/form-data">';
            tmp +=          '<img class="pull-right" id="image_section' + i + '" src="" alt="your image" style="width: 60px;height: 60px"/>';
            tmp +=      '</form>';
            tmp +=     '</div>';
            tmp +=     '<div class="col-md-10">';
            tmp +=      '<label id="nickName' + i + '"></label>';
            if(response.data[i].view_yn == "0"){
                tmp +=      '<i class="fa fa-lock" style="padding-left: 3px;padding-right: 3px"></i>';
            }
            tmp +=      '<label id="userId' + i + '" style="color: #6e696e"></label> - <label id="writeDateFormat' + i + '"></label> <br/>';
            tmp +=      '<lable id="contents' + i + '"></label><br>';
            tmp +=     '</div>';
            tmp +=     '</div>';

            if(response.data[i].depth == "1"){          // fanboard
                $('#div_fanboard').append(tmp + "<br/>");
            }else{                                      // reply
                $('#div_fanboardReply').append(tmp + "<br/>");
                $('#image_section' + i).attr('style', "width: 40px;height: 40px");
            }

            $('#nickName' + i).text(response.data[i].nickName);
            $('#userId' + i).text(response.data[i].userId);
            $('#writeDateFormat' + i).text(response.data[i].writeDateFormat);
            $('#contents' + i).text(response.data[i].contents);
            $('#image_section' + i).prop("src" ,common.profileImage(PHOTO_SERVER_URL,response.data[i].profileImage,memSex));

            console.log( $('#div_fanboard').html());
            console.log( $('#div_fanboardReply').html());
            $('#fanboardModal').modal("show");
        }
    }

    $(document).on('click', '._deleteFanBoard', function() {
        if($(this).data('status') == 2) {
            alert('이미 삭제된 댓글입니다.');
        } else if(confirm("삭제하시겠습니까?")){
            var data = {
                'idx' : $(this).data('idx')
            };

            util.getAjaxData("deleteFanBoard", "/rest/member/fanboard/delete", data, function(dist_id, response){
                alert(response.message);
                fanBoardList(fanBoardPagingInfo.pageNo);
            });
        }
        return false;
    });

    $('#fanBoardStatus').on('change', function () {
        fanBoardList();
    });
    $('#isSecret').on('change', function () {
        fanBoardList();
    });
    $('#isWithdarwal').on('change', function () {
        fanBoardList();
    });
    $('#fanBoardOwner').on('change', function () {
        fanBoardList();
    });
    $('#isMemblock').on('change', function () {
        fanBoardList();
    });
   /* $('#isSecret').on('change', function() {
       if($('input:checkbox[name="isSecret"]').prop('checked')) {
           $('#isSecret').val(0)
       } else {
           $('#isSecret').val(1)
       }
        fanBoardList();
    });
    $('#isWithdarwal').on('change', function() {
       if($('input:checkbox[name="isWithdarwal"]').prop('checked')) {
           $('#isWithdarwal').val(1)
       } else {
           $('#isWithdarwal').val(0)
       }
        fanBoardList();
    });*/

    $(document).on('change', '#dynamicPageCntFanboard', function () {
        fanBoardPagingInfo.pageCnt = $(this).val();
        fanBoardList();
    });

    $(document).on('click', '#allChkFanboard', function(){
        var me = $(this);
        var checkboxs = $('._fanboard_chk:not(.disabled)');
        if(me.prop('checked')){
            checkboxs.prop('checked', true);
        }else{
            checkboxs.prop('checked', false);
        }
    });

    $(document).on('click', '#deleteFanboardBtn', function(){
        var checkboxs = $('._fanboard_chk:checked');
        if(checkboxs.length < 1){
            alert('삭제할 팬보드를 선택해주세요.');
            return false;
        }

        if(confirm(checkboxs.length + '건을 삭제 하시겠습니까?')){

            var idxs = '';
            checkboxs.each(function(){
                var idx = $(this).data('idx');

                idxs += idx + ',';
            });
            var data = {
                idxs : idxs
            }

            util.getAjaxData('multiOperate', '/rest/member/fanboard/multi/delete', data, function(dist_id, response){
                alert(response.message);
                fanBoardList(fanBoardPagingInfo.pageNo);
            });
        }
    });
</script>

<script id="tmp_fanBoardTable" type="text/x-handlebars-template">
    <table id="tb_fanBoardList" class="table table-sorting table-hover table-bordered mt10">
        <colgroup>
            <col width="2%"/><col width="2%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
            <col width="5%"/><col width="34%"/><col width="8%"/><col width="4%"/><col width="4%"/>
        </colgroup>
        <thead>
        <tr>
            <th><input type="checkbox" class="form-control" id="allChkFanboard" /></th>
            <th>No</th>
            <th>팬보드주인</th>
            <th>성별</th>
            <th>팬보드글등록자</th>
            <th>성별</th>
            <th>비밀 글 여부</th>
            <th>팬보드등록글</th>
            <th>등록일시</th>
            <th>상태</th>
            <th>댓글수</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        {{#each this.data as |data|}}
            <tr {{#dalbit_if fan_inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
                <td><input type="checkbox" class="form-control _fanboard_chk {{#dalbit_if status '!=' 1}}disabled{{/dalbit_if}}" {{#dalbit_if status '!=' 1}}disabled{{/dalbit_if}} data-idx="{{data.idx}}" /></td>
                <td>{{indexDesc ../pagingVo.totalCnt rowNum}}</td>
                <td>
                    {{{memNoLink star_mem_no star_mem_no}}}<br/>
                    {{star_mem_nick}}
                    {{#dalbit_if star_withdrawalType '==' 'Y'}}
                        <br/><span style="color: RED;">(탈퇴)</span>
                    {{/dalbit_if}}
                </td>
                <td>
                    {{{sexIcon star_mem_sex star_birth_year}}}
                </td>
                <td>
                    {{{memNoLink fan_mem_no fan_mem_no}}}<br/>
                    {{fan_mem_nick}}
                    {{#dalbit_if fan_withdrawalType '==' 'Y'}}
                        <br/><span style="color: RED;">(탈퇴)</span>
                    {{/dalbit_if}}
                </td>
                <td>
                    {{{sexIcon fan_mem_sex fan_birth_year}}}
                </td>
                <td>
                    {{#dalbit_if view_yn '==' 0}} 비밀 글 {{/dalbit_if}}
                </td>
                <td>
                    <span class="pull-left">{{replaceHtml contents}}</span>
                </td>
                <td>{{convertToDate last_upd_date 'YYYY-MM-DD HH:mm:ss'}}</td>
                <td>
                    {{#dalbit_if status '==' 1}}
                        정상
                    {{else}}
                        삭제
                    {{/dalbit_if}}
                </td>
                <td>{{replyCnt}}<a href="javascript://" class="_selectFanReply" data-status="{{status}}" data-board_no="{{board_no}}" data-reply="{{replyCnt}}" data-mem_no="{{star_mem_no}}">[댓글]</a></td>
                <td><a href="javascript://" class="_deleteFanBoard" data-idx="{{idx}}" data-status="{{status}}">[삭제]</a></td>
            </tr>
        {{else}}
        <tr>
            <td colspan="12">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>
