/**
 * 공통 자바스크립트 유틸
 */
var util = {};

/* 새창 띄우기 */
util.windowOpen = function(data, width, height, name){
    var url = '';
    if (typeof (data) == 'object') {
        url = data.url;
        width = data.width;
        height = data.height;
        name = data.name;
    } else {
        url = data;
    }
    name = name || 'popup';

    var left = (window.screen.width / 2) - (width / 2);
    var top = (window.screen.height / 2) - (height / 2);

    window.open(url, name, 'width=' + width + ' height=' + height + ' scrollbars=yes left=' + left + 'top=' + top);
}
// /*ajax 호출 모듈*/
// getAjaxData(dst_id, dst_url, dst_params, successFunc, errorFunc) {
//     var common = this;
//     $.ajax({
//         type: 'POST',
//         url: dst_url,
//         dataType: 'json',
//         data: dst_params,
//         async: true,
//     }).done(function (data) {
//         if (successFunc != null) successFunc(dst_id, data);
//     }).fail(function (data, textStatus, jqXHR) {
//         try {
//             if (errorFunc != null) {
//                 errorFunc(data, textStatus, jqXHR);
//             } else {
//                 common.commonAjaxError(data, textStatus, jqXHR);
//             }
//         } catch (e) {
//             // function call fail skip
//             alert(e);
//             //showAlert('A', e);
//         }
//     });
// },

    /*ajax 호출 모듈*/
util.getAjaxData = function(dst_id, dst_url, dst_params, successFunc, errorFunc, option, isViewLoading) {

    if(common.isEmpty(isViewLoading) || isViewLoading){$('body').addClass('dalbit_module_loading')};

    var commonUtil = this;
    var isEmptyOption = common.isEmpty(option)

    $.ajax({
        beforeSend : function(xhr){

        },
        header: {

        },
        type: isEmptyOption ? 'POST' : common.isEmpty(option.type) ? 'POST' : option.type,
        url: dst_url,
        dataType: isEmptyOption ? 'json' : common.isEmpty(option.dataType) ? 'json' : option.dataType,
        data: dst_params,
        async: true,
        xhrFields: {
            withCredentials: true
        },
        crossDomain: true
    }).done(function (data) {
        if(common.isEmpty(isViewLoading) || isViewLoading){$('body').removeClass('dalbit_module_loading')};

        if (successFunc != null){
            dalbitLog("[ajax 통신 결과]url : " + dst_url);
            dalbitLog(data);

            successFunc(dst_id, data, dst_params);
        }
    }).fail(function (data, textStatus, jqXHR) {
        if(common.isEmpty(isViewLoading) || isViewLoading){$('body').removeClass('dalbit_module_loading')};
        try {
            if (errorFunc != null) {
                errorFunc(data, textStatus, jqXHR);
            } else {
                commonUtil.commonAjaxError(data, textStatus, jqXHR);
            }
        } catch (e) {
            // function call fail skip
            alert(e);
            //showAlert('A', e);
        }
    });
}

util.commonAjaxError = function(data, textStatus, jqXHR) {
    try {
        console.log(data);
        if (textStatus == 'parsererror' && 0 < data.responseText.indexOf('로그인')) {
            alert('세션이 만료되어 로그인 페이지로 이동합니다.');
            location.href = '/login';
        }
    } catch (e) {

    }
}

/*파일 업로드 호출 모듈*/
util.fileUpdate = function(dst_url, dst_params, successFunc, errorFunc) {
    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: dst_url,
        data: dst_params,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
    }).done(function (data) {
        if (successFunc != null) successFunc(data);
    }).fail(function (data, textStatus, jqXHR) {
        try {
            if (errorFunc != null) errorFunc(data, textStatus, jqXHR);
        } catch (e) {
            // function call fail skip
            alert(e);
            //showAlert('A', e);
        }
    });
},

util.changeLoadingBtn = function(btn, status, text) {
    var text = common.isEmpty(text) ? "Loading..." : text;

    if (status == 'loading' || status == 'start') {
        btn.data('afterText', btn.html());
        btn.empty().append('<i class="fa fa-refresh fa-spin"></i> ' + text);
        btn.prop('disabled', true);
    }

    if (status == 'reset' || status == 'stop') {
        btn.empty().append(btn.data('afterText'));
        btn.prop('disabled', false);
    }
},

