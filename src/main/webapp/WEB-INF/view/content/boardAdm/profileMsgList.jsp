<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- table -->
<div class="col-lg-12 no-padding">
    <div class="widget-content">
        <div class="col-md-12 no-padding mt10">
            <div class="col-md-10 no-padding">
                <div id="profileMsgListCnt"></div>
                <span id="dynamicPageProfileMsgArea"></span>
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
        <div class="dataTables_paginate paging_full_numbers" id="profile_paginate_top"></div>
        <table id="noticeTable" class="table table-sorting table-hover table-bordered mt10">
            <colgroup>
                <col width="5%"/>
                <col width="5%"/>
                <col width="8%"/>
                <col width="10%"/>
                <col width="5%"/>
                <col width="50%"/>
                <col width="10%"/>
                <col width="5%"/>
                <col width="5%"/>
            </colgroup>
            <thead>
                <tr>
                    <th><input type="checkbox" class="form-control" id="allChkProfileMsg" /></th>
                    <th>No</th>
                    <th>프로필이미지</th>
                    <th>등록자</th>
                    <th>성별</th>
                    <th>프로필 메시지 내용</th>
                    <th>최근접속일시</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody id="tb_profileList">
            </tbody>
        </table>
        <div class="dataTables_paginate paging_full_numbers" id="profile_paginate"></div>
    </div>
    <div class="widget-footer">
        <span>
            <button class="btn btn-danger btn-sm print-btn" type="button" id="deleteProfileMsgBtn"><i class="fa fa-check"></i>선택 삭제</button>
        </span>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var profilePagingInfo = new PAGING_INFO(0,1,$("#dynamicPageCntProfileMsg").val());

    $(document).ready(function() {
        $("#dynamicPageProfileMsgArea").html(util.renderDynamicPageCntSelect('dynamicPageCntProfileMsg'));
    });

    var memNo;
    function profileMsgList(pagingNo, _tabId) {
        if(!common.isEmpty(_tabId)){
            tabId = _tabId;
        }

        $('#title').html('프로필 메시지');
        if(!common.isEmpty(pagingNo)){
            profilePagingInfo.pageNo = pagingNo;
        }else{
            profilePagingInfo.pageNo = 1;
        }

        if(!common.isEmpty(memNo) && memNo != null){
            txt_search = memNo;
        }else{
            txt_search = $('#txt_search').val();
        }

        var data = {
            'pageStart': profilePagingInfo.pageNo
            , 'pageCnt' : profilePagingInfo.pageCnt
            , 'searchText' : txt_search
            , 'sDate' : $("#startDate").val()
            , 'eDate' : $("#endDate").val()
            , 'searchType' : 0
            , 'newSearchType' : $("#searchMember").val()
        };

        util.getAjaxData("profileMsgList", "/rest/content/boardAdm/profileMsgList", data, fn_success_profileMsgList);
    }

    function fn_success_profileMsgList(dst_id, response, param) {

        var template = $('#tmp_profileMsgTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#tb_profileList').html(html);

        profilePagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('profile_paginate_top', profilePagingInfo);
        util.renderPagingNavigation('profile_paginate', profilePagingInfo);

        util.getAjaxData("profileMsgSummary", "/rest/content/boardAdm/profileMsg/summary", param, fn_success_profileMsgSummary);
    }
    function fn_success_profileMsgSummary(dst_id, response) {
        $("#tab_profileMsgList").text("프로필 메시지" + "(" + response.data.totalCnt +")");
        $("#profileMsgListCnt").html(
            '<span style="color:black">[검색결과 : ' +  response.data.totalCnt + ' 건]</span>' +
            '<span style="color: blue;"> [남' + response.data.maleCnt + " 건]</span>" + "," +
            '<span style="color: red;"> [여' + response.data.femaleCnt + " 건]</span>" + "," +
            '<span style="color: #555555;"> [알수없음' + response.data.noneCnt + " 건]</span>"
        );
    }

    $(document).on('click', '._profileMsgDelBtn', function() {
        if(confirm("프로필 메시지를 삭제하시겠습니까?")) {
            var data = {
                mem_no: $(this).data('memno')
            };

            util.getAjaxData("delete", "/rest/content/boardAdm/profileMsg/del", data, function(dst_id, response){
                alert(response.message);
                profileMsgList(profilePagingInfo.pageNo);
            });
        }else return;
    });

    $(document).on('click', '._profileEditList', function() {
        var mem_no = $(this).data('memno');
        var url = "/content/boardAdm/popup/editList?type=2&mem_no=" + mem_no;
        util.windowOpen(url,"1200","450","");
    });

    $(document).on('change', '#dynamicPageCntProfileMsg', function () {
        profilePagingInfo.pageCnt = $(this).val();
        profileMsgList();
    });

    $(document).on('click', '#allChkProfileMsg', function(){
        var me = $(this);
        var checkboxs = $('._profileMsg_chk:not(.disabled)');
        if(me.prop('checked')){
            checkboxs.prop('checked', true);
        }else{
            checkboxs.prop('checked', false);
        }
    });

    $(document).on('click', '#deleteProfileMsgBtn', function(){
        var checkboxs = $('._profileMsg_chk:checked');
        if(checkboxs.length < 1){
            alert('삭제할 회원 프로필을 선택해주세요.');
            return false;
        }

        if(confirm(checkboxs.length + '건을 삭제 하시겠습니까?')){

            var mem_nos = '';
            checkboxs.each(function(){
                var mem_no = $(this).data('memno');

                mem_nos += mem_no + ',';
            });
            var data = {
                mem_nos : mem_nos
            }

            util.getAjaxData('multiOperate', '/rest/content/boardAdm/profileMsg/multi/del', data, function(dist_id, response){
                alert(response.message);
                profileMsgList(profilePagingInfo.pageNo);
            });
        }
    });
</script>

<script id="tmp_profileMsgTable" type="text/x-handlebars-template">
    {{#each this.data as |data|}}
        <tr {{#dalbit_if inner '==' 1}} style="background-color : #dae3f3" {{/dalbit_if}}>
            <td><input type="checkbox" class="form-control _profileMsg_chk" data-memno="{{data.mem_no}}" /></td>
            <td>{{indexDesc ../pagingVo/totalCnt rowNum}}</td>
            <td><img class="thumbnail fullSize_background" alt="your image" src="{{renderProfileImage image_profile mem_sex}}" style='height:68px; width:68px; margin: auto;' /></td>
            <td>
                {{{memNoLink mem_no mem_no}}}<br/>
                {{mem_nick}}
            </td>
            <td>
                {{{sexIcon mem_sex mem_birth_year}}}
            </td>
            <td>{{{replaceEnter msg_profile}}}</td>
            <td>{{last_upd_date}}</td>
            <td><a href="javascript://" class="_profileEditList" data-memno="{{mem_no}}">{{addComma editCnt}}</a></td>
            <td><a href="javascript://" class="_profileMsgDelBtn" data-memno="{{mem_no}}">[삭제]</a></td>
        </tr>
    {{else}}
        <tr>
            <td colspan="9">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>
