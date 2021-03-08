
<div class="col-md-1 no-padding pull-right">
    <button type="button" class="btn btn-primary pull-right" onclick="newrecordAdd();"><i class="fa fa-search"></i>등록</button>
</div>
<div class="widget-content col-md-12 no-padding">
    <table class="table table-sorting table-hover table-bordered datatable" id="table_newrecord_list">
        <thead>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>
<button type="button" class="btn btn-danger pull-left" id="newrecordDel" onclick="newrecordDel();">추천 DJ 삭제</button>

<span id="newrecordInfo"></span>

<script>

    var dtList_record;
    function newrecordList() {
        var dtList_info_data = function (data) {
            data.searchText = $("#searchText").val();
        };
        dtList_record = new DalbitDataTable($("#table_newrecord_list"), dtList_info_data, ggamggameDataTableSource.newrecordList);
        dtList_record.useCheckBox(true);
        dtList_record.useIndex(true);
        dtList_record.setPageLength(50);
        dtList_record.createDataTable();

    }

    function newrecordAdd(){

        var template = $('#tmp_newrecordInfo').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript();
        $("#newrecordInfo").html(html);

    }
    function newrecordDetail(idx){
        var data = dtList_record.getDataRow(idx);
        util.getAjaxData("newrecord", "/rest/event/ggamggame/newrecord/detail", data, fn_newrecordDetail_success);
    }

    function fn_newrecordDetail_success(dst_id, response){

        var template = $('#tmp_newrecordInfo').html();
        var templateScript = Handlebars.compile(template);
        var data = response.data;
        var html = templateScript(data);
        $("#newrecordInfo").html(html);

    }

    function newrecordEdit(){

    }

    function newrecordDel() {

        var checkDatas = dtList_record.getCheckedData();

        if(checkDatas.length == 0){
            alert('삭제할 신기록 이벤트를 Check 하세요.');
            return;
        }
        if(confirm('선택한 신기록 이벤트를 삭제 하시겠습니까?')){
            var memNoList = "";
            for(var i=0;i<checkDatas.length;i++){
                memNoList += checkDatas[i].mem_no + "@@";
            }
            var data = {
                memNoList : memNoList
            };

            util.getAjaxData("newrecord", "/rest/event/ggamggame/newrecord/delete", data, function(dst_id, response){
                newrecordList();
            });
        }
    }

</script>

<script id="tmp_newrecordInfo" type="text/x-handlebars-template">

    <button type="button" class="btn btn-success pull-right" id="newrecordEdit" onclick="newrecordEdit();">저장</button>

    <table class="table table-bordered table-summary pull-right no-margin" style="width: 100%">
        <colgroup>
            <col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%">
            <col width="10%"><col width="10%"><col width="10%"><col width="10%"><col width="10%">
        </colgroup>
        <tr>
            <th class="_bgColor" data-bgcolor="#c6d9f1">No</th>
            <td>{{idx}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">회원번호</th>
            <td><a href="javascript://" class="_openMemberPop" data-memno="{{mem_no}}" id="mem_no">{{mem_no}}</a></td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">닉네임</th>
            <td>{{memNick}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">등록일시<br/>최종수정일시</th>
            <td>{{regDate}}<br/>{{updDate}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">등록자<br/>최종수정자</th>
            <td>{{reg_opName}}<br/>{{upd_opName}}</td>
        </tr>
        <tr>
            <th colspan="6" class="_bgColor" data-bgcolor="#c6d9f1">추천 DJ 정보</th>
            <th class="_bgColor" data-bgcolor="#c6d9f1">성별</th>
            <td>{{{getCommonCodeRadio memSex 'memSex'}}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">게시여부</th>
            <td>{{{getCommonCodeRadio viewYn 'content_viewOn' 'N' 'view_yn'}}}</td>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">나이</th>
            <td colspan="2">{{{getCommonCodeRadio ageType 'ageType'}}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">나이소개</th>
            <td><input type="text" class="form-control" name="age_desc" id="age_desc" value="{{ageDesc}}"></td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">최근 방송일시</th>
            <td>{{last_broadcast}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">추천 팬 등록수</th>
            <td>{{addComma fanCnt}} 명</td>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">방송정보</th>
            <td colspan="4"><input type="text" class="form-control" name="title" id="title" value="{{broadcastTitle}}"></td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">최근 3개월 방송시간</th>
            <td>{{timeStampDay broadcastTime}}</td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">최근 3개월 방송횟수</th>
            <td>{{addComma broadcastCnt}} 회</td>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">이미지 등록</th>
            <td colspan="3">
                <input type="text" class="form-control" name="image_url" id="image_url" value="{{imageUrl}}">
            </td>
            <td><button type="button" class="btn btn-default btn-sm _previewImage">미리보기</button></td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">미리보기</th>
            <td class="_previewArea">
                {{^equal imageUrl ''}}
                    <img class="thumbnail fullSize_background no-padding" src="{{imageUrl}}" style='height:auto; width:100%;margin-bottom: 0px' />
                {{/equal}}
            </td>
            <th class="_bgColor" data-bgcolor="#c6d9f1">프로필 이미지</th>
            <td>
                <img class="thumbnail fullSize_background no-padding" src="{{renderProfileImage profileImage}}" style='height:auto; width:100%;margin-bottom: 0px' />
            </td>
        </tr>
        <tr>
            <th colspan="2" class="_bgColor" data-bgcolor="#c6d9f1">소개문구</th>
            <td colspan="8"><textarea type="textarea" class="form-control" id="desc" name="desc" style="width: 100%; height: 200px">{{desc}}</textarea></td>
        </tr>
    </table>
</script>