/* Excell DownLoad 모듈*/
util.excelDownload = function(btn, url, data, successFunc, errorFunc) {
    // btn.button('loading');
    util.changeLoadingBtn(btn, 'loading', 'DownLoading...');
    //btn.button('loading');

    var sendData = data;
    if (data instanceof FormData) {
        sendData = {};
        data.forEach(function (value, key) {
            sendData[key] = value;
        });
    }

    $.fileDownload(url, {
        httpMethod: "POST",
        data: sendData,
        successCallback: function (url, data) {
            console.log("[exceldown 통신 결과]url : " + url);
            console.log(data);
            setTimeout(function () {
                // btn.button('reset');
                util.changeLoadingBtn(btn, 'reset');
            }, 500)
        },
        failCallback: function (responseHtml, url, data) {
            setTimeout(function () {
                // btn.button('reset');
                util.changeLoadingBtn(btn, 'reset');
            }, 500)
        }
    })
        .done(function (data) {
            if (successFunc != null) successFunc(data);
        })
        .fail(function (data) {
            if (errorFunc != null) errorFunc(data);
        });
},

    /**
     *  var formElement = document.querySelector("form");
     *  var formJson = util.formArrayToJson($(formElement));
     *
     * */
util.formArrayToJson = function(domForm){
    var obj = null;

    try {
        // this[0].tagName이 form tag일 경우
        if(domForm[0].tagName && domForm[0].tagName.toUpperCase() == "FORM" ) {
            var arr = domForm.serializeArray();
            if(arr){
                obj = {};
                jQuery.each(arr, function() {
                // obj의 key값은 arr의 name, obj의 value는 value값
                    obj[this.name] = this.value;
                });
            }
        }
    }catch(e) {
        alert(e.message);
    }finally  {}
    return obj;
},


/* 이미지 팝업 */
util.imagePopup = function(obj) {
    var url = obj.src;
    var title = obj.id;
    var option = "width=" + (obj.width + 20) + ", height=" + (obj.height + 20) + ",fullscreen=yes";

    window.open(url, title, option);
},

util.popupLink = function(display, url, width, height) {
    var template = '<a href="javascript://" class="_openPop" data-url="' + url + '" data-width="'+ width +'" data-height="'+ height +'">' + display + '</a>';
    return template;
},

util.memNoLink = function(display, memNo) {
    var template = '<a href="javascript://" class="_openMemberPop" data-memNo="' + memNo + '">' + display + '</a>';
    return template;
},

util.pushSendLink = function(memNoList, buttonVal) {
    $('#' + buttonVal).data('mem_no_list', memNoList);
    $('#' + buttonVal).addClass('_openSendPushPop');
},

util.memNoLink_sex = function(display, memNo, sex) {
    var template;
    if(sex == "m"){
        template = '<a href="javascript://" class="_openMemberPop" data-memNo="' + memNo + '" style="color: blue">' + display + '</a>';
    }else if(sex == "f"){
        template = '<a href="javascript://" class="_openMemberPop" data-memNo="' + memNo + '" style="color: red">' + display + '</a>';
    }else if(sex == "n"){
        template = '<a href="javascript://" class="_openMemberPop" data-memNo="' + memNo + '" style="color: #555555">' + display + '</a>';
    }
    return template;
},

util.roomNoLink = function(display, roomNo) {
    var template = '<a href="javascript://" class="_openBroadcastPop" data-roomNo="' + roomNo + '">' + display + '</a>';
    return template;
},

util.getCommonCodeSelect = function(code, targetCode, isExcludeAllYn, name) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {

        var header = targetCode[0];
        var selectName = common.isEmpty(name) ? header.value : name;
        var html = '<select id="' + selectName + '" name="' + selectName + '" class="form-control searchType">';
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {

                if (isExcludeAllYn == 'Y' && (value.type == 'all' || value.type == -1)) {
                    return;
                }

                html += '<option value="' + value.value + '" ' + (value.value == code ? 'selected="selected"' : '') + '>' + value.code + '</option>';
            }
        });
        html += '</select>'
        return html;
    }
},

