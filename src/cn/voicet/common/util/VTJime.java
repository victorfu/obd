package cn.voicet.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * static声明的方法相当于全局函数，可被外部直接调用，与类无关
 * @author _xiang
 */
public class VTJime {
	
	private static Logger log = Logger.getLogger(VTJime.class);
	/**
	 * 根据列名取数据，放进map
	 * @param map 	存放数据
	 * @param rs	结果集
	 */
	public static void putMapDataByColName(Map<String, Object> map,ResultSet rs) 
	{
		String colName;
		try 
		{
			//从元数据中获得列数 
			ResultSetMetaData rsm =rs.getMetaData();
			//所有字段的数目
			int colNum = rsm.getColumnCount();
			for(int i=1; i<=colNum; i++) 
			{
				//根据字段的索引值取得字段的名称, 并转成小写
				colName=rsm.getColumnName(i).toLowerCase();
				if(null!=rs.getString(i) && !rs.getString(i).equals(""))
				{
					map.put(colName, rs.getString(i));
				}
				else
				{
					map.put(colName, "");
				}
			}
		} catch (Exception e) {
			System.out.println("");
		}
	}
	
	/**
	 * 准备存储过程入参[SQLServer]
	 * m money
	 * i integer
	 * f float
	 * String ix[][]={{"-1","o"},{"2","m"},{"3","i"},{"4","f"}}; 
	 * @param cs
	 * @param sr String	页面参数数组 
	 * @param ix index	以存储过程入参顺序为下标,从0开始定义,参数类型数组	
	 * @throws NumberFormatException
	 * @throws SQLException
	 */
	public static void prepareParamFromInputArray(CallableStatement cs, String sr[],String ix[][]) throws NumberFormatException, SQLException
	{
		log.info("ix length:"+ix.length);
		for(int i=0;i<ix.length;i++)
		{
			if(ix[i][1].equalsIgnoreCase("s"))
			{
				cs.setString(i+1,sr[Integer.parseInt(ix[i][0])]);
			}
			else if(ix[i][1].equalsIgnoreCase("m") || ix[i][1].equalsIgnoreCase("f"))
			{
				cs.setFloat(i+1,Float.parseFloat(sr[Integer.parseInt(ix[i][0])]));
			}
			else if(ix[i][1].equalsIgnoreCase("i"))
			{
				cs.setInt(i+1,Integer.parseInt(sr[Integer.parseInt(ix[i][0])]));
			}
			else if(ix[i][1].equalsIgnoreCase("o"))
			{
				log.info("do nothing");
			}
		}
	}
	
	public static void putMapDataByColNameWithColType(Map map,ResultSet rs) {
		String sColName;
		try {
			ResultSetMetaData rsm =rs.getMetaData();
			int col = rsm.getColumnCount();
			for(int i=1; i<=col; i++) {
				sColName=rsm.getColumnName(i);
				if(null!=rs.getString(i) && !rs.getString(i).equals("")){
					int dataType = rsm.getColumnType(i);
					if(dataType==3)
					{
						map.put(sColName, rs.getFloat(i));
					}
					else
					{
						map.put(sColName, rs.getString(i));
					}
					
				}else{
					map.put(sColName, "");
				}
			}
		} catch (Exception e) {
			System.out.println("");
		}
	}
	
	public static Workbook create(InputStream in) throws IOException,InvalidFormatException {
        if (!in.markSupported()) {
            in = new PushbackInputStream(in, 8);
        }
        if (POIFSFileSystem.hasPOIFSHeader(in)) {
            return new HSSFWorkbook(in);
        }
        if (POIXMLDocument.hasOOXMLHeader(in)) {
            return new XSSFWorkbook(OPCPackage.open(in));
        }
        throw new IllegalArgumentException("你的excel版本目前poi解析不了");
    }
	
	
	public static HSSFWorkbook fromRStoExcel(String tempFile, int headlinenum, boolean isDrawBoard, ResultSet rs, int columnCount)
	{
		String dataType[]=new String[60];//Data type
		String FieldName[]=new String[60];//Data type
		HSSFWorkbook workBook;
		
		try {
			File file = new File(tempFile);
			if(file.exists() && file.isFile())
			{
				workBook = new HSSFWorkbook(new FileInputStream(tempFile));
				HSSFSheet sheet = workBook.getSheetAt(0);
		        HSSFCell cell;
		        HSSFRow row1 = sheet.getRow(headlinenum);	//HeadRowNum  
		        HSSFRow row2 = sheet.getRow(headlinenum+1);	//HeadRowNum  
				for(int i=0;i<columnCount;i++)
		        {
					if(null!=row1) 
						{
						cell=row1.getCell(i);
						if (null!=cell)
						{
							FieldName[i]=cell.getStringCellValue();
							cell.setCellValue("");
						}
						else
						{
							FieldName[i]="^";
						}
					}
					if (null!=row2)
						{
						cell=row1.getCell(i);
						if (null!=cell)
						{
							dataType[i]=cell.getStringCellValue();
							cell.setCellValue("");
						}
					}
		        }
				//
				HSSFCellStyle style = workBook.createCellStyle();
				if(isDrawBoard)
		        {
			        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
			        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
		        }
				//add line data ;
				 int i=0;
				 while (rs.next()) 
				 {
					 row1 = sheet.getRow(i+headlinenum);
					 if(null==row1) row1=sheet.createRow(i+headlinenum);
					 for(int j=0;j<columnCount;j++)
					 {
						 cell = row1.getCell(j);
						 if (null==cell) cell = row1.createCell(j);
						 if(null!=cell && isDrawBoard) cell.setCellStyle(style);
						 if(null!= cell && null!=FieldName[j] && FieldName[j]!="^")
						 {
							 if(null!=dataType[j] && dataType[j].equals("N"))
							 {
									String excelData = (String)rs.getString(FieldName[j]); 
									if(null!=excelData && excelData.length()>0)
									{
										cell.setCellValue(Double.parseDouble(excelData));
									}
							}
							else
							{
								
								cell.setCellValue((String)rs.getString(FieldName[j]));
							}	 
						 }
					 }//end for
					 i++;
				 }//end while
				 return workBook;
			}//end temp
			else
			{
				return null;
			}
		}//end try
		catch (Exception e) 
		{
			e.printStackTrace();
			return null;
		}
	}
	
}
