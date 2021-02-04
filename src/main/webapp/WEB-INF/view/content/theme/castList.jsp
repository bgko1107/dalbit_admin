<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- SHOW HIDE COLUMNS DATA TABLE -->
<div>
    <div class="row col-md-12" style="padding-bottom: 15px">
        <div class="pull-left">
            ㆍ 방송 주제를 등록 수정 삭제 관리를 할 수 있습니다.
        </div>
        <div class="pull-right">
            <button type="button" class="btn btn-default mr-10" id="addBtn"><i class="fa fa-plus-square"></i>등록</button>
            <button type="button" class="btn btn-primary "><i class="fa fa-floppy-o"></i>적용</button>
        </div>
    </div>

    <div class="widget-content">
        <table id="list" class="table table-sorting table-hover table-bordered datatable">
            <thead>
            <tr>
                <th>선택</th>
                <th>No</th>
                <th>순서변경</th>
                <th>적용상태</th>
                <th>방송주제</th>
            </tr>
            </thead>
            <tbody id="tableBody">

            </tbody>
        </table>

        <div class="btn-toolbar">
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-default" id="deleteBtn"><i class="fa fa-trash-o"></i>선택삭제</button>
                <button type="button" class="btn btn-primary" id="updateBtn"><i class="fa fa-pencil"></i>선택수정</button>
            </div>

            <%--<div class="btn-group pull-right" role="group">--%>
                <%--<button type="button" class="btn btn-default mr-10" id="addBtn"><i class="fa fa-plus-square"></i>등록</button>--%>
                <%--<button type="button" class="btn btn-primary "><i class="fa fa-floppy-o"></i>적용</button>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<!-- END SHOW HIDE COLUMNS DATA TABLE -->


<script>
    $(document).ready(function() {
        // util.getAjaxData("list", "/rest/content/theme/list", "", fn_success, fn_fail);
        fnc_castList.init();
    });

    var fnc_castList = {};
    fnc_castList.targetId= "castList";

    fnc_castList.init= function() {
        fnc_castList.target = $("#" + fnc_castList.targetId);

        util.getAjaxData("list", "/rest/content/theme/cast", "", fnc_castList.fn_success, fnc_castList.fn_fail);

        fnc_castList.initEvent();
    };

    fnc_castList.initEvent= function() {
        fnc_castList.target.on('click', '._down', function () {
            var targetTr = $(this).closest('tr');
            var nextTr = targetTr.next();
            targetTr.insertAfter(nextTr);
            fnc_castList.resetNo();
            fnc_castList.btnSet();
        });

        fnc_castList.target.on('click', '._up', function () {
            var targetTr = $(this).closest('tr');
            var prevTr = targetTr.prev();
            targetTr.insertBefore(prevTr);
            fnc_castList.resetNo();
            fnc_castList.btnSet();
        });

        fnc_castList.target.find('#deleteBtn').on('click', function () {
            var checked = fnc_castList.target.find('#tableBody').find('._check:checked');

            if (0 == checked.length) {
                alert("삭제할 방송 주제를 선택해주세요.");
                return;
            }
            if (confirm('삭제하시겠습니까?')) {
                var checked = fnc_castList.target.find('#tableBody').find('._check:checked');
                checked.closest('tr').remove();
                fnc_castList.resetNo();
            }
        });

        fnc_castList.target.find("#updateBtn").on('click', function () {
            var checked = fnc_castList.target.find('#tableBody').find('._check:checked');
            if (0 == checked.length) {
                alert("수정할 방송 주제를 선택해주세요.");
                return;
            }

            checked.each(function () {
                $(this).closest('tr').find('._cdNm').prop('readonly', false);
                /*if(!isEmpty(input.val())){
                    $("#tableBody").find('._cdNm').prop('readonly', false);
                }*/
            });

            fnc_castList.target.find('#tableBody').find('._check:checked:eq(0)').closest('tr').find('._cdNm').focus();
        });

        fnc_castList.target.find("#addBtn").on('click', function () {
            var newData = {
                no: fnc_castList.target.find('._noTd').length + 1,
                cdNm: '',
                isOn: true,
                readonly: false
            }

            var template = fnc_castList.target.find('#tmp_list').html();
            var templateScript = Handlebars.compile(template);
            var html = templateScript({data: newData});

            fnc_castList.target.find("#tableBody").append(html);

            fnc_castList.btnSet();
        });
    };

    fnc_castList.fn_success= function(dst_id, response)
    {
        var template = fnc_castList.target.find('#tmp_list').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript(response);

        fnc_castList.target.find("#tableBody").append(html);

        fnc_castList.btnSet();
    };

    fnc_castList.fn_fail= function(data, textStatus, jqXHR) {
        dalbitLog(data, textStatus, jqXHR);
    };



    fnc_castList.resetNo= function() {
        fnc_castList.target.find('._noTd').each(function (index) {
            $(this).html(index + 1);
        });

        fnc_castList.target.find('._noTr').each(function (index) {
            $(this).attr("id", "row_" + index + 1);
        });
    };

    fnc_castList.btnSet= function() {
        fnc_castList.target.find('.btn._down').prop('disabled', false);
        fnc_castList.target.find('.btn._down:last').prop('disabled', true);

        fnc_castList.target.find('.btn._up').prop('disabled', false);
        fnc_castList.target.find('.btn._up:first').prop('disabled', true);
    };


    fnc_castList.allowDrop= function(ev) {
        ev.preventDefault();
    };

    fnc_castList.drag= function(ev) {
        ev.dataTransfer.setData("text", ev.target.id);
    };

    fnc_castList.drop= function(ev) {
        ev.preventDefault();
        var data = ev.dataTransfer.getData("text");
        var idx = data.split("_")[1];
        var targetIdx = fnc_castList.target.find(ev.target).parent("tr").attr("id").split("_")[1];

        if(parseInt(targetIdx) < parseInt(idx)){
            fnc_castList.target.find(ev.target).parent("tr").before(fnc_castList.target.find("#"+data));
        }else{
            fnc_castList.target.find(ev.target).parent("tr").after(fnc_castList.target.find("#"+data));
        }

        fnc_castList.resetNo();
        fnc_castList.btnSet();
    };

</script>

<script id="tmp_list" type="text/x-handlebars-template">
    {{#data}}
    <tr class="_noTr" id="row_{{index @index no}}" ondrop="fnc_castList.drop(event)" ondragover="fnc_castList.allowDrop(event)" draggable="true" ondragstart="fnc_castList.drag(event)">
        <td>
            <input type="checkbox" class="form-control _check" />
        </td>
        <td class="_noTd">{{index @index no}}</td>
        <td>
            <button type="button" class="btn btn-info _down"><i class="toggle-icon fa fa-angle-down"></i></button>
            <button type="button" class="btn btn-danger _up"><i class="toggle-icon fa fa-angle-up"></i></button>
        </td>
        <td>
            <div class="control-inline onoffswitch">
                <input type="checkbox" name="useYn" class="onoffswitch-checkbox" id="castList_useYn{{index @index no}}" {{#unless isOn}}checked{{/unless}}>
                <label class="onoffswitch-label" for="castList_useYn{{index @index no}}">
                    <span class="onoffswitch-inner"></span>
                    <span class="onoffswitch-switch"></span>
                </label>
            </div>
        </td>
        <td>
            <input type="text" value="{{cdNm}}" class="form-control _cdNm" {{#unless isOn}}readonly="true"{{/unless}} />
        </td>
    </tr>
    {{/data}}
</script>