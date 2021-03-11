<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData" value="<%= java.lang.Math.round(java.lang.Math.random() * 1000000) %>" />
<!-- DATA TABLE -->
<div class="widget widget-table">
    <%--<div class="widget-header">--%>
        <%--<h3><i class="fa fa-desktop"></i> 검색결과</h3>--%>
    <%--</div>--%>

        <div class="row col-lg-12">
            <div class="pull-left mt15 ml5">
                ㆍ 매달 스페셜 DJ 신청조건을 관리합니다.
            </div>

            <div class="top-right pull-right dataTable-div">
                <button type="button" class="btn btn-danger btn-sm" id="addBtn" style="margin-right: 3px;"><i class="fa fa-plus-circle"></i>추가</button>
            </div>
        </div>

        <div class="widget-content">
            <table id="reqManageList" class="table table-sorting table-hover table-bordered">
                <thead>
                </thead>
                <tbody id="tableBody">
                </tbody>
            </table>
        </div>

        <%--<div class="widget-footer">
            <span>
                <button type="button" class="btn btn-default btn-sm print-btn pull-right" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
            </span>
        </div>--%>
</div>
<!-- // DATA TABLE -->

<div class="mt15">
    <form id="reqManageDetail"></form>
</div>

<script type="text/javascript" src="/js/util/specialDjUtil.js?${dummyData}"></script>
<script type="text/javascript" src="/js/dataTablesSource/menu/specialDataTableSource.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">


    function initManage() {
        reqManageList();
    }

    function reqManageList() {
        var dtList_info;
        dtList_info = new DalbitDataTable($("#reqManageList"), {}, specialDataTableSource.reqManageList, $("#searchForm"));
        dtList_info.useCheckBox(false);
        dtList_info.useIndex(false);
        dtList_info.setPageLength(20);
        dtList_info.createDataTable();

        ui.checkBoxInit('reqManageList');
        dtList_info.reload();
    }

    $(document).on('click', '._detail', function() {
       var data = {
           'select_year': $(this).data('year')
           , 'select_month':  $(this).data('month')
       };
       util.getAjaxData("detail", "/rest/menu/special/selectManageInfo", data, fn_success_manage_detail);
    });

    function fn_success_manage_detail(dst_id, response) {

        var template = $('#tmp_req_manage_detail').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        $('#reqManageDetail').html(html);
        calendarInit();
    }

    function calendarInit(){

        $('#req_start_date').datepicker();
        $('#req_end_date').datepicker();
        $('#condition_start_date').datepicker();
        $('#condition_end_date').datepicker();
    }

    function validationCheck(){
        var round_no = $("#round_no");
        if(common.isEmpty(round_no.val())){
            alert('기수를 선택해주세요.');
            return false;
        }


        var title = $("#title");
        if(common.isEmpty(title.val())){
            alert('제목을 입력해주세요.');
            title.focus();
            return false;
        }

        var req_start_date = $("#req_start_date");
        if(common.isEmpty(req_start_date.val())){
            alert('신청기간 시작일을 선택해주세요.');
            req_start_date.focus();
            return false;
        }

        var req_end_date = $("#req_end_date");
        if(common.isEmpty(req_end_date.val())){
            alert('신청기간 종료일을 선택해주세요.');
            req_end_date.focus();
            return false;
        }

        var condition_start_date = $("#condition_start_date");
        if(common.isEmpty(condition_start_date.val())){
            alert('데이터 수집기간 시작일을 선택해주세요.');
            condition_start_date.focus();
            return false;
        }

        var condition_end_date = $("#condition_end_date");
        if(common.isEmpty(condition_end_date.val())){
            alert('데이터 수집기간 종료일을 선택해주세요.');
            condition_end_date.focus();
            return false;
        }

        var condition_data1 = $("#condition_data1");
        if(common.isEmpty(condition_data1.val())){
            alert('자격요건을 입력해주세요.');
            condition_data1.focus();
            return false;
        }

        var condition_data2 = $("#condition_data2");
        if(common.isEmpty(condition_data2.val())){
            alert('자격요건을 입력해주세요.');
            condition_data2.focus();
            return false;
        }

        var condition_data3 = $("#condition_data3");
        if(common.isEmpty(condition_data3.val())){
            alert('자격요건을 입력해주세요.');
            condition_data3.focus();
            return false;
        }

        var condition_data3 = $("#condition_data3");
        if(common.isEmpty(condition_data3.val())){
            alert('자격요건을 입력해주세요.');
            condition_data3.focus();
            return false;
        }
        if(0 == $('input[name="is_view"]:radio:checked').length){
            alert('게시여부를 선택해주세요.');
            return false;
        }

        if(0 == $('input[name="platform"]:radio:checked').length){
            alert('플랫폼을 선택해주세요.');
            return false;
        }

        var platform = $('input:radio[name="platform"]:checked').val();
        var is_pc = (platform == 0 || platform == 1) ? true : false;
        var is_mobile = (platform == 0 || platform == 2) ? true : false;

        var contentCheck = true;
        $('._manageContent').each(function(){
           var me = $(this);
           var contentType = me.find('.content_type:checked').val();
           if(contentType == 'image'){

               if(is_pc) {
                   var imagePcUrl = me.find('.image_pc_url');
                   if (common.isEmpty(imagePcUrl.val())) {
                       alert('pc 이미지 url을 입력해주세요.');
                       imagePcUrl.focus();
                       contentCheck = false;
                       return false;
                   }
               }

               if(is_mobile) {
                   var imageMobileUrl = me.find('.image_mobile_url');
                   if (common.isEmpty(imageMobileUrl.val())) {
                       alert('모바일 이미지 url을 입력해주세요.');
                       imageMobileUrl.focus();
                       contentCheck = false;
                       return false;
                   }
               }

           }else if(contentType == 'button'){
               var buttonType = me.find('.button_type:checked');
               if(common.isEmpty(buttonType.val())){
                   alert('버튼타입을 선택해주세요.');
                   buttonType.focus();
                   contentCheck = false;
                   return false;
               }

               var buttonColor = me.find('.button_color');
               if(common.isEmpty(buttonColor.val())){
                   alert('버튼색상을 입력해주세요.');
                   buttonColor.focus();
                   contentCheck = false;
                   return false;
               }

               var buttonName = me.find('.button_name');
               if(common.isEmpty(buttonName.val())){
                   alert('버튼명을 입력해주세요.');
                   buttonName.focus();
                   contentCheck = false;
                   return false;
               }

               var buttonNameColor = me.find('.button_name_color');
               if(common.isEmpty(buttonNameColor.val())){
                   alert('버튼명 색상을 입력해주세요.');
                   buttonNameColor.focus();
                   contentCheck = false;
                   return false;
               }

               if(is_pc) {
                   var buttonPcLink = me.find('.button_pc_link');
                   if (common.isEmpty(buttonPcLink.val())) {
                       alert('pc 링크를 입력해주세요.');
                       buttonPcLink.focus();
                       contentCheck = false;
                       return false;
                   }
               }

               if(is_mobile) {
                   var buttonMobileLink = me.find('.button_mobile_link');
                   if (common.isEmpty(buttonMobileLink.val())) {
                       alert('모바일 링크를 입력해주세요.');
                       buttonMobileLink.focus();
                       contentCheck = false;
                       return false;
                   }
               }
           }
        });

        return contentCheck;

    }

    $(document).on('click', '#updateBtn, #insertBtn', function(){

        if(!validationCheck()){
            return false;
        }
        if(confirm('저장하시겠습니까?')){

            var me = $(this);

            var saveUrl = '/rest/menu/special/updateManageInfo';
            var distId = 'updateManageInfo';
            var buttonId = me.prop('id');
            if(buttonId == 'insertBtn'){
                $('input[type="hidden"][name="select_year"]').val($('#content_select_year').val());
                $('input[type="hidden"][name="select_month"]').val($('#content_select_month').val());

                distId = 'insertManageInfo';
                saveUrl = '/rest/menu/special/insertManageInfo';
            }

            var contentList = new Array();
            $('._manageContent').each(function(index){
                var content_type = $(this).find('.content_type:checked').val();

                if(content_type == 'image'){
                    var data = {
                        content_type : $(this).find('.content_type:checked').val()
                        , content_order : index
                        , image_pc_url : $(this).find('.image_pc_url').val()
                        , image_mobile_url : $(this).find('.image_mobile_url').val()
                    }

                }else if(content_type == 'button'){
                    var data = {
                        content_type : $(this).find('.content_type:checked').val()
                        , content_order : index
                        , button_type : $(this).find('.button_type:checked').val()
                        , button_color : $(this).find('.button_color').val()
                        , button_name : $(this).find('.button_name').val()
                        , button_name_color : $(this).find('.button_name_color').val()
                        , button_pc_link : $(this).find('.button_pc_link').val()
                        , button_mobile_link : $(this).find('.button_mobile_link').val()
                    }
                }

                contentList.push(data);
            });

            var formData = util.serializeToJson($("#reqManageDetail"))
            formData.contentList = contentList;

            var json = {
                jsonData : JSON.stringify(formData)
            }
            util.getAjaxData(distId, saveUrl, json, fn_success_insertManageInfo);
        }
    });

    $(document).on('change', '.content_type', function(){
        var me = $(this);
        var table = me.closest('table')

        $(table).find('._tr_imageArea').hide();
        $(table).find('._tr_buttonArea').hide();

        if(me.val() == 'image'){
            $(table).find('._tr_imageArea').show();
        }else if(me.val() == 'button'){
            $(table).find('._tr_buttonArea').show();
        }
    });

    $(document).on('click', '._up', function(){
        var me = $(this);
        var targetTable = me.closest('table');
        var selector = $('._manageContent');
        var targetIndex = selector.index(targetTable);
        if(0 < selector.index(targetTable)){
            $(selector[targetIndex-1]).before(targetTable);
        }
    });

    $(document).on('click', '._down', function(){
        var me = $(this);
        var targetTable = me.closest('table');
        var selector = $('._manageContent');
        var targetIndex = selector.index(targetTable);
        if(targetIndex < selector.length -1){
            $(selector[targetIndex+1]).after(targetTable);
        }
    });

    $(document).on('click', '._delete', function(){
        if(confirm('삭제하시겠습니까?')){
            var me = $(this);
            var targetTable = me.closest('table');

            targetTable.remove();
        }
    });

    $(document).on('click', '#addContentBtn', function(){
        var template = $('#tmp_manage_content').html();
        var templateScript = Handlebars.compile(template);
        var context = {
            randomData : Math.floor(Math.random() * 10000)
        };
        var html = templateScript(context);

        var lastContent = $('._manageContent:last');
        if(lastContent.length == 0){
            $("#reqManageDetail").find('table').after(html);
        }else{
            lastContent.after(html);
        }

    });

    $(document).on('click', '.previewImage', function(){
        var me = $(this);
        var url = me.parent().find('input[type="text"]').val();
        var img = me.parent().parent().find('img');
        img.prop('src', url);
    });

    $(document).on('click', '#addBtn', function(){
        var me = $(this);
        var data = {
            'select_year': null
            , 'select_month': null
        };
        util.getAjaxData("detail", "/rest/menu/special/selectManageInfo", data, fn_success_manage_detail);
    });

