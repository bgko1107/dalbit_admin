package com.dalbit.excel.service;

import com.dalbit.common.code.Status;
import com.dalbit.excel.vo.ExcelVo;
import com.dalbit.exception.GlobalException;
import com.dalbit.util.DalbitUtil;
import com.dalbit.util.GsonUtil;
import com.dalbit.util.MessageUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class ExcelService {

    @Autowired
    MessageUtil messageUtil;
    @Autowired
    GsonUtil gsonUtil;


    public void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws GlobalException{

        Locale locale = (Locale) model.get("locale");
        String workbookName = (String) model.get("workbookName");

        // 겹치는 파일 이름 중복을 피하기 위해 시간을 이용해서 파일 이름에 추
        Date date = new Date();
        SimpleDateFormat dayformat = new SimpleDateFormat("yyyyMMdd", locale);
        SimpleDateFormat hourformat = new SimpleDateFormat("hhmmss", locale);
        String day = dayformat.format(date);
        String hour = hourformat.format(date);
        String fileName = workbookName + "_" + day + "_" + hour + ".xlsx";

        // 여기서부터는 각 브라우저에 따른 파일이름 인코딩작업
        String browser = request.getHeader("User-Agent");
        try {
            if (browser.indexOf("MSIE") > -1) {
                fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            } else if (browser.indexOf("Trident") > -1) {       // IE11
                fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            } else if (browser.indexOf("Firefox") > -1) {
                fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
            } else if (browser.indexOf("Opera") > -1) {
                fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
            } else if (browser.indexOf("Chrome") > -1) {
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < fileName.length(); i++) {
                    char c = fileName.charAt(i);
                    if (c > '~') {
                        sb.append(URLEncoder.encode("" + c, "UTF-8"));
                    } else {
                        sb.append(c);
                    }
                }
                fileName = sb.toString();
            } else if (browser.indexOf("Safari") > -1) {
                fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
            } else {
                fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
            }
        }catch (UnsupportedEncodingException e){
            e.printStackTrace();
            throw new GlobalException(Status.엑셀다운로드실패);
        }

//        response.setContentType("application/vnd.ms-excel;charset=utf-8"); // .xls
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8"); // .xlsx
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setHeader("Set-Cookie", "fileDownload=true; path=/");

        OutputStream os = null;
        SXSSFWorkbook workbook = null;

        try {
            workbook = (SXSSFWorkbook) model.get("workbook");
            os = response.getOutputStream();

            // 파일생성
            workbook.write(os);

            workbook.dispose();

        }catch (IOException e) {
            e.printStackTrace();
            throw new GlobalException(Status.엑셀다운로드실패);
        } finally {
            try{
                if(workbook != null) {
                        workbook.close();
                }
                if(os != null) {
                    os.close();
                }
            }catch (IOException e){
                e.printStackTrace();
                throw new GlobalException(Status.엑셀다운로드실패);
            }
        }
    }





    public SXSSFWorkbook excelDownload(String sheetName, ExcelVo vo) {
        SXSSFWorkbook workbook = new SXSSFWorkbook();
        XSSFCellStyle style = (XSSFCellStyle) workbook.createCellStyle();
        XSSFDataFormat format = (XSSFDataFormat) workbook.createDataFormat();

        String[] headers = vo.getHeaders();
        int[] headerWidths = vo.getHeaderWidths();
        int hSize = headers != null ? headers.length : 0;
        List<Object[]> bodies = vo.getBodies();
        int bSize = bodies.size() == 0 ? bodies.size() : bodies.get(0).length;

        // 시트 생성
        sheetName = DalbitUtil.isEmpty(sheetName) ? "Sheet01" : sheetName;
        SXSSFSheet sheet = workbook.createSheet(sheetName);

        // 헤더 행 생
        Row headerRow = sheet.createRow(0);

        //시트 열 너비 설정
        for(int i=0; i < bSize; i++){
            if(headerWidths != null && headerWidths.length > i){
                sheet.setColumnWidth(i, headerWidths[i]);
            }

            // 해당 행의 첫번째 열 셀 생성
            Cell headerCell = headerRow.createCell(i);
            String headerName = hSize <= i ? "이름없음_" + i : headers[i];
            headerCell.setCellValue(headerName);
        }

        // 과일표 내용 행 및 셀 생성
        Row bodyRow = null;
        for(int i=0; i < bodies.size(); i++) {
            Object[] body = bodies.get(i);
            bodyRow = sheet.createRow(i+1);

            for(int idx=0; idx < body.length; idx++){
                createBodyCell(style, format, bodyRow, idx, body[idx]);
            }
        }

        return workbook;
    }





    public void createBodyCell(XSSFCellStyle style, XSSFDataFormat format, Row row, int idxCell, Object value){
        Cell cell = row.createCell(idxCell);

        if(value instanceof String){
            style.setDataFormat(format.getFormat("@"));
            cell.setCellStyle(style);

            cell.setCellValue(value.toString().length() > 32767 ? value.toString().substring(0, 32767): value.toString());
        }
        else if(value instanceof Integer){
            cell.setCellValue(new Double((int) value));

            style.setDataFormat(format.getFormat("#,##0"));
            cell.setCellStyle(style);
        }
        else if(value instanceof Long){
            cell.setCellValue(new Double((Long) value));

            style.setDataFormat(format.getFormat("#,##0"));
            cell.setCellStyle(style);
        }
        else if(value instanceof Double){
            cell.setCellValue((Double) value);

            style.setDataFormat(format.getFormat("#,##0"));
            cell.setCellStyle(style);
        }
        else if(value instanceof Calendar){
            cell.setCellValue((Calendar) value);

            style.setDataFormat(format.getFormat("yyyy-mm-dd"));
            cell.setCellStyle(style);
        }
        else if(value instanceof Date){
            cell.setCellValue((Date) value);

            style.setDataFormat(format.getFormat("yyyy-mm-dd"));
            cell.setCellStyle(style);
        }
        else if(value instanceof Boolean){
            cell.setCellValue((boolean) value);
        }
        else{
            cell.setCellValue(value.toString());
        }
    }

    /**
     * 엑셀 표시형식
     0, "General"
     1, "0"
     2, "0.00"
     3, "#,##0"
     4, "#,##0.00"
     5, "$#,##0_);($#,##0)"
     6, "$#,##0_);[Red]($#,##0)"
     7, "$#,##0.00);($#,##0.00)"
     8, "$#,##0.00_);[Red]($#,##0.00)"
     9, "0%"
     0xa, "0.00%"
     0xb, "0.00E+00"
     0xc, "# ?/?"
     0xd, "# ??/??"
     0xe, "m/d/yy"
     0xf, "d-mmm-yy"
     0x10, "d-mmm"
     0x11, "mmm-yy"
     0x12, "h:mm AM/PM"
     0x13, "h:mm:ss AM/PM"
     0x14, "h:mm"
     0x15, "h:mm:ss"
     0x16, "m/d/yy h:mm"
     // 0x17 - 0x24 reserved for international and undocumented 0x25, "#,##0_);(#,##0)"
     0x26, "#,##0_);[Red](#,##0)"
     0x27, "#,##0.00_);(#,##0.00)"
     0x28, "#,##0.00_);[Red](#,##0.00)"
     0x29, "_(*#,##0_);_(*(#,##0);_(* \"-\"_);_(@_)"
     0x2a, "_($*#,##0_);_($*(#,##0);_($* \"-\"_);_(@_)"
     0x2b, "_(*#,##0.00_);_(*(#,##0.00);_(*\"-\"??_);_(@_)"
     0x2c, "_($*#,##0.00_);_($*(#,##0.00);_($*\"-\"??_);_(@_)"
     0x2d, "mm:ss"
     0x2e, "[h]:mm:ss"
     0x2f, "mm:ss.0"
     0x30, "##0.0E+0"
     0x31, "@" - This is text format.
     0x31 "text" - Alias for "@"
     *
     * */
}
