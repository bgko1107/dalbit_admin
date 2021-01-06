/**
 * 공통 자바스크립트 함수
 */
common = {};

common.isEmpty = function(value){
    if(typeof value === 'function'){
        return false;
    }
    return (value == null || value.length === 0);
}

/* 문자열이 빈 문자열인지 체크하여 기본 문자열로 리턴한다. */
common.nvl = function(str, defaultStr){
    return !str ? defaultStr : str;
}


/* Date Type 체크 */
common.isDate = function(value){
    var date = new Date(value);
    return !this.isEmpty(date);
}

/* Date to Number 변환 ex.) 2019-05-13 ==> 20190513 */
common.dateToNumber = function(date){
    if(this.isEmpty(date)){
        dalbitLog("[dateToNumber] 데이터가 Null 입니다. (" + date + ")" )
        return "-";
    }

    if(this.isDate(date)){
        dalbitLog("[dateToNumber] Date 형식이 아닙니다. (" + date + ")" )
        return "-";
    }

    var regExp = /\d/gi;
    return date.toString().replace(regExp, "");
}

common.getMaxDay = function(year, month){
    var date = new Date(year, month, 0);

    if(this.isEmpty(date)) return 0;

    return date.getDate();
}

common.addComma = function(value, blank){
    if(common.isEmpty(value)){
        return 0;
    }
    if(value == "null" || value == "NaN"){
        return '';
    }
    if(!common.isEmpty(blank) && value == 0) {
        if (blank == "Y") {
            return '';
        }
    }
    var regExp = /\B(?=(\d{3})+(?!\d))/g
    return value.toString().replace(regExp, ",");
}

common.removeComma = function(value){
    if(common.isEmpty(value)){
        return 0;
    }
    var regExp = /,/gi;
    return value.toString().replace(regExp, "");
}

common.convertToDate = function(date, format){
    if(this.isEmpty(date)){
        return "-";
    }else if(date.length == 14 || 0 < Number(date)){
        var regExp = /(\d{8})(\d{6})/;
        date = date.toString().replace(regExp, '$1 $2');
    }
    if(this.isEmpty(format)){
        format = "YYYY.MM.DD HH:mm:ss";
    }
    return moment(date).format(format);
}

common.getAge = function(birthYear){
    return Number(moment().format("YYYY")) + 1 - Number(birthYear);
}

common.convertSort = function(value){
    return this.isEmpty(value) ? null : (value === 'asc') ? 0 : 1;
}

common.getValue = function(value){
    return typeof(value) == 'function' ? value() : value;
}

common.replace = function(value, from, to){
    var string = this.getValue(value);
    var from = this.getValue(from);
    var to = this.getValue(to);

    return string.replace(new RegExp(from, 'gi'), to);
}

common.formatDate = function(date, stringFormat){
    var format = this.getValue(stringFormat);
    format = (format.length) ? format : 'YYYY.MM.DD';
    return moment(this.getValue(date)).format(format);
}

common.replaceHtml = function(text){
        if(!common.isEmpty(text)){
            text = text.replace(/\\n/g, '');
            text = this.replace(text, "&lt;", "<");
            text = this.replace(text, "&gt;", ">");
            text = this.replace(text, "&amp;", "&");
            return text;
        }
}

common.replaceHtml_json = function(text){
    if(!common.isEmpty(text)){
        text = text.replace(/\\n/g, '');
        text = this.replace(text, /\\\\/g, "\\");
        text = this.replace(text, "&lt;", "<");
        text = this.replace(text, "&gt;", ">");
        text = this.replace(text, "&amp;", "&");
        return text;
    }
}

common.replaceTag = function(text){
    if(!common.isEmpty(text)){
        text = text.replace(/\\n/g, '<br/>');
        text = text.replace(/\\t/g, ' ');
        return text;
    }
}

common.equal = function(val1, val2, opt) {
    if (arguments.length < 3)
        throw new Error("equal은 2개의 인자가 필요합니다.");

    var v1 = this.getValue(val1);
    var v2 = this.getValue(val2);

    return (v1 != v2) ? opt.inverse(this) : opt.fn(this);
}

common.fillzero = function(obj, len) {
    var objLen = obj.toString().length;

    while (objLen < len){
        obj = "0" + obj;
        objLen++;
    }

    return obj;
}

common.lpad = function(s, padLength, padString){
    s = String(s);
    while(s.length < padLength)
        s = padString + s;
    return s;
}

common.rpad = function(s, padLength, padString){
    s = String(s);
    while(s.length < padLength)
        s = s + padString;
    return s;
}