util.getCommonCodeSelectForName = function(codeName, targetCode, isExcludeAllYn, name) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {

        var header = targetCode[0];
        var selectName = common.isEmpty(name) ? header.value : name;
        var html = '<select id="' + selectName + '" name="' + selectName + '" class="form-control searchType">';
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {

                if (isExcludeAllYn == 'Y' && (value.type == 'all' || value.type == -1)) {
                    return;
                }
                html += '<option value="' + value.value + '" ' + (value.code == codeName ? 'selected="selected"' : '') + '>' + value.code + '</option>';
            }
        });
        html += '</select>'
        return html;
    }
},

util.getCommonCodeRadio = function(code, targetCode, isExcludeAllYn, name) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {

        var header = targetCode[0];
        var html = '';
        var radioName = common.isEmpty(name) ? header.value : name;
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {

                if (isExcludeAllYn == 'Y' && (value.type == 'all' || value.type == -1)) {
                    return;
                }
                html += '<label class="control-inline fancy-radio custom-color-green">';
                html += '<input type="radio" value="' + value.value + '" id="' + radioName + value.value + '" name="' + radioName + '" class="form-control" ' + (value.value == code ? 'checked="checked"' : '') + '/>';
                html += '<span><i></i>' + value.code + '</span>'
                html += '</label>';
            }
        });
        return html;
    }
},

/**
 * 여러개 등록 할 시
 */
util.getCommonCodeRadioMulti = function(code, targetCode, isExcludeAllYn, name, order) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {

        var header = targetCode[0];
        var html = '';
        var radioName = common.isEmpty(name) ? header.value : name;
        targetCode.forEach(function (value, index) {
            if (!common.isEmpty(value.type)) {

                if (isExcludeAllYn == 'Y' && (value.type == 'all' || value.type == -1)) {
                    return;
                }
                html += '<label class="control-inline fancy-radio custom-color-green">';
                html += '<input type="radio" value="' + value.value + '" id="'+ order + '_' + radioName + index +'" name="' + radioName + '_' + order + '" class="form-control '+radioName+'" ' + (value.value == code ? 'checked="checked"' : '') + '/>';
                html += '<span><i></i>' + value.code + '</span>'
                html += '</label>';
            }
        });
        return html;
    }
},

util.getCommonCodeCheck = function(code, targetCode, isExcludeAllYn, name) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {

        var header = targetCode[0];
        var html = '';
        var checkName = common.isEmpty(name) ? header.value : name;
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {

                if (isExcludeAllYn == 'Y' && (value.type == 'all' || value.type == -1)) {
                    return;
                }
                html += '<label class="control-inline fancy-checkbox custom-color-green">';
                html += '<input type="checkbox" value="' + value.code + '" id="' + checkName + value.value + '" name="' + checkName + '" class="form-control" ' + (value.value == code ? 'checked="checked"' : '') + '/>';
                html += '<span><i></i>' + value.code + '</span>'
                html += '</label><br/>';
            }
        });
        return html;
    }
},

util.getCommonCodeCheck2 = function(code, targetCode, isExcludeAllYn, name) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {

        var header = targetCode[0];
        var html = '';
        var checkName = common.isEmpty(name) ? header.value : name;
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {

                if (isExcludeAllYn == 'Y' && (value.type == 'all' || value.type == -1)) {
                    return;
                }
                html += '<label class="control-inline fancy-checkbox custom-color-green">';
                html += '<input type="checkbox" value="' + value.value + '" id="' + checkName + '_' + value.value + '" name="' + checkName + '" class="form-control" ' + (value.value == code ? 'checked="checked"' : '') + '/>';
                html += '<span><i></i>' + value.code + '</span>'
                html += '</label>';
            }
        });
        return html;
    }
},

util.getCommonCodeHorizontalCheck = function(code, targetCode, isExcludeAllYn, name) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {

        var header = targetCode[0];
        var html = '';
        var checkName = common.isEmpty(name) ? header.value : name;
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {

                if (isExcludeAllYn == 'Y' && (value.type == 'all' || value.type == -1)) {
                    return;
                }
                html += '<label class="control-inline fancy-checkbox custom-color-green">';
                html += '<input type="checkbox" value="' + value.code + '" id="' + checkName + value.value + '" name="' + checkName + '" class="form-control" ' + (value.value == code ? 'checked="checked"' : '') + '/>';
                html += '<span><i></i>' + value.code + '</span>'
                html += '</label>';
            }
        });
        return html;
    }
},

