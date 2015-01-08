package cn.voicet.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;

public class ExcelUtil {
	public static Logger log = Logger.getLogger(ExcelUtil.class);
	/**
	 * 解决类型问题，获取数值
	 * @param cell
	 * @return
	 */
	public static String getValue(Cell cell)
	{
		String value = "";
		if(null==cell)
		{
			return value;
		}
		switch (cell.getCellType()) {
			//数值型
			case Cell.CELL_TYPE_NUMERIC:
				if (HSSFDateUtil.isCellDateFormatted(cell)) 
				{
	                //如果是date类型则 ，获取该cell的date值，并进行格式化  
	                Date date = HSSFDateUtil.getJavaDate(cell.getNumericCellValue()); 
	                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	                value = format.format(date); 
	            }
				//纯数字
				else 
	            {
	                value = String.valueOf(cell.getNumericCellValue());  
	                //解决1234.0  去掉后面的.0  
	                if(null!=value&&!"".equals(value.trim()))
	                {
	                     String[] item = value.split("[.]");
	                     if(1<item.length && "0".equals(item[1]))
	                     {
	                         value=item[0];  
	                     }
	                }
	            }
	            log.info(value);
				break;
			//字符串类型
			case Cell.CELL_TYPE_STRING:
				value = cell.getStringCellValue().toString();
				break;
			//公式类型
			case Cell.CELL_TYPE_FORMULA:
				//读公式计算值
				value = String.valueOf(cell.getNumericCellValue());
				//如果获取的数值为非法值，则转换成获取字符串
				if(value.equals("NaN"))
				{
					value = cell.getStringCellValue().toString();
				}
				break;
			//布尔类型
			case Cell.CELL_TYPE_BOOLEAN:
				value = ""+cell.getBooleanCellValue();
				break;
			//空值
			case Cell.CELL_TYPE_BLANK:
				value = "";
				log.info("excel出现空值");
				break;
			//故障
			case Cell.CELL_TYPE_ERROR:
				value = "";
				log.info("excel出现ERROR");
				break;
			default:
				value = cell.getStringCellValue().toString();
				break;
		}
		if("null".endsWith(value.trim()))
		{
			value = "";
		}
		return value;
	}
	
}
