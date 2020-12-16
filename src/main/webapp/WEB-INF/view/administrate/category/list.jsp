<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>jsTree test</title>
    <!-- 2 load the theme CSS file -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />
</head>
<body>

<div class="col-md-12" style="margin-bottom: 20px;">
    <div class="col-md-5">
        <button type="button" class="btn btn-success btn-sm" onclick="root_add();"><i class="glyphicon glyphicon-asterisk"></i> 루트 추가</button>
        <button type="button" class="btn btn-success btn-sm" onclick="demo_create();"><i class="glyphicon glyphicon-asterisk"></i> 생성</button>
        <button type="button" class="btn btn-warning btn-sm" onclick="demo_rename();"><i class="glyphicon glyphicon-pencil"></i> 이름변경</button>
        <button type="button" class="btn btn-primary btn-sm" onclick="demo_refresh();"><i class="glyphicon glyphicon-refresh"></i> 새로고침</button>
        <button type="button" class="btn btn-danger btn-sm" onclick="demo_delete();"><i class="glyphicon glyphicon-remove"></i> 삭제</button>
        <button type="button" class="btn btn-info btn-sm pull-right" onclick="menuUpdate();">메뉴적용</button>
    </div>
    <div class="col-md-7">
        <div class="col-md-6 no-padding">
            <%--<button type="button" class="btn btn-danger btn-sm" onclick="demo_delete();"><i class="glyphicon glyphicon-remove"></i> 삭제</button>--%>
        </div>
        <div class="col-md-6 no-padding">
            <button type="button" class="btn btn-info btn-sm pull-right" onclick="menuInfoUpdate();">메뉴정보수정</button>
        </div>
    </div>
</div>
<!-- 3 setup a container element -->
<div class="col-md-12">
    <div class="col-md-5" id="jstree"></div>
    <div class="col-md-7">
        <form id="menuFrm"></form>
    </div>
</div>