util.getOnOffSwitch = function(data, name) {
    var checkName = name == null ? 'viewOn' : name;

    var html = '<div class="onoffswitch">';
    html += '<input type="checkbox" name="'+checkName+'" id="detail_'+checkName+'" class="onoffswitch-checkbox" ' + (data == 1 ? 'checked="checked"': '') +'>';
    html += '<label class="onoffswitch-label" for="detail_'+checkName+'">';
    html += '<span class="onoffswitch-inner"></span>';
    html += '<span class="onoffswitch-switch"></span>';
    html += '</label>';
    html += '</div>';

    return html;
},

util.getCommonCodeLabel = function(code, targetCode) {
    var targetCodeName = targetCode;

    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {
        var html = "";
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {
                if (code == value.value) {
                    html = '<lable id = "' + targetCodeName + '">' + value.code + '</lable>';
                }
            }
        });
        return html;
    }
},

util.getCommonCodeText = function(code, targetCode) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {
        var codeText = "";
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {
                if (code == value.value) {
                    codeText = value.code + "";
                    console.log(codeText);
                }
            }
        });
        return codeText;
    }
},

util.getCommonCodeLabelAndHidden = function(code, targetCode, name) {
    targetCode = eval(targetCode);
    if (!common.isEmpty(targetCode)) {
        var html = "";
        var header = targetCode[0];
        var checkName = common.isEmpty(name) ? header.value : name;
        targetCode.forEach(function (value) {
            if (!common.isEmpty(value.type)) {
                if (code == value.value) {
                    html = '<lable>' + value.code + '</lable>';
                    html += '<input type="hidden" id="' + checkName + value.value + '" name="' + checkName + '" value="' + value.value + '"/>';
                }
            }
        });
        return html;
    }
},

util.replaceNewLineToBr = function(text){
    text = text.split("\\n").join("<br />");
    text = text.split("\n").join("<br />");
    text = text.split("\\r").join("");
    text = text.split("\r").join("");
    text = text.split("\\t").join("&nbsp;&nbsp;&nbsp;&nbsp;");
    text = text.split("\t").join("&nbsp;&nbsp;&nbsp;&nbsp;");
    return text;
},

util.renderOnOff = function(value){
    if(value == 1){
        return ' <i class="fa fa-circle"></i>' + " ON" ;
    }else{
        return ' <i class="fa fa-circle-o"></i>' + " OFF" ;
    }
},

