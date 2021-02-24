
/**
 * Number Add Comma
 * 숫자 콤마 추가
 */
Handlebars.registerHelper("addComma", function (value,blank) {
    return common.addComma(value, blank);
})


/**
 * Number Remove Comma
 * 숫자 콤마 제거
 */
Handlebars.registerHelper("removeComma", function (value) {
    return common.removeComma(value);
})


/**
 * Number Convert To Date
 * 숫자를 날짜로 변환
 *
 *  # Format
 *   ex.) YYYY-MM-DD HH:mm:ss:SSS
 *
 */
Handlebars.registerHelper("convertToDate", function (date, format) {
    if(common.isEmpty(date)){
        return "-";
    }
    if(common.isEmpty(format)){
        format = "YYYY.MM.DD";
    }
    return moment(date).format(format);
})

/**
 * Date 구분자 제거
 *
 */
Handlebars.registerHelper("dateToNumber", function (value) {
    var regExp = /\d/gi;

    return value.toString().replace(regExp, "");
})


Handlebars.registerHelper('json', function(obj) {
    return JSON.stringify(obj);
});


/**
 * if
 *
 * ex.)
 * {{#dalbit_if value1 "==" "test1"}}
 *      true code      {{! value1 == "test1" }}
 * {{else}}
 *      false code      {{! value1 != "test1" }}
 * {{/dalbit_if}}
 *
 */
Handlebars.registerHelper("dalbit_if", function(v1, operator, v2, options){
    switch (operator) {
        case '==':
            return (v1 == v2) ? options.fn(this) : options.inverse(this);
        case '===':
            return (v1 === v2) ? options.fn(this) : options.inverse(this);
        case '!=':
            return (v1 != v2) ? options.fn(this) : options.inverse(this);
        case '!==':
            return (v1 !== v2) ? options.fn(this) : options.inverse(this);
        case '<':
            return (v1 < v2) ? options.fn(this) : options.inverse(this);
        case '<=':
            return (v1 <= v2) ? options.fn(this) : options.inverse(this);
        case '>':
            return (v1 > v2) ? options.fn(this) : options.inverse(this);
        case '>=':
            return (v1 >= v2) ? options.fn(this) : options.inverse(this);
        default:
            return options.inverse(this);
    }
})


/**
 *  테이블 목록 index
 */
Handlebars.registerHelper("index", function(index, no)
{
    return common.isEmpty(index) ? no : parseInt(index) + 1;
});

Handlebars.registerHelper("indexDesc", function(totalCnt, rownum)
{
    return common.isEmpty(totalCnt) ? 0 : totalCnt - rownum + 1;
});

Handlebars.registerHelper("indexDescWithoutRownum", function(totalCnt, pageStart, index)
{
    return common.isEmpty(totalCnt) ? 0 : totalCnt - pageStart - index;
});

Handlebars.registerHelper("getCommonCodeText", function(value, targetCode)
{
    return util.getCommonCodeText(value, targetCode);
});