common.timeStamp = function(time){
    if(!common.isEmpty(time) && time != 0) {
        time = parseInt(time);
        var hours = common.lpad(Math.floor(time / 3600), 2, "0");
        var minutes = common.lpad(Math.floor((time - (hours * 3600)) / 60), 2, "0");
        var seconds = common.lpad(time - (hours * 3600) - (minutes * 60), 2, "0");
        var time = hours + ":" + minutes + ":" + seconds;
        return time;
    }else{
        return "";
    }
}

common.timeStampMinutes = function(time){
    if(!common.isEmpty(time) && time != 0) {
        time = parseInt(time);
        time = time * 60;
        var hours = common.lpad(Math.floor(time / 3600),2,"0");
        var minutes = common.lpad(Math.floor((time - (hours * 3600)) /60),2,"0");
        var time = hours  + ":" + minutes;
        return time ;
    }else{
        return "";
    }
}

common.timeStampDay = function(time){
    if(!common.isEmpty(time) && time != 0){
        time = parseInt(time);
        var day = Math.floor(time / 60 / 60 / 24);
        var day_s = day * 60 * 60 * 24;
        var hours_s = time - (day_s);
        var hours = Math.floor(hours_s / 60 / 60);
        var minutes_s = time - (day_s + (hours * 60 * 60));
        var minutes = Math.floor(minutes_s / 60);
        var seconds = time - ((day * 60 * 60 * 24) + (hours * 60 * 60) + (minutes * 60) );

        var timeData;
        if(day != 0){
            timeData = day + "일 " + hours  + "시간";
        }else{
            if(hours != 0){
                timeData = hours  + "시간 " + minutes + "분";
            }else{
                timeData = minutes + "분";
            }
        }
        return timeData ;
    }else{
        return "";
    }
}

common.timeStampAll = function(time){
    if(!common.isEmpty(time) && time != 0){
        time = parseInt(time);
        var day = Math.floor(time / 60 / 60 / 24);
        var day_s = day * 60 * 60 * 24;
        var hours_s = time - (day_s);
        var hours = Math.floor(hours_s / 60 / 60);
        var minutes_s = time - (day_s + (hours * 60 * 60));
        var minutes = Math.floor(minutes_s / 60);
        var seconds = time - ((day * 60 * 60 * 24) + (hours * 60 * 60) + (minutes * 60) );

        if(day > 0){
            return day + " " + hours  + ":" + minutes + ":" + seconds;
        }else{
            return hours  + ":" + minutes + ":" + seconds;
        }
    }else{
        return "";
    }
}

common.timeStampAllKor = function(time){
    if(!common.isEmpty(time) && time != 0){
        time = parseInt(time);
        var day = Math.floor(time / 60 / 60 / 24);
        var day_s = day * 60 * 60 * 24;
        var hours_s = time - (day_s);
        var hours = Math.floor(hours_s / 60 / 60);
        var minutes_s = time - (day_s + (hours * 60 * 60));
        var minutes = Math.floor(minutes_s / 60);
        var seconds = time - ((day * 60 * 60 * 24) + (hours * 60 * 60) + (minutes * 60) );

        return day + "일 " + hours  + "시 " + minutes + "분 " + seconds + "초";
    }else{
        return "";
    }
}

common.profileImage = function(PHOTO_SERVER_URL, path, gender){
    var image;
    if(common.isEmpty(path)){
        image = PHOTO_SERVER_URL + "/profile_3/profile_" + gender + "_200327.jpg";
    }else{
        image = PHOTO_SERVER_URL + path;
    }
    return image ;
}

common.replaceTextarea = function(text){
    if(!common.isEmpty(text)){
        return common.replace(common.replaceEnter(text), /<br *\/?>/gi, '\n');
    }
}


common.replaceEnter = function(text){
    if(!common.isEmpty(text)){
        text = text.replace(/\\n/g, "<br/>")
        return text;
    }
}

common.viewImage = function(path){
    return PHOTO_SERVER_URL + path;
}

common.isEmptyData = function(){
    return COMMON_MESSAGE.isEmptyData;
}

common.isSmall = function(value, target, opt){
    return 0 < target - value ? opt.fn(this) : opt.inverse(this);
}

//input 숫자 입력만 가능
common.inputFilterNumber = function (event) {
    var code = event.which;

    //숫자
    if((48 <= code && code <= 57)){
        return;
    }

    //NUM keyPad
    if((96 <= code && code <= 105)){
        return;
    }

    // 특수키 9 : TAB, 36 : HOME, 35 : END, 37 : LEFT, 39 : RIGHT, 8 : BACKSPACE, 46 : DELETE
    if (code === 9 || code === 36 || code === 35 || code === 37 ||
        code === 39 || code === 8 || code === 46) {
        return;
    }

    event.preventDefault();
}