util.renderSlct = function(value,size){
    var facebook = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAYAAABV7bNHAAAABHNCSVQICAgIfAhkiAAAAdtJREFUeF7tmT1Ow0AQRr8NNFTkAEjQ0NOBnAKOQENNOhokxAWcxFRUIHEAfmoKToBonBtQQ80JoMkiItFhT+yJlWC9tJnZZJ/fN2snQbxKCQT4lBMAkGEIgADkGyIYhEEY5COAQT5+zCAMwiAfgX9j0M6wq7VwrE44lHRQadd52tioaGzhShtMsr5CvJJCt1Lfb3GrAU3h6LYWmNYD2htuaaXz5oLz09xag5LRtUI4A1ARgSR7UdA+gIoBvStoE0BFBHpZdMNp9QyaHdC58vR6LjArLrLY+6CZAMV75YN+xX3NrXz5AcU40ngwnNuOKy4EoKV+FpslYhhkXMLWA0qyS0knBRjWzZEQ9KWoz8K6EJ+aHOLNz6BediPp1ARRtyDqUeP0qG671QeghQ9pDDIuAYAAZM2x8vcxCIMwyEfA6N692NbqZOPvqvBsf/bkQQp3xXXhQ3n6aq9Tr6L5+6Cy78WzmDmf7F8UW/8shkH1sj3tImJEzKEPBtnwiBgRsy3hFHMwImJEzKEPp5gNj4gRMdsSTjEHIyJGxBz6cIrZ8IgYEbMt4RRzMCJiRMyhD6eYD96SdC/2j8MlgVD2NQBkXCQAAciXYwzCIAzyEcAgHz9mEAZhkI+A0f0NQ1cCWJ3K67UAAAAASUVORK5CYII=";
    var kakao = "data:image/png;base64,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";
    var naver = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABICAYAAABV7bNHAAAABHNCSVQICAgIfAhkiAAAAmlJREFUeF7tmk9O20AUxr8JzQ5UbgDdIf6ozQmAZUUsyEkaTgA9QekNegOQEsSy4QRYwq1Y5giRWAJ51RgHRRG2Z/JcRMZflvGbxPPz73tjT2LAVyEBQz7FBAioxBACIiBdE6FBNIgG6QjQIB0/9iAaRIN0BGiQjh97EA2iQToCb2XQTh/ie6Yi2E8iDFzGbfewZwx+u9ROakRwnUTY8xkzW1tZD5oHEIDh/QNaww5GZZOoKyCI4GcSoUtARQQEndsIF0UltTUohSIY3T/iU1HU6g3IMhJcJBE6eRbVHlBmUm7UCKgkagSUZUuAQdLG/mzUCGiKyBg4/tPG2TQkApqmIRg9fEDr7iuGk7cJaCZTs1EjoFfWdxF8TyKc2kMElHMD9GTQ+nuAmIByAAkQJ220CKjgQcxGDcCgjtsdZQ/xL8ft0t8AfjgPeH58Wdz9IHvyAFaNwWefSfvULjygcQPdJcGNz6R9ahcekN0O3e7h1Bic+EzctTYIQNk9Tvw/ohYMoM1LfFmSdPP+o6sdLnXBALKT3eqj67tKlUEKClAWNXuvs1s2cdfjwQHauMJ68wlxVVELDlDVUQsSkIW0009/Ajp0jVJeXbCA1s+xutJMN8tUq1qwgFKLejiCwbnGoqABVRG14AHZqC03ERtgbR6Tggc071brBGYtAGWQzozBN1+LagNo3qi9K0B228LnCpsGhrcH+OU6xj7QNsY4cq23db7f8dpnV/YPM58TX6RaAiq5WgREQLpA0yAaRIN0BGiQjh97EA2iQToCNEjHjz2IBtEgHQEapOPHHkSDaJCOAA3S8WMPKuH3DwyRmVjcb97VAAAAAElFTkSuQmCC";
    var apple = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIzNiIgaGVpZ2h0PSIzNiIgdmlld0JveD0iMCAwIDM2IDM2Ij4KICAgIDxnIGlkPSJwcmVmaXhfX+q3uOujuV8yNyIgZGF0YS1uYW1lPSLqt7jro7kgMjciIHRyYW5zZm9ybT0idHJhbnNsYXRlKC00MDMuMTcgLTE5MC43MykiPgogICAgICAgIDxwYXRoIGlkPSJwcmVmaXhfX+yCrOqwge2YlV8yMCIgZD0iTTAgMEgzNlYzNkgweiIgZGF0YS1uYW1lPSLsgqzqsIHtmJUgMjAiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDQwMy4xNyAxOTAuNzMpIiBzdHlsZT0iZmlsbDojZmZmO29wYWNpdHk6MCIvPgogICAgICAgIDxnIGlkPSJwcmVmaXhfX+q3uOujuV8xMzU0NiIgZGF0YS1uYW1lPSLqt7jro7kgMTM1NDYiIHRyYW5zZm9ybT0idHJhbnNsYXRlKDUyLjY5OSAtOC4yMTkpIj4KICAgICAgICAgICAgPGcgaWQ9InByZWZpeF9f6re466O5XzEzNTQ1IiBkYXRhLW5hbWU9Iuq3uOujuSAxMzU0NSIgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMzU5LjA1NCAyMDUuOTM1KSI+CiAgICAgICAgICAgICAgICA8cGF0aCBpZD0icHJlZml4X1/tjKjsiqRfNDE0NCIgZD0iTTM3NC4yMjggMjUyLjYyOGE1LjAzOCA1LjAzOCAwIDAgMSAyLjQwOC00LjI0MSA1LjIyMiA1LjIyMiAwIDAgMC00LjA3Ni0yLjIxN2MtMS43MzktLjE3NS0zLjM5NCAxLjAyNS00LjI3MyAxLjAyNXMtMi4yNDMtMS0zLjY4MS0uOTY4YTUuNDYgNS40NiAwIDAgMC00LjYxNyAyLjc5NGMtMS45NjcgMy40MTQtLjUwNSA4LjQ3NCAxLjQxNiAxMS4yNDIuOTM2IDEuMzU1IDIuMDUyIDIuODc3IDMuNTE3IDIuODIzIDEuNDE2LS4wNTUgMS45NS0uOTEzIDMuNjU4LS45MTNzMi4xODguOTEzIDMuNjg0Ljg5YzEuNTE5LS4wMzIgMi40ODQtMS4zODcgMy40MTEtMi43NDJhMTIuMzcgMTIuMzcgMCAwIDAgMS41NDYtMy4xNzYgNC45MjEgNC45MjEgMCAwIDEtMi45OTMtNC41MTd6IiBkYXRhLW5hbWU9Iu2MqOyKpCA0MTQ0IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtMzU5LjA1NCAtMjQwLjc3NykiLz4KICAgICAgICAgICAgICAgIDxwYXRoIGlkPSJwcmVmaXhfX+2MqOyKpF80MTQ1IiBkPSJNNDI5LjkyNCAyMDkuNWE0Ljg5MyA0Ljg5MyAwIDAgMCAxLjE2MS0zLjU2MSA1IDUgMCAwIDAtMy4yODMgMS42ODggNC42NzQgNC42NzQgMCAwIDAtMS4xODYgMy40NTQgNC4xNDEgNC4xNDEgMCAwIDAgMy4zMDgtMS41ODF6IiBkYXRhLW5hbWU9Iu2MqOyKpCA0MTQ1IiB0cmFuc2Zvcm09InRyYW5zbGF0ZSgtNDE3LjU2MiAtMjA1LjkzNSkiLz4KICAgICAgICAgICAgPC9nPgogICAgICAgIDwvZz4KICAgIDwvZz4KPC9zdmc+Cg==";
    if(size != ""){
        if(value == "p"){
            return '<i class="fa fa-phone" style="color: #8556F6;' + "font-size: " + size + 'px"></i>';
        }else if (value == "f"){
            return '<img src="' + facebook + '" style="width: ' + size +'px;height:' + size +'px">';
        }else if (value == "g"){
            return '<i class="fa fa-google" style="color: #ff0004;' + "font-size: " + size + 'px"></i>';
        }else if (value == "k"){        // 아이콘 추가 해야됨
            return '<img src="' + kakao + '" style="width: ' + size +'px;height:' + size +'px">';
        }else if (value == "n"){        // 아이콘 추가 해야됨
            return '<img src="' + naver + '" style="width: ' + size +'px;height:' + size +'px">';
        }else if (value == "i"){        // 아이콘 추가 해야됨
            return '<img src="' + apple + '" style="width: ' + size +'px;height:' + size +'px">';
        }
    }else{
        if(value == "p"){
            return '<img src="' + facebook + '">';
        }else if (value == "f"){
            return '<i class="fa fa-facebook-square" style="color: #0064ff;"></i>';
        }else if (value == "g"){
            return '<i class="fa fa-google" style="color: #ff0004;"></i>';
        }else if (value == "k"){        // 아이콘 추가 해야됨
            return '<img src="' + kakao + '">';
        }else if (value == "n"){        // 아이콘 추가 해야됨
            return '<img src="' + naver + '">';
        }else if (value == "i"){        // 아이콘 추가 해야됨
            return '<img src="' + apple + '">';
        }
    }
},

