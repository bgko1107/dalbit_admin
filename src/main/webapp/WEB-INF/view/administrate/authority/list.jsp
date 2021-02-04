<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
                <input type="hidden" name="empNo" id="empNo" />

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
                                    <select name="posType" class="form-control searchType">
                                        <option value="">직급선택</option>
                                        <c:forEach var="posCode" items="${cfn:getInforexPosCode()}" varStatus="status">
                                            <option value="${posCode.pos_code}">${posCode.pos_name}</option>
                                        </c:forEach>
                                    </select>

                                    <select name="deptType" class="form-control searchType">
                                        <option value="">부서선택</option>
                                        <c:forEach var="deptCode" items="${cfn:getInforexDeptCode()}" varStatus="status">
                                            <option value="${deptCode.dept_no}">${deptCode.new_dept_name}</option>
                                        </c:forEach>
                                    </select>

                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i> 검색결과</h3>
                    </div>
                    <div class="widget-content mt10">
                        <table class="table table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>No.</th>
                                    <th>입사일</th>
                                    <th>부서/팀명</th>
                                    <th>직급/직책</th>
                                    <th>이름</th>
                                    <th style="color: #6f49d1">테스트ID</th>
                                    <th>핸드폰</th>
                                    <th>회사메일</th>
                                    <th>개인메일</th>
                                    <th>네이트ID</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody"></tbody>
                        </table>
                    </div>
                    <div class="widget-footer" style="display: none;">
                        <span>
                            <button type="button" id="authority_view" class="btn btn-danger print-btn pull-right mb10">권한부여하기</button>
                        </span>
                    </div>
                </div>
            </div>
            <!-- #DataTable -->
            <div class="row col-lg-12 form-inline mt15" id="authArea" style="display:none;">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i> 권한부여</h3>
                    </div>
                    <div class="widget-content mt10">

                        <div class="pull-right mb10">
                            <button type="button" id="allSelect" class="btn btn-info">모두선택</button>
                            <button type="button" id="allSelectCancel" class="btn btn-info">모두해제</button>
                        </div>

                        <table class="table table-hover table-bordered">
                            <thead>
                            <tr>
                                <th>Depth 1</th>
                                <th>Depth 2</th>
                                <th>[확인]/[등록/수정]/[삭제]</th>
                                <th>[확인]</th>
                                <th>[등록/수정]</th>
                                <th>[삭제]</th>
                            </tr>
                            </thead>
                            <tbody id="menuInfo"></tbody>
                        </table>
                    </div>
                    <div class="widget-footer">
                        <span>
                            <button type="button" id="authority_btn" class="btn btn-success print-btn pull-right mb10">권한부여</button>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/lib/jquery.table2excel.js"></script>
<script type="text/javascript" src="/js/code/administrate/adminCodeList.js?${dummyData}"></script>

