function DalbitDataTable(dom, param, columnsInfo) {
    this.dom = dom;
    var url = columnsInfo.url;

    //초기화
    this.init();

    // //Page처리를 위한 변수 추가
    // param.startCnt = this.startCnt;
    // param.endCnt = this.endCnt;

    this.dataTableSource = {
        // dom: '<"top"<"text-right"i>><rt>p',
        dom: 'lirtp',
        destroy: true,                                                                   //테이블 파괴가능
        pageLength: 10,                                                                  // 한 페이지에 기본으로 보여줄 항목 수
        bPaginate: true,                                                                // 페이징 처리 여부.
        bLengthChange: true,                                                        //  페이지 표시 건수 변동 기능 사용 여부
        lengthMenu : [ [ 3, 5, 10, -1 ], [ 3, 5, 10, "All" ] ],                  // "bLengthChange" 리스트 항목을 구성할 옵션
        bAutoWidth: false,                                                            // 자동 Width 계산 여부
        processing: false,                                                              // Process 바 출력 여부
        ordering: true,                                                                 // 정렬 사용 여부
        serverSide: true,                                                             // 서버에서 정렬한 데이터 그대로 사용할지 여부 (false : 서버에서 정렬한 데이터도 client에서 다시 재정렬)
        searching: false,                                                               // 서칭 기능 사용 여부
        ajax : {
            'url':url,
            'type':"POST",
            'data': param,
            // 'dataSrc': "data"
            'dataFilter': function(data){
                var json = jQuery.parseJSON( data );
                // console.log("[dataFilter]")
                // console.log(json)
                json.recordsTotal = json.data.recordsTotal;
                json.recordsFiltered = json.data.recordsFiltered;
                json.data = json.data.data;

                return JSON.stringify( json ); // return JSON string
            }
        },
        columnDefs: [
            {
                'targets': [0,1],
                'searchable': false,
                'orderable': false,
            },
            {
                'targets': 0,
                'className': 'dt-body-center',
                'render': function (data, type, full, meta) {
                    return '<input type="checkbox" name="id[]" value="' + $('<div/>').text(data).html() + '">';
                }
        }],
        columns : [
            {"title": "<input type=\"checkbox\" name=\"select_all\" value=\"1\" id=\""+ this.dom.prop("id") +"-select-all\" />" ,"data": null},
            {"title": "No.", "data": null, "width": "10px"},
        ],
        order: [[ 2, 'asc' ]],
        infoCallback: function(settings, start, end, max, total, pre) {
            // console.log("[infoCallback]")
            // console.log(settings);
            // console.log(start + ":" + end  + ":" + max + ":" + total);
            // return (!isNaN(total))
            //     ? "Showing " + start + " to " + end + " of " + total + " entries"
            //     + ((total !== max) ? " (filtered from " + max + " total entries)" : "")
            //     : "Showing " + start + " to " + (start + this.api().data().length - 1) + " entries";
        }
    }

    var columnDefs = columnsInfo.columnDefs;
    var columns = columnsInfo.columns;

    if(!isEmpty(columnDefs)){
        this.dataTableSource.columnDefs = this.dataTableSource.columnDefs.concat(columnDefs);
    }

    if(!isEmpty(columns)){
        this.dataTableSource.columns = this.dataTableSource.columns.concat(columns);
    }
}