<script type="text/javascript" src="/js/lib/jstree.min.js"></script>
<script type="text/javascript" src="/js/code/administrate/adminCodeList.js?${dummyData}"></script>
<script type="text/javascript">

    $(function(){
        getMenuList();
    })

    function getMenuList(){
        util.getAjaxData("menu", "/rest/administrate/menu/list", "", menu_success);
    }

    function getMenuDetail(param){
        util.getAjaxData("menuInfo", "/rest/administrate/menu/menuInfo", param, menu_info);
    }

    function menu_success(dst_id, response) {
        dalbitLog(response.data);
        var menuList = [];
        for(var i=0; i<response.data.length;i++){
            var menu = {};
            menu.id = response.data[i].id;
            menu.parent = response.data[i].parent;
            menu.text = response.data[i].text;
            menu.icon = 'fa ' + response.data[i].icon;
            menuList.push(menu);
        }

        $(function () {
            dalbitLog(menuList);
            $('#jstree').jstree({
                "core" : {
                    'multiple': false,
                    "animation" : 0,
                    "check_callback" : true,
                    'force_text' : true,
                    "themes" : { "stripes" : true },
                    'data' : menuList
                },
                "types" : {
                    "#" : { "max_children" : 1, "max_depth" : 2 },
                    "root" : { "icon" : "/static/3.3.9/assets/images/tree_icon.png", "valid_children" : ["default"] },
                    "default" : { "valid_children" : ["default","file"] },
                    "file" : { "icon" : "glyphicon glyphicon-file", "valid_children" : [] }
                },
                "plugins" : [ "contextmenu", "dnd", "search", "state", "types", "wholerow" ]
            });
        });
    }
    function fn_fail(data, textStatus, jqXHR){
        console.log(data, textStatus, jqXHR);
    }

    // 7 bind to events triggered on the tree
    $('#jstree').on("changed.jstree", function (e, data) {
        if(!common.isEmpty(data.node)){
            var obj = {};
            obj.idx = data.node.id;
            getMenuDetail(obj);
            ui.topScroll();
        }
    });
    // 8 interact with the tree - either way is OK
    $('button').on('click', function () {
        $('#jstree').jstree(true).select_node('child_node_1');
        $('#jstree').jstree('select_node', 'child_node_1');
        $.jstree.reference('#jstree').select_node('child_node_1');
    });

    function root_add(){
        $("#jstree").jstree('create_node', '#', {'id' : 'myId', 'text' : '메뉴명'}, 'last');
    }

    function demo_create() {
        var ref = $('#jstree').jstree(true),
            sel = ref.get_selected();
        if(!sel.length) { return false; }
        sel = sel[0];
        sel = ref.create_node(sel, {"type":"file"});
        if(sel) {
            ref.edit(sel);
        }
    };
    function demo_rename() {
        var ref = $('#jstree').jstree(true),
            sel = ref.get_selected();
        if(!sel.length) { return false; }
        sel = sel[0];
        ref.edit(sel);
    };
    function demo_delete() {
        var ref = $('#jstree').jstree(true),
            sel = ref.get_selected();
        if(sel.length < 1) {
            alert("삭제할 메뉴를 선택하세요.");
            return false;
        }
        if(!common.isEmpty($("#jstree").jstree().get_node( sel ).children)){
            if($("#jstree").jstree().get_node( sel ).children.length > 0){
                alert("하위 메뉴가 있습니다.");
                return false;
            }
        }
        if(confirm("선택하신 메뉴를 삭제 하시겠습니까?")){
            ref.delete_node(sel);
            for(var i=0;i<sel.length;i++){
                var obj = {};
                obj.idx = sel[i];
                console.log(obj);
                util.getAjaxData("menuDelete", "/rest/administrate/menu/menuDelete", obj, updateSucces, fn_fail);
            }
        }else{
            return false;
        }
    };

    function demo_refresh(){
        getMenuList();
        // $('#jstree').jstree(true).refresh();
    }
    function menu_info(dst_id, response) {
        var template = $('#tmp_menuFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#menuFrm").html(html);
    }

    function menuUpdate(){
        if(confirm('메뉴를 적용하시겠습니까?')){
            var obj = {
                menuList : JSON.stringify($('#jstree').jstree(true).get_json('#', { flat: true }))
            };
            util.getAjaxData("menuUpdate", "/rest/administrate/menu/menuUpdate", obj, updateSucces);
        }
    }

    function menuInfoUpdate(){
        if(confirm('메뉴정보를 수정하시겠습니까?')){
            var obj = {};
            obj.idx = $("#idx").html();
            obj.menu_url = $("#menu_url").val();
            obj.icon = $("#icon").val();
            obj.is_pop = $('input:radio[name="isPopup_on_off"]:checked').val();
            obj.is_comming_soon = $('input:radio[name="isComming_on_off"]:checked').val();
            obj.is_use = $('input:radio[name="isUse_on_off"]:checked').val();

            console.log(obj);
            // getMenuDetail(obj);
            util.getAjaxData("menuInfoUpdate", "/rest/administrate/menu/menuInfoUpdate", obj, updateSucces, fn_fail);
        }

    }

    function updateSucces(dst_id, response) {
        alert(response.message);
        getMenuList();
    }

    $(document).on('click', '._authorityBtn', function(){
        var me = $(this);
        var url = '/administrate/category/popup/authority?menuIdx='+me.data('menuidx');
        util.windowOpen(url, 1200, 800, 'authorityPopup');
    });
</script>


<script id="tmp_menuFrm" type="text/x-handlebars-template">
    <table class="table table-bordered table-dalbit">
        <colgroup>
            <col width="10%"/><col width="10%"/>
        </colgroup>
        <tbody>
        <tr>
            <th>메뉴ID</th>
            <td><label id="idx">{{idx}}</label></td>
        </tr>
        <tr>
            <th>메뉴명</th>
            <td>{{menu_name}}</td>
        </tr>
        <tr>
            <th>메뉴URL(1 depth는 빈공간으로)</th>
            <td>
                <input type="text" class="form-control" id="menu_url" value="{{menu_url}}">
            </td>
        </tr>
        <tr>
            <th>아이콘</th>
            <td><input type="text" class="form-control" id="icon" value="{{icon}}"></td>
        </tr>
        <tr>
            <th>새창여부</th>
            <td>{{{getCommonCodeRadio is_pop 'isPopup_on_off'}}}</td>
        </tr>
        <tr>
            <th>준비여부</th>
            <td>{{{getCommonCodeRadio is_comming_soon 'isComming_on_off'}}}</td>
        </tr>
        <tr>
            <th>사용여부</th>
            <td>{{{getCommonCodeRadio is_use 'isUse_on_off'}}}</td>
        </tr>
        </tbody>
    </table>

    <button type="button" class="btn btn-default btn-sm _authorityBtn" data-menuidx='{{idx}}'><i class="fa fa-lock"></i> 메뉴권한</button>

</script>

</body>
</html>