</script>

<script type="text/x-handlebars-template" id="tmp_req_manage_detail">
    <div class="widget widget-table">
        <div class="widget-header">
            <h3><i class="fa fa-desktop"></i> 스페셜 DJ 신청 관리</h3>
        </div>
        <div class="widget-content mt15">
            <div class="row col-lg-12 form-inline">
                <table class="table table-bordered table-dalbit">
                    <input type="hidden" name="idx" value="{{this.idx}}"/>
                    <colgroup>
                        <col width="10%"/>
                        <col width="40%"/>
                        <col width="10%"/>
                        <col width="40%"/>
                    </colgroup>
                    <tr>
                        <th>선정기간</th>
                        <td>
                            {{#equal this.specialDjManageInfo.select_year ''}}
                                {{{getCommonCodeSelect '2020' 'special_selectYears' 'N' 'content_select_year'}}}
                                {{{getCommonCodeSelect '08' 'special_selectMonths' 'N' 'content_select_month'}}}
                            {{else}}
                                {{../this.specialDjManageInfo.select_year}}년 {{../this.specialDjManageInfo.select_month}}월
                            {{/equal}}
                            <input type="hidden" name="select_year" id="select_year" value="{{this.specialDjManageInfo.select_year}}" />
                            <input type="hidden" name="select_month" id="select_month" value="{{this.specialDjManageInfo.select_month}}" />
                        </td>

                        <th>기수</th>
                        <td>
                            {{{getCommonCodeSelect this.specialDjManageInfo.round_no 'special_roundNos'}}}
                        </td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td>
                            <input type="text" class="form-control" style="width:100%" id="title" name="title" value="{{this.specialDjManageInfo.title}}" />
                        </td>

                        <th>공지사항 번호</th>
                        <td>
                            <input type="text" class="form-control" style="width:100px;" id="notice_idx" name="notice_idx" value="{{this.specialDjManageInfo.notice_idx}}" />
                        </td>
                    </tr>
                    <tr>
                        <th>신청 기간</th>
                        <td>
                            <div class="form-inline">
                                <div class="input-group date">
                                    <span class="input-group-addon" id="view-iconStartDate"><i class="fa fa-calendar"></i></span>
                                    <input type="text" class="form-control" name="req_start_date" id="req_start_date" style="width:100px; background:white;" readonly="" value="{{this.specialDjManageInfo.req_start_date}}" />
                                </div>
                                <span> ~ </span>
                                <div class="input-group date">
                                    <span class="input-group-addon" id="view-iconEndDate"><i class="fa fa-calendar"></i></span>
                                    <input type="text" class="form-control" name="req_end_date" id="req_end_date" style="width:100px; background:white;" readonly="" value="{{this.specialDjManageInfo.req_end_date}}" />
                                </div>
                            </div>
                        </td>
                        <th>데이터 수집 기간</th>
                        <td>
                            <div class="form-inline">
                                <div class="input-group date">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    <input type="text" class="form-control" name="condition_start_date" id="condition_start_date" style="width:100px; background:white;" readonly="" value="{{this.specialDjManageInfo.condition_start_date}}">
                                </div>
                                <span> ~ </span>
                                <div class="input-group date">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    <input type="text" class="form-control" name="condition_end_date" id="condition_end_date" style="width:100px; background:white;" readonly="" value="{{this.specialDjManageInfo.condition_end_date}}">
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4"></td>
                    </tr>

                    <tr>
                        <th>자격요건1</th>
                        <td>

                            <select class="form-control" name="condition_code1">
                                {{#each this.specialDjCondition}}
                                    <option value="{{cd}}" {{#equal ../specialDjManageInfo.condition_code1 cd}}selected{{/equal}}>{{cdNm}}</option>
                                {{/each}}
                            </select>
                            <input type="text" class="form-control" id="condition_data1" name="condition_data1" value="{{this.specialDjManageInfo.condition_data1}}" />
                        </td>

                        <th>자격요건2</th>
                        <td>
                            <select class="form-control" name="condition_code2">
                                {{#each this.specialDjCondition}}
                                    <option value="{{cd}}" {{#equal ../specialDjManageInfo.condition_code2 cd}}selected{{/equal}}>{{cdNm}}</option>
                                {{/each}}
                            </select>
                            <input type="text" class="form-control" id="condition_data2" name="condition_data2" value="{{this.specialDjManageInfo.condition_data2}}" />
                        </td>
                    </tr>
                    <tr>
                        <th>자격요건3</th>
                        <td>
                            <select class="form-control" name="condition_code3">
                                {{#each this.specialDjCondition}}
                                    <option value="{{cd}}" {{#equal ../specialDjManageInfo.condition_code3 cd}}selected{{/equal}}>{{cdNm}}</option>
                                {{/each}}
                            </select>
                            <input type="text" class="form-control" id="condition_data3" name="condition_data3" value="{{this.specialDjManageInfo.condition_data3}}" />
                        </td>

                        <th>자격요건4</th>
                        <td>
                            <select class="form-control" name="condition_code4">
                                {{#each this.specialDjCondition}}
                                    <option value="{{cd}}" {{#equal ../specialDjManageInfo.condition_code4 cd}}selected{{/equal}}>{{cdNm}}</option>
                                {{/each}}
                            </select>
                            <input type="text" class="form-control" id="condition_data4" name="condition_data4" value="{{this.specialDjManageInfo.condition_data4}}" />
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4"></td>
                    </tr>

                    <tr>
                        <th>베스트 요건 1</th>
                        <td>
                            <select class="form-control" name="best_code1" readonly="readonly">
                                {{#each this.specialDjCondition}}
                                    <option value="{{cd}}" {{#equal 8 cd}}selected{{else}}disabled="disabled"{{/equal}}>{{cdNm}}</option>
                                {{/each}}
                            </select>
                            <input type="text" class="form-control" id="best_data1" name="best_data1" value="{{this.specialDjManageInfo.best_data1}}" />
                        </td>
                        <th>베스트 요건 2</th>
                        <td>
                            <select class="form-control" name="best_code2" readonly="readonly">
                                {{#each this.specialDjCondition}}
                                    <option value="{{cd}}" {{#equal 9 cd}}selected{{else}}disabled="disabled"{{/equal}}>{{cdNm}}</option>
                                {{/each}}
                            </select>
                            <input type="text" class="form-control" id="best_data2" name="best_data2" value="{{this.specialDjManageInfo.best_data2}}" />
                        </td>
                    </tr>

                    <tr>
                        <th>베스트 요건 3</th>
                        <td colspan="3">
                            <select class="form-control" name="best_code3" readonly="readonly">
                                {{#each this.specialDjCondition}}
                                    <option value="{{cd}}" {{#equal 10 cd}}selected{{else}}disabled="disabled"{{/equal}}>{{cdNm}}</option>
                                {{/each}}
                            </select>
                            <input type="text" class="form-control" id="best_data3" name="best_data3" value="{{this.specialDjManageInfo.best_data3}}" />
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4"></td>
                    </tr>

                    <tr>
                        <th>게시여부</th>
                        <td>{{{getCommonCodeRadio this.specialDjManageInfo.is_view 'content_viewOn' null 'is_view'}}}</td>
                        <th>플랫폼</th>
                        <td>{{{getCommonCodeRadio this.specialDjManageInfo.platform 'content_platform4' null 'platform'}}}</td>
                    </tr>

                    <!--<tr>
                        <th>pc 이미지</th>
                        <td colspan="2">
                            <input type="text" class="form-control" style="width:80%" id="pc_image_url" name="pc_image_url" value="{{this.specialDjManageInfo.pc_image_url}}" />
                            <button type="button" id="pcPrevBtn">미리보기</button>
                        </td>
                        <td id="pcImgPrevTd">
                            <img src="{{this.specialDjManageInfo.pc_image_url}}" height="70px" class="thumbnail fullSize_background" />
                        </td>
                    </tr>
                    <tr>
                        <th>모바일 이미지</th>
                        <td colspan="2">
                            <input type="text" class="form-control" style="width:80%" id="mobile_image_url" name="mobile_image_url" value="{{this.specialDjManageInfo.mobile_image_url}}" />
                            <button type="button" id="mobilePrevBtn">미리보기</button>
                        </td>
                        <td id="mobileImgPrevTd">
                            <img src="{{this.specialDjManageInfo.mobile_image_url}}" height="70px" class="thumbnail fullSize_background"  />
                        </td>
                    </tr>-->

                    {{#if this.specialDjManageInfo.op_name}}
                        <tr>
                            <th>등록자</th>
                            <td>{{this.specialDjManageInfo.op_name}}</td>
                            <th>등록일</th>
                            <td>{{this.specialDjManageInfo.reg_date}}</td>
                        </tr>
                    {{/if}}

                    {{#if this.specialDjManageInfo.last_op_name}}
                        <tr>
                            <th>수정자</th>
                            <td>{{this.specialDjManageInfo.last_op_name}}</td>
                            <th>수정일</th>
                            <td>{{this.specialDjManageInfo.last_upd_date}}</td>
                        </tr>
                    {{/if}}
                </table>

                {{#each this.specialDjManageInfo.contentList as |item|}}
                    <table class="table table-bordered table-dalbit _manageContent">
                        <colgroup>
                            <col width="10%"/>
                            <col width="40%"/>
                            <col width="10%"/>
                            <col width="40%"/>
                        </colgroup>
                        <tr>
                            <th>컨텐츠 타입</th>
                            <td>
                                {{{getCommonCodeRadioMulti item.content_type 'special_manage_contentType' 'Y' null @index}}}
                            </td>
                            <th>순서변경</th>
                            <td>
                                <button type="button" class="btn btn-info _down"><i class="toggle-icon fa fa-angle-down"></i></button>
                                <button type="button" class="btn btn-danger _up"><i class="toggle-icon fa fa-angle-up"></i></button>

                                <button type="button" class="btn btn-default btn-sm pull-right _delete"><i class="toggle-icon fa fa-delete"></i><i class="fa fa-trash-o"></i>삭제</button>
                            </td>
                        </tr>

                        <!-- 이미지 영역 start -->
                        <tr style="{{#equal item.content_type 'button'}}display:none;{{/equal}}" class="_tr_imageArea">
                            <th>pc 이미지</th>
                            <td colspan="2">
                                <input type="text" class="form-control image_pc_url" style="width:80%" value="{{item.image_pc_url}}" />
                                <button type="button" class="previewImage">미리보기</button>
                            </td>
                            <td>
                                <img src="{{item.image_pc_url}}" height="70px" class="thumbnail fullSize_background" />
                            </td>
                        </tr>

                        <tr style="{{#equal item.content_type 'button'}}display:none;{{/equal}}" class="_tr_imageArea">
                            <th>모바일 이미지</th>
                            <td colspan="2">
                                <input type="text" class="form-control image_mobile_url" style="width:80%" value="{{item.image_mobile_url}}" />
                                <button type="button" class="previewImage">미리보기</button>
                            </td>
                            <td id="mobileImgPrevTd">
                                <img src="{{item.image_mobile_url}}" height="70px" class="thumbnail fullSize_background"  />
                            </td>
                        </tr>
                        <!-- 이미지 영역 end -->

                        <!-- 버튼 영역 start -->
                        <tr style="{{#equal item.content_type 'image'}}display:none;{{/equal}}" class="_tr_buttonArea">
                            <th>버튼 타입</th>
                            <td>
                                {{{getCommonCodeRadioMulti item.button_type 'special_manage_content_button_type' 'Y' null @index}}}
                            </td>
                            <th>버튼색상</th>
                            <td>
                                <input type="text" class="form-control button_color" style="width:80%" value="{{item.button_color}}" />
                            </td>
                        </tr>
                        <tr style="{{#equal item.content_type 'image'}}display:none;{{/equal}}" class="_tr_buttonArea">
                            <th>버튼명</th>
                            <td>
                                <input type="text" class="form-control button_name" style="width:80%" value="{{item.button_name}}" />
                            </td>
                            <th>버튼명 색상</th>
                            <td>
                                <input type="text" class="form-control button_name_color" style="width:80%" value="{{item.button_name_color}}" />
                            </td>
                        </tr>
                        <tr style="{{#equal item.content_type 'image'}}display:none;{{/equal}}" class="_tr_buttonArea">
                            <th>PC 링크</th>
                            <td>
                                <input type="text" class="form-control button_pc_link" style="width:80%" value="{{item.button_pc_link}}" />
                            </td>
                            <th>모바일 링크</th>
                            <td>
                                <input type="text" class="form-control button_mobile_link" style="width:80%" value="{{item.button_mobile_link}}" />
                            </td>
                        </tr>
                        <!-- 버튼 영역 end -->
                    </table>
                {{/each}}

                {{#equal this.specialDjManageInfo.select_year ''}}
                    <button type="button" class="btn btn-success btn-sm pull-right mb15 mr10" id="insertBtn">
                        <i class="fa fa-floppy-o"></i>저장
                    </button>
                {{else}}
                    <button type="button" class="btn btn-success btn-sm pull-right mb15 mr10" id="updateBtn">
                        <i class="fa fa-floppy-o"></i>저장
                    </button>
                {{/equal}}
                <button type="button" class="btn btn-warning btn-sm pull-right mb15 mr10" id="addContentBtn" style="display:none;">
                    <i class="fa fa-plus"></i>컨텐츠 추가
                </button>
            </div>
        </div>
    </div>
</script>

<script type="text/x-handlebars-template" id="tmp_manage_content">
    <table class="table table-bordered table-dalbit _manageContent">
        <colgroup>
            <col width="10%"/>
            <col width="40%"/>
            <col width="10%"/>
            <col width="40%"/>
        </colgroup>
        <tr>
            <th>컨텐츠 타입</th>
            <td>
                {{{getCommonCodeRadioMulti 'image' 'special_manage_contentType' 'Y' null randomData}}}
            </td>
            <th>순서변경</th>
            <td>
                <button type="button" class="btn btn-info _down"><i class="toggle-icon fa fa-angle-down"></i></button>
                <button type="button" class="btn btn-danger _up"><i class="toggle-icon fa fa-angle-up"></i></button>

                <button type="button" class="btn btn-default btn-sm pull-right _delete"><i class="toggle-icon fa fa-delete"></i><i class="fa fa-trash-o"></i>삭제</button>
            </td>
        </tr>

        <!-- 이미지 영역 start -->
        <tr class="_tr_imageArea">
            <th>pc 이미지</th>
            <td colspan="2">
                <input type="text" class="form-control image_pc_url" style="width:80%" value="" />
                <button type="button" class="previewImage">미리보기</button>
            </td>
            <td>
                <img src="" height="70px" class="thumbnail fullSize_background" />
            </td>
        </tr>

        <tr class="_tr_imageArea">
            <th>모바일 이미지</th>
            <td colspan="2">
                <input type="text" class="form-control image_mobile_url" style="width:80%" value="" />
                <button type="button" class="previewImage">미리보기</button>
            </td>
            <td id="mobileImgPrevTd">
                <img src="" height="70px" class="thumbnail fullSize_background"  />
            </td>
        </tr>
        <!-- 이미지 영역 end -->

        <!-- 버튼 영역 start -->
        <tr style="display:none;" class="_tr_buttonArea">
            <th>버튼 타입</th>
            <td>
                {{{getCommonCodeRadioMulti item.button_type 'special_manage_content_button_type' 'Y' null randomData}}}
            </td>
            <th>버튼색상</th>
            <td>
                <input type="text" class="form-control button_color" style="width:80%" value="" />
            </td>
        </tr>
        <tr style="display:none;" class="_tr_buttonArea">
            <th>버튼명</th>
            <td>
                <input type="text" class="form-control button_name" style="width:80%" value="" />
            </td>
            <th>버튼명 색상</th>
            <td>
                <input type="text" class="form-control button_name_color" style="width:80%" value="" />
            </td>
        </tr>
        <tr style="display:none;" class="_tr_buttonArea">
            <th>PC 링크</th>
            <td>
                <input type="text" class="form-control button_pc_link" style="width:80%" value="" />
            </td>
            <th>모바일 링크</th>
            <td>
                <input type="text" class="form-control button_mobile_link" style="width:80%" value="" />
            </td>
        </tr>
        <!-- 버튼 영역 end -->
    </table>
</script>