/* === Init =================================================================*/

    // 데이터 초기화
    DalbitDataTable.prototype.init = function(){
        // 체크박스 사용
        this.isUseCheckbox = true;
        // 넘버링 사용 여부
        this.isUseIndex = true;

        // ClickEvent Function
        this.arrayClickEvent = {};
        // DataTable 존재여부
        this.g_DataTable = null;

        // // 표시할 페이지 정보
        // this.pageLength = 10;
        // // 현재 선택 한 페이지
        // this.selectPage = 1;
        // // Page select 시작 범위
        // this.startCnt = 1;
        // // Page select 종료 범위
        // this.endCnt = (this.startCnt * this.pageLength);

    }

    // Init DataTable
    DalbitDataTable.prototype.createDataTable = function (initFn) {
        this.dom.empty();

        // 완료 후 처리 함수
        if(!isEmpty(initFn)){
            var dalbitDataTable = this;
            this.dataTableSource.ajax.complete = function (response) {
                // console.log("[complete]")
                // var totalData = response.responseJSON.data[0].totalCnt;
                // alert(dalbitDataTable.selectPage);
                // dalbitDataTable.createPage(totalData, dalbitDataTable.selectPage);

                // console.log("=ajax")
                // console.log(response);
                // console.log(response.responseJSON.data);
                // console.log("ajax=")

                initFn();
            };
        }

        var g_DataTable = this.dom.DataTable(this.dataTableSource);
        this.g_DataTable = g_DataTable;

        g_DataTable.column(0).visible(this.isUseCheckbox);
        g_DataTable.column(1).visible(this.isUseIndex);

        // index Number 생성
        g_DataTable.on('order.dt search.dt', function () {
            g_DataTable.column(1, { search: 'applied', order: 'applied' }).nodes().each(function (cell, i) {
                cell.innerHTML = i + 1;
            });
        }).draw();

        this.initEvent();

        return g_DataTable;
    }


    // Init Event
    DalbitDataTable.prototype.initEvent =  function (){
        var allCheckBox = $("#" + this.dom.prop("id") + "-select-all");
        var g_DataTable = this.dom.DataTable(this.dataTableSource);

        // Row Click Event
        var arrayClickEvent = this.arrayClickEvent;
        this.dom.children('tbody').on('click', 'td', function () {
            var idxColumn = $(this).index();
            var idxViewRow = $(this).parent("tr").index();
            var idxRealRow = g_DataTable.row($(this).parent("tr")).index();
            var data = g_DataTable.row($(this).parent("tr")).data();


            if(!isEmpty(arrayClickEvent[idxColumn])){
                arrayClickEvent[idxColumn](data, idxViewRow, idxColumn, idxRealRow);
                return;
            }

            if(!isEmpty(arrayClickEvent["-1"])){
                arrayClickEvent["-1"](data, idxViewRow, idxColumn, idxRealRow);
                return;
            }
        });

        // 상단 CheckBox 전체 선택 Event
        allCheckBox.on('click', function () {
            var rows = this.dom.DataTable().rows({ 'search': 'applied' }).nodes();
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
        });

        // 전체 선택 이후 하위 CheckBox 해제 시 상단 CheckBox UI 변경 Event
        this.dom.children('tbody').on('change', 'input[type="checkbox"]', function () {
            if (!this.checked) {
                var el = allCheckBox.get(0);

                if (el && el.checked && ('indeterminate' in el)) {
                    el.indeterminate = true;
                }
            }
        });
    }

    //
    // DalbitDataTable.prototype.createPage = function (totalData, currentPage){
    //     this.dom.parent("#list_info_wrapper").find("#list_info_paginate").remove();
    //
    //     var dataPerPage = this.dataTableSource.pageLength;
    //     var pageCount =  5;
    //
    //
    //     console.log("currentPage 단위 : " + currentPage);
    //     var totalPage = Math.ceil(totalData/dataPerPage);    // 총 페이지 수
    //     var pageGroup = Math.ceil(currentPage/pageCount);    // 페이지 그룹
    //     console.log("pageGroup 페이지 그룹: " + pageGroup);
    //     var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호
    //     if(last > totalPage)
    //         last = totalPage;
    //     var first = last - (pageCount-1);    // 화면에 보여질 첫번째 페이지 번호
    //     var next = last+1;
    //     var prev = first-1;
    //     console.log("last 마지막 페이지 번호 : " + last);
    //     console.log("first 화면에 보여질 첫번쨰 페이지 번호: " + first);
    //     console.log("next 다음 : " + next);
    //     console.log("prev 이전 : " + prev);
    //     // var $pingingView = $("#paging");
    //
    //     var html = '<div class="dataTables_paginate paging_simple_numbers text-center" id="list_info_paginate">'
    //                 + '     <ul class="pagination">';
    //
    //     if(prev > 0)
    //         html += '           <li class="paginate_button previous " aria-controls="list_info" tabindex="0" id="list_info_previous">'
    //                 + '                 <a href="#"  id="prev">이전</a>'
    //                 + '            </li>';
    //     for(var i=first; i <= last; i++){
    //         if(i == currentPage){
    //             html += '        <li class="paginate_button active" aria-controls="list_info" tabindex="0">'
    //                 + '                 <a href="#"  id=' + i + '>' + i + '</a>'
    //                 + '            </li>';
    //         }else{
    //             html += '        <li class="paginate_button " aria-controls="list_info" tabindex="0">'
    //                 + '                 <a href="#"  id=' + i + '>' + i + '</a>'
    //                 + '            </li>';
    //         }
    //     }
    //     if(last < totalPage)
    //         html += '           <li class="paginate_button next" aria-controls="list_info" tabindex="0" id="list_info_next">'
    //                 + '                 <a href="#"  id="next">다음</a>'
    //                 + '            </li>';
    //
    //     this.dom.parent("#list_info_wrapper").append(html);    // 페이지 목록 생성
    //
    //     var dalbitDataTable = this;
    //     this.dom.parent("#list_info_wrapper").find("#list_info_paginate a").click(function(){
    //         var $item = $(this);
    //         var $id = $item.attr("id");
    //         var selectedPage = $item.text();
    //         if($id == "next")    selectedPage = next;
    //         if($id == "prev")    selectedPage = prev;
    //         // dalbitDataTable.createPage(totalData, selectedPage);
    //
    //
    //         this.selectPage = selectedPage;
    //         this.endCnt = selectedPage * dataPerPage;
    //         this.startCnt = this.endCnt - (dataPerPage -1);
    //
    //         // dalbitDataTable.dataTableSource.ajax.data.endCnt = this.endCnt;
    //         // dalbitDataTable.dataTableSource.ajax.data.startCnt = this.startCnt;
    //         // dalbitDataTable.dataTableSource.ajax.data.selectPage = this.selectPage;
    //
    //         console.log("start : {}/ end : {}", this.startCnt, this.endCnt);
    //
    //         dalbitDataTable.reload();
    //         // var obj = new Object();
    //         // obj.total = totalData;
    //         // obj.datapage = dataPerPage;
    //         // obj.pagecount = pageCount;
    //         // obj.selectedpage = selectedPage;
    //
    //         // getAjaxData("paging", "/rest/member/member/paging",obj, fn_code_success, fn_fail);
    //     });
    // }