common.stringToDateTime = function (strDate) {
    if(this.isEmpty(strDate) || strDate.length < 8){
        return strDate;
    }

    if(strDate.length == 8){
        return new Date(strDate.substring(0,4), strDate.substring(4,6)-1, strDate.substring(6,8));
    }

    if(strDate.length == 12){
        return new Date(strDate.substring(0,4), strDate.substring(4,6)-1, strDate.substring(6,8), strDate.substring(8,10), strDate.substring(10,12));
    }

    if(strDate.length == 15){
        return new Date(strDate.substring(0,4), strDate.substring(4,6)-1, strDate.substring(6,8), strDate.substring(8,10), strDate.substring(10,12), strDate.substring(12,15));
    }

}

common.upAndDownClass = function(value){
    var result = '';
    if(0 < Number(value)){
        result = '_up';
    }else if(Number(value) < 0){
        result = '_down';
    }
    return result;
}

common.upAndDownIcon = function(value){
    var result = '';
    if(0 < Number(value)){
        result = 'fa-caret-up';
    }else if(Number(value) < 0){
        result = 'fa-caret-down';
    }
    return result;
}

common.phoneNumHyphen = function(value) {
    if(common.isEmpty(value)) {
        return '-';
    }
    var regExp = /(\d{3})(\d{3,4})(\d{4})/
    return value.toString().replace(regExp, '$1-$2-$3');
}

common.cardNo = function(value){
    if(common.isEmpty(value)){
        return '-';
    }
    var regExp = /([0-9*]{4})([0-9*]{4})([0-9*]{4})([0-9*]{4})/
    return value.toString().replace(regExp, '$1-$2-$3-$4');
}

common.fontColor = function(value, minValue, fontColor){
    minValue = common.isEmpty(minValue) ? 0 : minValue;
    fontColor = common.isEmpty(fontColor) ? 'black' : fontColor;

    if(common.isEmpty(value) || value <= minValue){
        return value;
    }
    return "<span style='color:"+fontColor+";font-weight: bold;'>" + value + "</span>";
};

common.setFontColor = function(value, fontColor){
    fontColor = common.isEmpty(fontColor) ? 'black' : fontColor;
    return "<span style='color:"+fontColor+";font-weight: bold;'>" + value + "</span>";
};

common.scrollTop = function(){
    $(window).scroll(function () {
        if ($(this).scrollTop() > 50) {
            $('#back-to-top').fadeIn();
        } else {
            $('#back-to-top').fadeOut();
        }
    });
    // scroll body to 0px on click
    $('#back-to-top').click(function () {
        $('#back-to-top').tooltip('hide');
        $('body,html').animate({
            scrollTop: 0
        }, 400);
        return false;
    });

    $('#back-to-top').tooltip('show');
};

common.getMemStateName = function(state){
    if(common.isEmpty(state)){
        return state;
    }

    if(state == '1'){
        return '정상'
    }else if(state == '2'){
        return '경고'
    }else if(state == '3'){
        return '정지'
    }else if(state == '4'){
        return '<span style="color:red;">탈퇴</span>'
    }else if(state == '5'){
        return '영구정지'
    }
}

// array sum
common.getListSum = function(value){
    var sumResult=0;
    for(var i=0;i<value.length;i++){
        if(!common.isEmpty(value[i])) {
            sumResult += value[i];
        }
    }
    return sumResult;
};

common.average = function(lvalue, rvalue, point) {
    if(lvalue == "null" || lvalue == "NaN" || rvalue == "null" || rvalue == "NaN"){
        return '';
    }
    if (rvalue == 0 || common.isEmpty(rvalue)) {
        return 0;
    }
    if (lvalue == 0 || common.isEmpty(lvalue)) {
        return 0;
    }
    var tmp = (lvalue / rvalue) * 100;
    if(!common.isEmpty(point)){
        return tmp.toFixed(point);
    }else{
        return tmp.toFixed(1);
    }
};

