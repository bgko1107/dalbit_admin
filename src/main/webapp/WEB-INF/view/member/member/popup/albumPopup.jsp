<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<div class="col-md-12 no-padding" id="report_detail">
    <div class="widget-content">
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
            <li class="active"><a href="#reportDetail" role="tab" data-toggle="tab">프로필 이미지 관리</a></li>
        </ul>
        <div class="tab-content no-padding">
            <table class="table table-bordered table-dalbit" style="margin-bottom: 0px;">
                <colgroup>
                    <col width="25%"/><col width="25%"/><col width="25%"/><col width="25%"/>
                </colgroup>
                <tr>
                    <th>회원번호</th>
                    <td> <div id="div_memNo"></div> </td>
                    <th>회원 닉네임</th>
                    <td id="memNick"></td>
                </tr>
            </table>
        </div>
        <div>
            <form id="leaderProfileForm"></form>
        </div>
        <div class="col-md-12 no-padding list-group king-gallery">
            <%--<div class="row list-group">--%>
            <form id="albumListForm"></form>
        </div>
    </div>
</div>

<script>
    var memNo =  '${param.memNo}';
    var memNick;
    var profile;
    var memSex;

    var albumDataList;
    var leaderData = {};

    $(document).ready(function() {
        $("#div_memNo").html('<a href="javascript://" class="_openMemberPop" data-memNo="' + memNo + '">' + memNo + '</a>');
        var data = new Object;
        data.mem_no = memNo;
        util.getAjaxData("info", "/rest/member/member/info", data, info_sel_success);
    });

    function info_sel_success(dst_id, response){
        $("#memNick").text(response.data.nickName);
        memNick = response.data.nickName;
        memSex =  response.data.memSex;
        getAlbum();
    }

    function getAlbum(){
        var data = {
            mem_no : memNo
        };
        util.getAjaxData("info", "/rest/member/member/album/list", data, fn_albumList_success);
    }

    function fn_albumList_success(dst_id,response){
        albumDataList = response.data.list;

        // form 띄우기
        for(var i=0; i<response.data.list.length;i++){
            response.data.list[i].memSex = memSex;
            if(response.data.list[i].leader_yn == 1){
                leaderData = response.data.list[i];
                response.data.list.splice(i, 1);
            }
        }
        for(var i=0; i<response.data.list.length;i++){
            response.data.list[i].memSex = memSex;
        }

        leaderData.memSex = memSex;

        var template = $('#tmp_leaderProfileFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = leaderData;
        var html = templateScript(context);
        $("#leaderProfileForm").html(html);

        if(response.data.list.length > 0){
            var template = $('#tmp_albumFrm').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);
            $("#albumListForm").html(html);
        }

    }

    function albumDelete(data){
        var obj;
        var leaderList = "";
        var profileList = "";
        var idxList = "";
        if(confirm('등록된 이미지를 초기화 하시겠습니까?')){
            if(!common.isEmpty(data)){
                obj = {
                    mem_no : memNo
                    , memNick : memNick
                    , memSex : memSex
                    , leaderList : data.leader + "@@"
                    , profileList : data.profile + "@@"
                    , idxList : data.idx + "@@"
                };
            }else{
                for(var i=0;i<albumDataList.length;i++){
                    leaderList += albumDataList[i].leader_yn + "@@";
                    profileList += albumDataList[i].profileImage + "@@";
                    idxList += albumDataList[i].idx + "@@";
                }
                obj = {
                    mem_no : memNo
                    , memNick : memNick
                    , memSex : memSex
                    , leaderList : leaderList + leaderData.leader_yn + "@@"
                    , profileList : profileList + leaderData.profileImage + "@@"
                    , idxList : idxList + leaderData.idx + "@@"
                };
            }
            console.log(obj);
            util.getAjaxData("info", "/rest/member/member/album/delete", obj, fn_albumDelete_success);
        }
    }

    function fn_albumDelete_success(dst_id, response){
        getAlbum();
    }
</script>


<!-- =------------------ Handlebars ---------------------------------- -->
<script id="tmp_leaderProfileFrm" type="text/x-handlebars-template">
    <%--{{^equal data.profileImage ''}}--%>
    <div class="item col-md-12 mb15" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
        <div class="pull-right">
            <a href="javascript://" class="btn btn-danger btn-xs" onclick="albumDelete()"><i class="fa fa-times-circle"></i> 전체 초기화</a>
        </div>
        <img class="thumbnail fullSize_background" style="width:360px; height:auto;margin:0 auto;" src="{{renderProfileImage profileImage memSex}}"/>
        <div class="text-center mt5">
            <span class="mt5">대표 이미지 </span>
            <a href="javascript://" class="btn btn-danger btn-xs" onclick="albumDelete($(this).data())" data-idx="{{idx}}" data-leader="1" data-profile="{{profileImage}}" style=""><i class="fa fa-times-circle"></i> 초기화</a>
        </div>
    </div>
</script>

<script id="tmp_albumFrm" type="text/x-handlebars-template">
    {{#each this.list as |data|}}
    <%--{{^equal data.profileImage ''}}--%>
    <div class="item col-md-3 col-sm-6 mb15" style="padding-bottom: 15px;padding-right: 3px;padding-left: 3px">
        <div style="border: 1px solid #ddd; border-radius: 4px; padding: 4px;height: 235px;">
            <div class="thumbnail" src="{{renderImage data.profileImage}}?360x360">
                <img class="list-group-image thumbnailImg fullSize_background" style="width:360px; height:225px;" src="{{renderProfileImage data.profileImage data.memSex}}" alt="" data-toggle="modal" data-target="#imgModal" />
                <div class="caption">
                    <div class="action-buttons">
                        <a href="javascript://" class="btn btn-danger btn-xs" onclick="albumDelete($(this).data())" data-idx="{{data.idx}}" data-leader="0" data-profile="{{data.profileImage}}"><i class="fa fa-times-circle"></i> 초기화</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {{/each}}
</script>