/* === Option =================================================================*/

    // DataTable Reload / Ajax 재호출
    DalbitDataTable.prototype.reload = function () {
        this.dom.DataTable().ajax.reload();
    }

    // DataTable Reload / Url, Data, Columns 초기화 후 Reload (기존 테이블 변경  시 사용)
    DalbitDataTable.prototype.changeReload = function (url, data, columnsInfo, initFn){
        if(!isEmpty(this.g_DataTable)){this.dom.DataTable().destroy();}
        this.dom.empty();

        if(!isEmpty(url)) {
            this.dataTableSource.ajax.url = url;
        }

        if(!isEmpty(data)) {
            this.dataTableSource.ajax.data = data;
        }

        var infoUrl = columnsInfo.url;
        var columnDefs = columnsInfo.columnDefs;
        var columns = columnsInfo.columns;

        if(!isEmpty(infoUrl)){
            this.dataTableSource.ajax.url = infoUrl;
        }

        if(!isEmpty(columnDefs)) {
            if(!isEmpty(this.dataTableSource.columnDefs)){
                this.dataTableSource.columnDefs = this.dataTableSource.columnDefs.slice(0,2);
                this.dataTableSource.columnDefs = this.dataTableSource.columnDefs.concat(columnDefs);
            }

            if(!isEmpty(this.dataTableSource.aoColumnDefs)){
                this.dataTableSource.aoColumnDefs = this.dataTableSource.aoColumnDefs.slice(0,2);
                this.dataTableSource.aoColumnDefs = this.dataTableSource.aoColumnDefs.concat(columnDefs);
            }
        }

        if(!isEmpty(columns)) {
            if(!isEmpty(this.dataTableSource.columns)){
                this.dataTableSource.columns = this.dataTableSource.columns.slice(0,2);
                this.dataTableSource.columns = this.dataTableSource.columns.concat(columns);
            }

            if(!isEmpty(this.dataTableSource.aoColumns)){
                this.dataTableSource.aoColumns = this.dataTableSource.aoColumns.slice(0,2);
                this.dataTableSource.aoColumns = this.dataTableSource.aoColumns.concat(columns);
            }
        }

        this.createDataTable(initFn);
    }

    DalbitDataTable.prototype.destroy = function(){
        if(!isEmpty(this.g_DataTable)){
            this.dom.DataTable().destroy();
        }
    }