/*에디터 type:이미지 타입*/
util.editorInit = function(type) {
    var targetEditor = $('._editor');

    targetEditor.summernote({
        lang: 'ko-KR',
        height: '500px',
        focus: false,
        callbacks: { // 콜백을 사용
            // 이미지를 업로드할 경우 이벤트를 발생
            onImageUpload: function (files, editor, welEditable) {
                //console.log("[onImageUpload]")

                var formData = new FormData();
                formData.append("file", files[0]);
                formData.append("uploadType", type);    //ex) type : notice-detail
                util.fileUpdate(EDITOR_PHOTO_SERVER_URL + "/upload", formData, function (data) {
                    var json = jQuery.parseJSON(data);
                    //console.log(json);
                    if (json.code != "0") {
                        alert(json.message);
                        return;
                    }

                    // UPLOAD IMAGE URL 적용
                    var imgURL = json.data.url;
                    targetEditor.summernote('editor.insertImage', imgURL);
                });
            }
        }
    });
},
util.imageFullSize = function(modalId ,url){
    var html = '<div class="modal fade" id="'+ modalId +'" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">';
        html+=      '<div class="modal-dialog" style="max-width: 100%; width: auto; display: table;">';
        html+=          '<div class="modal-content">';
        html+=              '<div class="modal-header no-padding">';
        html+=                  '<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>';
        html+=                  '<button id="rotateL" ><i class="fa fa-undo"></i></button>';
        html+=                  '<button id="rotateR" ><i class="fa fa-repeat"></i></button>';
        html+=              '</div>';
        html+=              '<div class="modal-body no-padding">';
        html+=                  '<img class="image_full_size" id="image_full_size" src="'+ url + '" alt="your image" style="max-width: 1000px;max-height: 1000px;" onclick=util.fullSize_modal_close();>';
        html+=              '</div>';
        html+=          '</div>';
        html+=      '</div>';
        html+= '</div>';
    return html;
},