Handlebars.registerHelper("getCommonCodeSelect", function(value, targetCode, isExcludeAllYn, name)
{
    return util.getCommonCodeSelect(value, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper("getCommonCodeSelectForName", function(value, targetCode, isExcludeAllYn, name)
{
    return util.getCommonCodeSelectForName(value, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper("getCommonCodeRadio", function(value, targetCode, isExcludeAllYn, name)
{
    return util.getCommonCodeRadio(value, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper("getCommonCodeCheck", function(value, targetCode, isExcludeAllYn, name)
{
    return util.getCommonCodeCheck(value, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper("getCommonCodeHorizontalCheck", function(value, targetCode, isExcludeAllYn, name)
{
    return util.getCommonCodeHorizontalCheck(value, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper("getCommonCodeLabel", function(value, targetCode)
{
    return util.getCommonCodeLabel(value, targetCode);
});

Handlebars.registerHelper("getCommonCodeLabelAndHidden", function(value, targetCode, name)
{
    return util.getCommonCodeLabelAndHidden(value, targetCode, name);
});

Handlebars.registerHelper("replaceNewLineToBr", function(value)
{
    return util.replaceNewLineToBr(value);
});

Handlebars.registerHelper("replaceHtml", function(value)
{
    return common.replaceHtml(value);
});

Handlebars.registerHelper("replaceHtml_json", function(value)
{
    return common.replaceHtml_json(value);
});

Handlebars.registerHelper("equal", function (value, value2, opt){
    return common.equal(value, value2, opt);
});

Handlebars.registerHelper("getOnOffSwitch", function(value, name){
   return util.getOnOffSwitch(value, name);
});

Handlebars.registerHelper("renderOnOff", function(value){
    return util.renderOnOff(value);
});

Handlebars.registerHelper("renderProfileImage", function(value,gender){
    return common.profileImage(PHOTO_SERVER_URL,value,gender);
});

Handlebars.registerHelper("renderImage", function(value){
    if(!common.isEmpty(value)){
        if(-1 < value.indexOf('https://')){
            return value;
        }
        return PHOTO_SERVER_URL + value;
    }else{
        return "";
    }

});

Handlebars.registerHelper("timeStamp", function(value) {
   return common.timeStamp(value);
});

Handlebars.registerHelper("timeStampMinutes", function(value) {
   return common.timeStampMinutes(value);
});

Handlebars.registerHelper("timeStampDay", function(value) {
    return common.timeStampDay(value);
});

Handlebars.registerHelper("timeStampAll", function(value) {
    return common.timeStampAll(value);
});

Handlebars.registerHelper("timeStampAllKor", function(value) {
    return common.timeStampAllKor(value);
});

Handlebars.registerHelper("replaceTextarea", function(value) {
    return common.replaceTextarea(value);
});

Handlebars.registerHelper("replaceEnter", function(value) {
   return common.replaceEnter(value);
});

Handlebars.registerHelper("viewImage", function(value) {
    return common.viewImage(value);
});

Handlebars.registerHelper("isEmptyData", function() {
    return common.isEmptyData();
});

Handlebars.registerHelper("isSmall", function(value, target, opt) {
    return common.isSmall(value, target, opt);
});

Handlebars.registerHelper("upAndDownClass", function(value) {
    return common.upAndDownClass(value);
});

Handlebars.registerHelper("upAndDownIcon", function(value) {
    return common.upAndDownIcon(value);
});

Handlebars.registerHelper("phoneNumHyphen", function(value) {
    return common.phoneNumHyphen(value);
});

Handlebars.registerHelper("cardNo", function(value) {
    return common.cardNo(value);
});

Handlebars.registerHelper("fontColor", function(value, minValue, fontColor) {
    return common.fontColor(value, minValue, fontColor);
});

Handlebars.registerHelper("setFontColor", function(value, fontColor) {
    return common.setFontColor(value, fontColor);
});

Handlebars.registerHelper("memNoLink", function(display, value) {
    return util.memNoLink(display,value);
});

Handlebars.registerHelper("memNoLink_sex", function(display, value, sex) {
    return util.memNoLink_sex(display,value, sex);
});

Handlebars.registerHelper("roomNoLink", function(display, value) {
    return util.roomNoLink(display,value);
});

Handlebars.registerHelper("renderOnAir", function(value) {
   return util.renderOnAir(value);
});

Handlebars.registerHelper("math", function(lvalue, operator, rvalue, options) {
    lvalue = parseFloat(lvalue);
    rvalue = parseFloat(rvalue);

    return {
        "+": common.addComma(lvalue + rvalue),
        "-": common.addComma(lvalue - rvalue),
        "*": common.addComma(lvalue * rvalue),
        "/": common.addComma(lvalue / rvalue),
        "%": common.addComma(lvalue % rvalue)
    }[operator];
});

Handlebars.registerHelper("getMemStateName", function(state) {
    return common.getMemStateName(state);
});


Handlebars.registerHelper("evalJS_isEmpty", function(varName, options) {
    var v = eval(varName);

    if(common.isEmpty(v)){
        return options.fn(this);
    }else{
        return options.inverse(this);
    }
});

Handlebars.registerHelper("sexIcon", function(sex, birthYear) {
    return common.sexIcon(sex, birthYear);
});

Handlebars.registerHelper("sexIconBr", function(sex, birthYear, isBr) {
    return common.sexIcon(sex, birthYear, isBr);
});

Handlebars.registerHelper("koreaAge", function(birthDate) {
    return common.koreaAge(birthDate);
});

Handlebars.registerHelper("isChild", function(birthDate, options) {
    return common.isChild(birthDate) ? options.fn(this) : options.inverse(this);
});

Handlebars.registerHelper("calcAge", function(value, state) {
   if(common.calcAge(value) < 20) {
       state = '<span style="color:red">미성년자</span>';
   } else {
       state = '-';
   }
   return state;
});

Handlebars.registerHelper("substr", function(value, st, ed) {
    return common.substr(value,st, ed);
});

Handlebars.registerHelper("moment", function(value, format) {
    return moment(value).format(format);
});

Handlebars.registerHelper("isCurrentDisplay", function(is_view, startDate, endDate) {

    var on_text = '<span style="color:blue;">ON</span>';
    var off_text = '<span style="color:gray">OFF</span>';

    if(is_view == 1){
        if(startDate != '0000-00-00 00:00:00'){
            var start = moment(startDate).format('YYYYMMDDHHmmss');
            var end = moment(endDate).format('YYYYMMDDHHmmss');
            var current = moment(new Date()).format('YYYYMMDDHHmmss');
            if(start <= current && current <= end){
                return on_text;
            }else{
                return off_text;
            }
        }
        return on_text
    }
    return off_text;
});

Handlebars.registerHelper('getCommonCodeRadio', function(code, targetCode, isExcludeAllYn, name){
    return util.getCommonCodeRadio(code, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper('getCommonCodeRadioMulti', function(code, targetCode, isExcludeAllYn, name, order){
    return util.getCommonCodeRadioMulti(code, targetCode, isExcludeAllYn, name, order);
});

Handlebars.registerHelper('getCommonCodeCheck', function(code, targetCode, isExcludeAllYn, name){
    return util.getCommonCodeCheck(code, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper('getCommonCodeCheck2', function(code, targetCode, isExcludeAllYn, name){
    return util.getCommonCodeCheck2(code, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper('getCommonCodeHorizontalCheck', function(code, targetCode, isExcludeAllYn, name){
    return util.getCommonCodeHorizontalCheck(code, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper('getCommonCodeSelect', function(code, targetCode, isExcludeAllYn, name){
    return util.getCommonCodeSelect(code, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper('getCommonCodeSelectForName', function(code, targetCode, isExcludeAllYn, name){
    return util.getCommonCodeSelectForName(code, targetCode, isExcludeAllYn, name);
});

Handlebars.registerHelper('renderSlct', function(type, size){
    return util.renderSlct(type,size);
});


Handlebars.registerHelper("getBadgeList", function(value, divWidth, divHeight, radius, imgWidth, imgHeight){
    var tmp = "";
    for(var i=0;i<value.length;i++){
        tmp = tmp + util.getMemberBadge(value[i].startColor, value[i].endColor, value[i].icon, value[i].text, divWidth, divHeight, radius, imgWidth, imgHeight );
    }
    return tmp;
});

Handlebars.registerHelper("getBadge", function(startColor, endColor, icon, text, divWidth, divHeight, radius, imgWidth, imgHeight){
    return util.getMemberBadge(startColor, endColor, icon, text, divWidth, divHeight, radius, imgWidth, imgHeight);
});

Handlebars.registerHelper("getPlatformName", function(platform){
    return util.getPlatformName(platform);
});

Handlebars.registerHelper("popupLink", function(display, url, width, height){
    return util.popupLink(display, url, width, height);
});

Handlebars.registerHelper("viewMailBoxItemJson", function(memNick, jsonString){
    return util.viewMailBoxItemJson(memNick, jsonString);
});

Handlebars.registerHelper("split", function (value, pattern ,location) {
    return value.split(pattern)[location];
});