/* === Getter =================================================================*/

    /* DataTable Source  */
    DalbitDataTable.prototype.getSource = function () {
        return this.dataTableSource;
    };

    /* getData(Array) from CheckBox  */
    DalbitDataTable.prototype.getCheckedData = function (){
        var arrayData = new Array;

        this.dom.children('tbody').find('input[type="checkbox"]').each(function () {
            if (this.checked) {
                var data = this.dom.DataTable().row($(this).parent("td").parent("tr")).data();
                arrayData.push(data);
            }
        });

        return arrayData;
    }

    /* get Row Idx Data  */
    DalbitDataTable.prototype.getDataRow = function (idxRow) {
        dalbitLog(this.dom.DataTable().row(idxRow).data());
        return this.dom.DataTable().row(idxRow).data();
    }

    /* get Rows Size  */
    DalbitDataTable.prototype.getRowSize = function(){
        dalbitLog(this.dom.DataTable().row()[0].length);
        return this.dom.DataTable().row()[0].length;
    }





/* === Setter =================================================================*/

    /* DataTable Source  */
    DalbitDataTable.prototype.setSource = function (dataTableSource) {
        this.dataTableSource = dataTableSource;
    };

    /* set Ajax URL  */
    DalbitDataTable.prototype.setURL = function (url) {
        this.dataTableSource.ajax.url = url;
    }

    /* set Use CheckBox  */
    DalbitDataTable.prototype.useCheckBox = function (isUse) {
        this.isUseCheckbox = isUse;
    }

    /* set Use Index  */
    DalbitDataTable.prototype.useIndex = function (isUse) {
        this.isUseIndex = isUse;
    }

    DalbitDataTable.prototype.setPageLength = function(pageLength){
        this.dataTableSource.pageLength = pageLength;
    }

    /* set Search Visible */
    DalbitDataTable.prototype.useSearch = function (isUse) {
        this.dataTableSource.searching = isUse;
    }

    /* set Row Click Event 함수 지정, 이벤트 column 지정 */
    DalbitDataTable.prototype.setEventClick = function (eventFnc, column) {
        if(isEmpty(eventFnc)){
            dalbitLog("[DalbitDataTable.prototype.setEventClick] eventFnc is Null!!");
            return;
        }

        var inputEvent = this.arrayClickEvent;

        if(!isEmpty(column)){
            var arrayColumn = column.toString().split(",");

            for(var idx=0; idx < arrayColumn.length; idx++){
                inputEvent[(arrayColumn[idx])] = eventFnc;
            }
        }else{
            inputEvent["-1"] = eventFnc;
        }

        this.arrayClickEvent = inputEvent;
    }