common.sexIcon = function(sex, birthYear, isBr){
    if(common.isEmpty(sex)){
        return '';
    }
    var sex_lowercase = sex.toLowerCase();
    if(birthYear > 0){
        var date = new Date();
        var koreanAge = date.getFullYear() - birthYear + 1;
        if(sex_lowercase == 'm'){
            return '<label class="font-bold" style="color: blue;margin-bottom: 0px"><i class="fa fa-male"></i> 남성</label>' + (!common.isEmpty(isBr) && isBr ? '<br>' : '') + '(' + koreanAge + '세)';
        }else if(sex_lowercase == 'f'){
            return '<label class="font-bold" style="color: red;margin-bottom: 0px"><i class="fa fa-female"></i> 여성</label>' + (!common.isEmpty(isBr) && isBr ? '<br>' : '') + '(' + koreanAge + '세)';
        }else{
            return '<label class="font-bold" style="margin-bottom: 0px;"><i class="fa fa-question"></i> 알수없음</label>' + (!common.isEmpty(isBr) && isBr ? '<br>' : '') + '(' + koreanAge + '세)'
        }
    }else{
        if(sex_lowercase == 'm'){
            return '<label class="font-bold" style="color: blue;margin-bottom: 0px"><i class="fa fa-male"></i> 남성</label>';
        }else if(sex_lowercase == 'f'){
            return '<label class="font-bold" style="color: red;margin-bottom: 0px"><i class="fa fa-female"></i> 여성</label>';
        }else{
            return '<label class="font-bold" style="margin-bottom: 0px;"><i class="fa fa-question"></i> 알수없음</label>';
        }
    }
};

common.vatMinus = function(lvalue) {
    if(lvalue == 0){
        return 0;
    }
    if(lvalue == "null" || lvalue == "NaN"){
        return '';
    }
    return common.addComma((lvalue / 1.1).toFixed(0));
};

common.charVatMinus = function(lvalue) {
    if(lvalue == 0){
        return 0;
    }
    if(lvalue == "null" || lvalue == "NaN"){
        return '';
    }
    return (lvalue / 1.1).toFixed(0);
};

common.payRate = function(lvalue,rvalue) {
    if (rvalue == 0) {
        return 0;
    }
    var tmp = (lvalue * 100) / rvalue;
    return common.addComma(tmp.toFixed(1));
};

common.division = function(lvalue,rvalue, dot) {
    if (rvalue == 0) {
        return 0;
    }
    var tmp = lvalue / rvalue;
    if(!common.isEmpty(dot)){
        return common.addComma(tmp.toFixed(dot));
    }else{
        return common.addComma(tmp.toFixed(1));
    }
};

common.exchangeAmt = function(star, isSpecial){
    var cashBasic = star * 60;
    var specialBenefit = Math.trunc(cashBasic * 0.05, -1);
    var residentTax = Math.trunc(cashBasic * 0.03, -1);

    var total = 0;

    if(isSpecial != 0){     // 스페셜 DJ
        total = cashBasic + regularChange(specialBenefit,"0") - regularChange(residentTax,"0");
    }else if(isSpecial == 0){     // 스페셜 DJ
        total = cashBasic - regularChange(residentTax,0);
    }

    return common.addComma(total);
};

//정규식 변환
function regularChange(val, replaceTxt) {
    if (val == undefined || val === '') {
        return '';
    }
    var pattern = /.{1}$/; // 정규식
    val = Number(String(val).replace(pattern, replaceTxt));
    return val;
}


common.koreaAge = function(birthDate){
    if(birthDate == null){
        return "";
    }
    if(birthDate.split('-').length == 3){
        var birthYear = birthDate.split('-')[0];
        var curYear = moment(new Date()).format('YYYY');

        var koreaAge = Number(curYear - birthYear) + 1;
        return koreaAge;
    }
}

common.isChild = function(birth){
    return common.calcAge(birth) < 20;
}

common.calcAge = function(birth) {

    var date = new Date();
    var year = date.getFullYear();
    var month = (date.getMonth() + 1);
    var day = date.getDate();
    if (month < 10) month = '0' + month;
    if (day < 10) day = '0' + day;
    var monthDay = month + day;

    birth = birth.replace('-', '');
    var birthdayy = birth.substr(0, 4);
    var birthdaymd = birth.substr(4, 4);
    //var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
    var age = year - birthdayy + 1;

    return age;

}

common.substr = function(value, st, ed){
    if(ed > 0){
        return value.substr(st,ed);
    }else{
        return value.substr(st);
    }
};

common.getStringByteLength = function(str){

    if(common.isEmpty(str)){
        return 0;
    }

    // return str.replace(/[\0-\x7f]|([0-\u07ff]|(.))/g, "$&$1$2").length;      // utf-8
    return str.replace(/[\0-\x7f]|([0-힣]|(.))/g, "$&$1$2").length;      // euc-kr
}