<script type="text/javascript">
    $(document).ready(function() {
        getMemberList();
    });

    $(document).on('click', '._authChk, ._auth', function(){
        var me = $(this);
        if(me.prop('checked')){

            var oneIdx = me.parent().parent().data('oneidx');
            var twoIdx = me.parent().parent().data('twoidx');
            var checkedIndex = me.parent().parent().find('input[type="checkbox"]').index(me);

            //2뎁스 일 때만 1뎁스 체크 여부 확인.
            //1뎁스가 체크가 안되었을 때 체크를 해준다.
            if(!common.isEmpty(twoIdx)){
                var oneDepthCheckbox = $('tr[data-oneidx="'+oneIdx+'"]:first').find('input[type="checkbox"]:eq('+checkedIndex+')');

                if(me.hasClass('_authChk')){
                    $('tr[data-oneidx="'+oneIdx+'"]:first').find('input[type="checkbox"]').prop('checked', 'checked');
                }else{
                    oneDepthCheckbox.prop('checked', 'checked');
                }
            }
        }
    });

    $('#searchText').on('keydown', function(e) {
        if (e.keyCode === 13) {
            getMemberList();
        };
    });

    $('#bt_search').on('click', function(){
        getMemberList();
    });

    $('#all_chk').on('click', function(){
        if($(this).prop('checked')){
            $('._chk').prop('checked', true);
        }else{
            $('._chk').prop('checked', false);
        }

    });

    $('#allSelect').on('click', function(){
        $('#menuInfo').find('input[type="checkbox"]').prop('checked', 'checked');
    });

    $('#allSelectCancel').on('click', function(){
        $('#menuInfo').find('input[type="checkbox"]').removeAttr('checked');
    });

    function getMemberList(){
        $("#authArea").hide();
        util.getAjaxData("memberList", "/rest/administrate/authority/list", $("#searchForm").serialize(), fn_memberList_success);
    }

    function fn_memberList_success(data, response, params){

        for(var i=0;i<response.data.length;i++){
            response.data[i].url = "/member/member/popup/memberTestid?name=" + encodeURIComponent(response.data[i].emp_no);
        }

        var template = $('#tmp_memberList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#tableBody").html(html);

    }

    $('#authority_view').on('click', function(){
        if(0 < $('._chk:checked').length){
            $("#searchForm > #empNo").val($('._chk:checked').data('empno'));
            util.getAjaxData("memberList", "/rest/administrate/authority/info", $("#searchForm").serialize(), fn_menuInfo_success);
        }else{
            alert('권한부여 할 임직원을 선택해주세요.');
        }

    });

    function fn_menuInfo_success(data, response, params){
        for(var i = 0 ;i<response.data.menuInfo.length;i++){
            if(response.data.menuInfo[i].idx == 12){
                for(var j = 0 ;j<response.data.menuInfo[i].twoDepth.length;j++){
                    if(response.data.menuInfo[i].twoDepth[j].idx == 52) {
                        response.data.menuInfo[i].twoDepth[j]["menu_name"] = response.data.menuInfo[i].twoDepth[j].menu_name;
                    }
                }
            }
        }
        var template = $('#tmp_menuList').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#menuInfo").html(html);

        var menus = $("#menuInfo tr");
        response.data.authInfo.forEach(function(auth){
            menus.each(function(){
                menu = $(this);
                if(common.isEmpty(menu.data('twoidx'))){
                    if($(this).data('oneidx') == auth.idx){

                        if(1 == auth.is_read){
                            menu.find('._read').prop('checked', 'checked');
                        }
                        if(1 == auth.is_insert){
                            menu.find('._insert').prop('checked', 'checked');
                        }
                        if(1 == auth.is_delete){
                            menu.find('._delete').prop('checked', 'checked');
                        }
                    }
                }else {
                    if($(this).data('twoidx') == auth.idx){
                        if(1 == auth.is_read){
                            menu.find('._read').prop('checked', 'checked');
                        }
                        if(1 == auth.is_insert){
                            menu.find('._insert').prop('checked', 'checked');
                        }
                        if(1 == auth.is_delete){
                            menu.find('._delete').prop('checked', 'checked');
                        }
                    }
                }
            });
        });

        menus.each(function(){
            var menu = $(this);
            // console.log(menu.find('input[type="checkbox"]:checked').length);
            if(3 == menu.find('input[type="checkbox"]:checked').length){
                menu.find('._authChk').prop('checked', 'checked');
            }
        });

        $("#authArea").show();
        var scrollPosition = $("#authArea").offset();
        $('html').animate({scrollTop: scrollPosition.top}, 100);
    }

    $(document).on('click', '._memberTableRow', function(){
       $(this).find('input[type="radio"]').prop('checked', 'checked');
       $("#authority_view").click();
    });

    $(document).on('click', '._authChk', function(){
        var me = $(this);

        var checkType = me.data('type');
        var oneDepth = me.parent().parent();
        var oneDepthIdx = oneDepth.data('oneidx');

        if(checkType == 'all'){
            var check_selector = $('#menuInfo tr[data-oneidx="'+ oneDepthIdx +'"] td input[type="checkbox"]');

        }else if(checkType == 'row'){
            var check_selector = oneDepth.find('input[type="checkbox"]');

        }else if(checkType == 'readAll'){
            var check_selector = $('#menuInfo tr[data-oneidx="'+ oneDepthIdx +'"] td input[type="checkbox"]._read');

        }else if(checkType == 'readAll'){
            var check_selector = $('#menuInfo tr[data-oneidx="'+ oneDepthIdx +'"] td input[type="checkbox"]._read');

        }else if(checkType == 'insertAll'){
            var check_selector = $('#menuInfo tr[data-oneidx="'+ oneDepthIdx +'"] td input[type="checkbox"]._insert');

        }else if(checkType == 'deleteAll'){
            var check_selector = $('#menuInfo tr[data-oneidx="'+ oneDepthIdx +'"] td input[type="checkbox"]._delete');

        }

        if($(this).prop('checked')){
            check_selector.prop('checked', 'checked');
        }else{
            check_selector.removeAttr('checked');
        }
    });

    var MENU_AUTH = function(menu_idx, is_read, is_insert, is_delete){
        this.menu_idx = menu_idx;
        this.is_read = is_read;
        this.is_insert = is_insert;
        this.is_delete = is_delete;
    }

    $('#authority_btn').on('click', function(){
        if(confirm('권한을 부여하시겠습니까?')){
            var checked = $("#menuInfo tr").find('._auth:checked');

            var empNoArr = [];
            $('#tableBody ._chk:checked').each(function(i){
                empNoArr[i] = $(this).data('empno');
            });
            if(0 == empNoArr.length){
                alert('임직원을 선택해주세요.');
                return false;
            }

            var menuAuthArr = [];
            checked.parent().parent().each(function(i){
                var menuIdx = common.isEmpty($(this).data('twoidx')) ? $(this).data('oneidx') : $(this).data('twoidx');
                var isRead = $(this).find('._read:checked').length;
                var isInsert = $(this).find('._insert:checked').length;
                var isDelete = $(this).find('._delete:checked').length;
                menuAuthArr[i] = new MENU_AUTH(menuIdx, isRead, isInsert, isDelete)
            });
            if(0 == menuAuthArr.length){
                alert('메뉴를 선택해주세요.');
                return false;
            }

            var data = {
                menuAuthArr : JSON.stringify(menuAuthArr)
                , empNoArr : JSON.stringify(empNoArr)
            }

            util.getAjaxData("memberList", "/rest/administrate/authority/setAuth", data, fn_setAuth_success);
        }
    });

    function fn_setAuth_success(data, response, params){
        alert(response.message);
        getMemberList();
        ui.topScroll();
    }
</script>

<script id="tmp_memberList" type="text/x-handlebars-template">
    {{#each this as |member|}}

    {{#equal authCnt '0'}}
        <tr style='cursor: pointer;color: blue;' class="_memberTableRow">
    {{else}}
        <tr style='cursor: pointer;' class="_memberTableRow">
    {{/equal}}

            <td><input type="radio" name="empNo" id="empRadio_{{emp_no}}" class="_chk" data-empno={{emp_no}}></td>
            <td>{{index @index no}}</td>
            <td>{{staff_enter_date}}</td>
            <td>{{new_dept_name}}</td>
            <td>
                {{#equal staff_pos_name staff_duty_name}}
                    {{member.staff_pos_name}}
                {{else}}
                    {{member.staff_pos_name}}/{{member.staff_duty_name}}
                {{/equal}}
            </td>
            <td>{{staff_name}}</td>
            <td style="color: #6f49d1">
                <a href="javascript://" class="_openPop" data-url="{{url}}" data-width="1400" data-height="700">{{testIdCnt}}</a>
            </td>
            <td>{{staff_hphone}}</td>
            <td>{{staff_email}}@inforex.co.kr</td>
            <td>{{staff_email_etc}}</td>
            <td>
                {{#equal staff_email_nate ''}}
                    -
                {{else}}
                    {{member.staff_email_nate}}
                {{/equal}}
            </td>
        </tr>
    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>

<script id="tmp_menuList" type="text/x-handlebars-template">
    {{#each menuInfo as |menu|}}
        <tr data-oneidx='{{menu.idx}}' class="font-bold">
            <td rowspan="{{index menu.twoDepth.length}}">{{menu.menu_name}}</td>
            <td></td>
            <td><input type="checkbox" class="_authChk" data-type='all' /></td>
            <td><input type="checkbox" class="_authChk _read _auth" data-type='readAll' /></td>
            <td><input type="checkbox" class="_authChk _insert _auth" data-type='insertAll' /></td>
            <td><input type="checkbox" class="_authChk _delete _auth" data-type='deleteAll' /></td>
        </tr>
        {{#each menu.twoDepth as |two|}}
            <tr data-oneidx='{{two.parent_idx}}' data-twoidx='{{two.idx}}'>
                <td>{{{two.menu_name}}}</td>
                <td><input type="checkbox" class="_authChk" data-type='row' /></td>
                <td><input type="checkbox" name="read" class="_read _auth" /></td>
                <td><input type="checkbox" name="insert" class="_insert _auth" /></td>
                <td><input type="checkbox" name="delete" class="_delete _auth" /></td>
            </tr>
        {{/each}}

    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>