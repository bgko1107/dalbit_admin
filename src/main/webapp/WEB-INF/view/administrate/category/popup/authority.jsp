<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div id="wrapper" class="pt10">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
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
                                <select name="deptType" id="deptType" class="form-control searchType">
                                    <option value="">부서선택</option>
                                    <c:forEach var="deptCode" items="${cfn:getInforexDeptCode()}" varStatus="status">
                                        <option value="${deptCode.dept_no}">${deptCode.new_dept_name}</option>
                                    </c:forEach>
                                </select>

                                <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색할 정보를 입력하세요"></label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i> 메뉴명 : <span id="menuNameArea" class="font-bold"></span></h3>

                        <span>
                            <button type="button" id="top_authority_btn" class="btn btn-danger print-btn pull-right mb10">권한부여하기</button>
                        </span>
                    </div>
                    <div class="widget-content mt10">

                        <button type="button" id="allChk" class="btn btn-default btn-sm print-btn mb10">전체선택</button>
                        <button type="button" id="allChk_content" class="btn btn-default btn-sm print-btn mb10 ml10">콘텐츠사업부 선택</button>
                        <table class="table table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>입사일</th>
                                    <th>부서/팀명</th>
                                    <th>직급/직책</th>
                                    <th>이름</th>
                                    <th>확인/등록/수정/삭제</th>
                                    <th>확인</th>
                                    <th>등록/수정</th>
                                    <th>삭제</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody"></tbody>
                        </table>
                    </div>
                    <div class="widget-footer" style="display: block;">
                        <span>
                            <button type="button" id="bottom_authority_btn" class="btn btn-danger print-btn pull-right mb10">권한부여하기</button>
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

    $(document).on('change', '#deptType', function(){
        var me = $(this);
        if(common.isEmpty(me.val())){
            $("#tableBody tr").removeClass('_dept_hide').addClass('_dept_show');
        }else{
            $("#tableBody tr").each(function(){
                var tr = $(this);
                console.log(tr.hasClass(me.val()));
                if(tr.hasClass(me.val())){
                    tr.removeClass('_dept_hide').addClass('_dept_show');
                }else{
                    tr.removeClass('_dept_show').addClass('_dept_hide');
                }
            });
        }

        doSearchFilter();
    });

    $(document).on('keyup', '#searchText', function(){
        console.log('keydown');
        var me = $(this);
        console.log(me.val());
        if(common.isEmpty(me.val())){
            $("#tableBody tr").removeClass('_name_hide').addClass('_name_show');
        }else{
            $("#tableBody tr").each(function(){
                var tr = $(this);
                if(tr.hasClass(me.val())){
                    tr.removeClass('_name_hide').addClass('_name_show');
                }else{
                    tr.removeClass('_name_show').addClass('_name_hide');
                }
            });
        }

        doSearchFilter();
    });

    function doSearchFilter(){
        $('._dept_show._name_show').show();
        $('._dept_hide, ._name_hide').hide();
    }

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
        util.getAjaxData("memberList", "/rest/administrate/authority/list", {}, function(dist_id, response, params){

            var template = $('#tmp_memberList').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html=templateScript(context);
            $("#tableBody").html(html);


            var data = {
                menuIdx : '${param.menuIdx}'
            }
            util.getAjaxData("authMenu", "/rest/administrate/authority/selectAuthMenu", data, function(_dist_id, _response, params){
                /*var template = $('#tmp_memberList').html();
                var templateScript = Handlebars.compile(template);
                var context = response.data;
                var html=templateScript(context);
                $("#tableBody").html(html);*/

                if(!common.isEmpty(_response.data)){
                    _response.data.menuAuthList.forEach(function(item, index){

                        if(index == 0){
                            $("#menuNameArea").html(item.menu_name);
                        }

                        $("#tableBody tr").each(function(){
                            var _me = $(this);
                            if(_me.hasClass('_empNo_'+item.emp_no)){

                                if(item.is_read == 1 && item.is_insert == 1 && item.is_delete == 1){
                                    _me.find('._authChk').prop('checked', true);
                                }

                                _me.find('._read').prop('checked', item.is_read == 1);
                                _me.find('._insert').prop('checked', item.is_insert == 1);
                                _me.find('._delete').prop('checked', item.is_delete == 1);
                            }
                        });
                    });
                }
            });

        });
    }

    $(document).on('click', '._memberTableRow', function(){
       $(this).find('input[type="radio"]').prop('checked', 'checked');
       $("#authority_view").click();
    });

    var MENU_AUTH = function(menu_idx, emp_no, is_read, is_insert, is_delete){
        this.menu_idx = menu_idx;
        this.emp_no = emp_no;
        this.is_read = is_read;
        this.is_insert = is_insert;
        this.is_delete = is_delete;
    }

    $(document).on('click', '._authChk', function(){
        var me = $(this);
        var auth_checks = me.closest('._memberTableRow').find('._auth');

        if(me.prop('checked')){
            auth_checks.prop('checked', 'checked');
        }else{
            auth_checks.removeAttr('checked');
        }
    });

    $(document).on('click', '#top_authority_btn, #bottom_authority_btn', function(){
        console.log('click');
        if(confirm('권한을 수정하시겠습니까?')){
            var menuAuthArr = [];
            $('#tableBody tr').each(function(i){

                var tr = $(this);
                if(0 < tr.find('._auth:checked').length){
                    var menuIdx = '${param.menuIdx}';
                    var empNo = tr.data('empno');
                    var isRead = tr.find('._read:checked').length;
                    var isInsert = tr.find('._insert:checked').length;
                    var isDelete = tr.find('._delete:checked').length;
                    menuAuthArr[menuAuthArr.length] = new MENU_AUTH(menuIdx, empNo, isRead, isInsert, isDelete);
                }
            });
            if(0 == menuAuthArr.length){
                alert('메뉴를 선택해주세요.');
                return false;
            }

            var data = {
                menuAuthArr : JSON.stringify(menuAuthArr)
            }

            console.log(data);

            util.getAjaxData("setMenu", "/rest/administrate/authority/setMenu", data, function(data, response, params){
                alert(response.message);
            });
        }
    });

    $(document).on('click', '#allChk', function(){
        $('#tableBody input[type="checkbox"]').prop('checked', 'checked');
    });

    $(document).on('click', '#allChk_content', function(){
        $('#tableBody tr').each(function(){
            if($(this).hasClass('4000') || $(this).hasClass('4001') || $(this).hasClass('4002') || $(this).hasClass('4003') || $(this).hasClass('4004') || $(this).hasClass('4005')){
                $(this).find('input[type="checkbox"]').prop('checked', 'checked');
            }
        })

    });
</script>

<script id="tmp_memberList" type="text/x-handlebars-template">
    {{#each this as |member|}}

    {{#equal authCnt '0'}}
        <tr style='color: blue;' class="_memberTableRow {{member.dept_no}} {{member.staff_name}} _empNo_{{member.emp_no}} _dept_show _name_show" data-empno="{{member.emp_no}}">
    {{else}}
        <tr class="_memberTableRow {{member.dept_no}} {{member.staff_name}} _empNo_{{member.emp_no}} _dept_show _name_show" data-empno="{{member.emp_no}}">
    {{/equal}}

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
            <td><input type="checkbox" class="_authChk form-control no-margin" data-type='row' title="[확인/등록/수정/삭제]" /></td>
            <td><input type="checkbox" name="read" class="form-control no-margin _read _auth" title="[확인]" /></td>
            <td><input type="checkbox" name="insert" class="form-control no-margin _insert _auth" title="[등록/수정]" /></td>
            <td><input type="checkbox" name="delete" class="form-control no-margin _delete _auth" title="[삭제]" /></td>
        </tr>
    {{else}}
        <tr>
            <td colspan="10">{{isEmptyData}}</td>
        </tr>
    {{/each}}
</script>