<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <div class="col-md-12 no-padding" id="jsonData" style="height: 400px">
        <input type="file" id="file" onchange="jsonDataExcel()">
        <textarea type="textarea" class="form-control" id="txt_jsonData" name="txt_jsonData" style="width: 100%; height: 90%"></textarea>
        <div id="div_gridData"></div>
    </div>
</div>

<script type="text/javascript" src="/js/excel.min.js?${dummyData}"></script>
<script type="text/javascript" src="/js/xlsx.full.min.js?${dummyData}"></script>

<script>
    $(document).ready(function() {

    });

    function jsonDataExcel() {
        let input = event.target;
        let reader = new FileReader();
        reader.onload = function () {
            let data = reader.result;
            let workBook = XLSX.read(data, { type: 'binary' });
            workBook.SheetNames.forEach(function (sheetName) {
                console.log('SheetName: ' + sheetName);
                let rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName]);
                console.log(rows);                      // array
                console.log(JSON.stringify(rows));      // json

                $("#txt_jsonData").val(JSON.stringify(rows));
            })
        };
        reader.readAsBinaryString(input.files[0]);
    }

    var test1 = null, test2 = null;
    function gridExcelToWeb(file, target){
        var reader = new FileReader();

        reader.onload = function (evt) {
            if (evt.target.readyState == FileReader.DONE) {
                var data = evt.target.result;  //해당 데이터, 웹 서버에서 ajax같은거로 가져온 blob 형태의 데이터를 넣어주어도 동작 한다.
                data = new Uint8Array(data);
                var workbook = XLSX.read(data, { type: 'array' });
                var sheetName = '';
                workbook.SheetNames.forEach( function(data, idx){   //시트 여러개라면 이 안에서 반복문을 통해 돌리면 된다.
                    if(idx == 0){
                        sheetName = data;
                    }
                });
                test1 = workbook;

                var toHtml = XLSX.utils.sheet_to_html(workbook.Sheets[sheetName], { header: '' });

                target.html(toHtml);
                target.find('table').attr({class:'table table-bordered',id:'excelResult'});  //id나 class같은거를 줄 수 있다.
                test2 = toHtml;
                $('#excelResult').find('tr').each(function(idx){
                    if(idx == 0 ){
                        $(this).css({'background-color':'#969da5a3'});
                    }
                });
            }
        };
        reader.readAsArrayBuffer(file);
    }

    $('#file').change( function(){
        const selectedFile = $(this)[0].files[0];
        gridExcelToWeb(selectedFile,  $('#div_gridData'))
    });

</script>