util.fullSize_background = function(url){
    if(common.isEmpty(url)){
        return;
    }
    $("#imageFullSize").html(util.imageFullSize("fullSize_background", url));
    $('#fullSize_background').modal('show');

    var angle = 0;
    $('#rotateL').click(function() {
        angle += -15;
        $('#image_full_size').css('transform','rotate(' + angle + 'deg)');
    });

    $('#rotateR').click(function() {
        angle += +15;
        $('#image_full_size').css('transform','rotate(' + angle + 'deg)');
    });
},

util.fullSize_modal_close = function(){
    $("#fullSize_background").modal('hide');
}

util.renderPagingNavigation = function(targetId, pagingInfo){

    if(0 <= pagingInfo.totalCnt) {
        var totalPage;
        var startPage;
        var endPage;

        if(pagingInfo.totalCnt < pagingInfo.pageCnt){
            totalPage = 1;
        }else if(pagingInfo.totalCnt % pagingInfo.pageCnt == 0){
            totalPage = Math.floor(pagingInfo.totalCnt / pagingInfo.pageCnt);
        }else{
            totalPage = Math.floor(pagingInfo.totalCnt / pagingInfo.pageCnt) + 1;
        }

        if(totalPage <= 10){
            startPage = 1;
            endPage = totalPage;
        }else{
            startPage = Math.floor((pagingInfo.pageNo-1) / 10) * 10 + 1;
            endPage = startPage + 10 - 1;
            if(totalPage < endPage){
                endPage = totalPage;
            }
        }

        var pagingPrefix = '<ul class="pagination borderless handlebarsPaging">';
        pagingPrefix += '<li class="paginate_button first '+ (pagingInfo.pageNo == 1 ? 'disabled' : '')+'" aria-controls="list_info" tabindex="0" id="list_info_first" data-index="1"><a href="#">처음</a></li>';
        pagingPrefix += '<li class="paginate_button previous '+ (pagingInfo.pageNo == 1 ? 'disabled' : '')+'" aria-controls="list_info" tabindex="0" id="list_info_previous"><a href="#">이전</a></li>';

        var pagingContent = '';
        for (var i = startPage; i <= endPage; i++) {
            pagingContent += '<li class="paginate_button ' + (i == pagingInfo.pageNo ? 'active' : '') +'" aria-controls="list_info" tabindex="0" data-index="'+i+'"><a href="javascript://">' + i + '</a></li>';
        }

        var isEndPage = Math.floor(pagingInfo.totalCnt/pagingInfo.pageCnt) + (pagingInfo.totalCnt % pagingInfo.pageCnt == 0 ? 0 : 1);
        var pagingSurfix = '<li class="paginate_button next '+ (endPage <= 1 || isEndPage == pagingInfo.pageNo ? 'disabled' : '') +'" aria-controls="list_info" tabindex="0" id="list_info_next"><a href="#">다음</a></li>';
        pagingSurfix += '<li class="paginate_button last '+ (endPage <= 1 || isEndPage == pagingInfo.pageNo ? 'disabled' : '') +'" aria-controls="list_info" tabindex="0" id="list_info_last" data-index="'+ isEndPage +'"><a href="#">마지막</a></li>';
        pagingSurfix += '</ul>';

        var paging = pagingPrefix + pagingContent + pagingSurfix;

        $("#" + targetId).html(paging);
    }


    $("#"+targetId).find('.handlebarsPaging li.paginate_button').on('click', function(){

        var currentPage = Number($("#"+targetId).find('.handlebarsPaging li.paginate_button.active').data('index'));

        var me = $(this);
        if(me.hasClass('previous')) {
            pagingInfo.pageNo = currentPage - 1;
        }else if(me.hasClass('next')){
            pagingInfo.pageNo = currentPage + 1;
        }else{
            pagingInfo.pageNo = $(this).data('index');
        }

        //한 페이지에 여러개의 페이징이 있을 경우 구분하기위해 targetId를 같이 보낸다.
        handlebarsPaging(targetId, pagingInfo);

        ui.topScroll();
    });
},

util.scrollPostion = function(y){
    $('html, body').animate({scrollTop: y}, 400);
},

util.renderOnAir = function(value) {
    if(value == 0){
        return ' <i class="fa fa-circle-o"></i>' + " OFF" ;
    }else{
        return ' <i class="fa fa-circle"></i>' + " ON" ;
    }
},

util.textareaResize = function(obj, initHeight){
    var height = obj.style.height.replace("px", "");
    if(!common.isEmpty(initHeight)){
        height = initHeight;
    }

    obj.style.height = height + "px";
    if(height <= obj.scrollHeight){
        obj.style.height = (12+obj.scrollHeight)+"px";
    }
}

util.serializeToJson = function(form){
    var obj = null;

    try {
        var arr = form.serializeArray();
        if(arr){
            obj = {};
            jQuery.each(arr, function() {
                obj[this.name] = this.value;
            });
        }
    }catch(e) {
        alert(e.message);
    }finally  {}
    return obj;
}


util.getMemberBadge = function(startColor,endColor,icon,text, divWidth, divHeight, radius, imgWidth, imgHeight){
    var result;
    result = '<div class="pull-left" style="margin:2px;display:table;width:' + divWidth + ';height:' +divHeight+ ';border-radius:' + radius + 'px ' + radius + 'px ' + radius + 'px;background: linear-gradient(to right, ' + startColor + ', ' + endColor + ');">';
    result +=   '<div style="display:table-cell;vertical-align: middle; text-align: center">';
    if(!common.isEmpty(icon)){
        result +=       '<img style="width: ' + imgWidth + ';height: ' + imgHeight + ';" src="' + icon + '">';
    }
    result +=   '<span style="color: white; font-size: ' +(radius + 1)+ 'px">' + text + '</span>';
    result +=   '</div>';
    result +='</div>';
    return result;      // euc-kr
}

util.getPlatformName = function(platform){
    if(platform == '111'){
        return '전체'
    }

    var platformData = (""+platform).split('');
    var platformDisplay = platformData[0] == '1' ? 'PC<br />' : '';
    platformDisplay += platformData[1] == '1' ? 'Android<br />' : '';
    platformDisplay += platformData[2] == '1' ? 'IOS' : '';

    return platformDisplay;
}

/**
 * 파일명 가져오기
 * fileExt가 있는 경우 확장자를 제거한다.
 */
util.getFileName = function(pathInFileName, includeExt){
    includeExt = common.isEmpty(includeExt) ? true : includeExt;

    console.log(pathInFileName);
    console.log(includeExt);
    var split_arr = pathInFileName.split('/');
    var fileName = split_arr[split_arr.length - 1];
    if(includeExt){
        fileName = fileName.substr(0, fileName.lastIndexOf('.'));
    }
    return fileName;
}

util.viewMailBoxItemJson = function(mem_nick, jsonString){
    var json = JSON.parse(jsonString);
    console.log(json);
    return mem_nick + '님이 '+ json.item_name + ' x ' + json.item_cnt + '개<br />(달 '+ json.item_price +'개)를 선물하였습니다.';
}

util.renderDynamicPageCntSelect = function(selectId, defaultValue){
    var html = '';
    html += '<select id="'+selectId+'" class="form-control searchType">';
    html +=     '<option value="10"' + (defaultValue==10 ? 'selected' : '') + '">10 개씩</option>';
    html +=     '<option value="30"' + (defaultValue==30 ? 'selected' : '') + '">30 개씩</option>';
    html +=     '<option value="50"' + (defaultValue==50 ? 'selected' : '') + '">50 개씩</option>';
    html +=     '<option value="100"' + (defaultValue==100 ? 'selected' : '') + '">100 개씩</option>';
    html += '</select>';
    return html;
}