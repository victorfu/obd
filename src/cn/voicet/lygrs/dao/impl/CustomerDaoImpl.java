package cn.voicet.lygrs.dao.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.struts2.ServletActionContext;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.common.dao.impl.BaseDaoImpl;
import cn.voicet.common.util.DotSession;
import cn.voicet.common.util.VTJime;
import cn.voicet.lygrs.dao.CustomerDao;
import cn.voicet.lygrs.form.CustomerForm;

@Repository(CustomerDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class CustomerDaoImpl extends BaseDaoImpl implements CustomerDao {

	private static Logger log = Logger.getLogger(CustomerDaoImpl.class);


	/**
	 * 查询批次号
	 */
	public List<Map<String, Object>> queryPiNo() {
		log.info("sp:web_lygrs_import_list()");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_lygrs_import_list()}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.execute();
				ResultSet rs = cs.getResultSet();
				List list = new ArrayList();
				if(rs!=null){
					while (rs.next()) {
						 Map map = new HashMap();
						 VTJime.putMapDataByColName(map, rs);
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}

	/**
	 * 保存批次号
	 */
	public void savePiNo(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_import_update(?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_import_update(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString(1, customerForm.getPino());
				cs.setString(2, customerForm.getNoteinfo());
				cs.execute();
				return null;
			}
		});
	}
	

	/**
	 * 批量导入
	 */
	public void batchImportData(final File uploadExcel, final String pino) {
		log.info("sp:web_lygrs_userlist_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		final int MAX_COL_CHECK = 200;
		//col_max[] excel actual column num
		final int COL_ACTUAL_NUM[] = {2,8,6,8,15};
		this.getJdbcTemplate().execute(new ConnectionCallback() {
			public Object doInConnection(Connection conn) throws SQLException,
					DataAccessException {
				PreparedStatement ps = null;
				//close session auto commit
				conn.setAutoCommit(false);
				ps = conn.prepareStatement("{call web_lygrs_userlist_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				boolean bCheckOK;
				String cellValues[]=new String[MAX_COL_CHECK];
				//
				try 
				{
					InputStream inStream=new FileInputStream(uploadExcel);
					Workbook wb = VTJime.create(inStream);
					Sheet sheet = wb.getSheetAt(0);
					int totalRowNum = sheet.getPhysicalNumberOfRows();
					//curRow
					for(int i=1; i<=totalRowNum;i++)
					{
						Row row = sheet.getRow(i);
						Cell cell;
						bCheckOK=true;
						//curCol
						for(int j=0;j<COL_ACTUAL_NUM[4];j++)
						{
							if(null!=row)
							{
								cell = row.getCell(j);
								/*
								if(null!=cell)
								{
									cell.setCellType(HSSFCell.CELL_TYPE_STRING);
									cellValues[j] = row.getCell(j).getStringCellValue();
								}
								else
								{
									cellValues[j]="";
								}
								*/
								cellValues[j] = getValue(cell);
								//
								if(!checkCellOK(i, j, cellValues[j]))
								{
									bCheckOK = false;
								}
								log.info("cellValues[j]:"+cellValues[j]);
							}
							else
							{
								bCheckOK = false;
								log.info("第["+(i+1)+"]行 is null");
							}
						}// end col
						//exec procedure
						log.info("bCheckOK:"+bCheckOK);
						if(bCheckOK)
						{
							//set task number
							ps.setString(1, pino);
							//车辆编号
							ps.setString(2, null);
							for(int j=0; j<COL_ACTUAL_NUM[4]; j++)
							{
								if(null==cellValues[j] || ""==cellValues[j])
								{
									ps.setString(j+3, null);
								}
								else
								{
									ps.setString(j+3, cellValues[j]);
								}
							}
							ps.addBatch();
							//
							if(i % 1000==0){
				        		//执行批量更新    
				        		ps.executeBatch();
				        		//语句执行完毕，提交本事务 
				        		conn.commit();
				        		ps.clearBatch();
				        	}
						}
					}// end row
					ps.executeBatch();
					conn.commit();
					ps.clearBatch();
					ps.close();
					conn.setAutoCommit(true);
					return null;
				} 
				catch (Exception e) 
				{
					log.error(e);
					return null;
				}
			}
		});
	}
	
	/**
	 * 批量导入
	 */
	public void batchImportDataWithAgent(final File uploadExcel, final String pino) {
		log.info("sp:web_lygrs_user_import(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		final int MAX_COL_CHECK = 200;
		//col_max[] excel actual column num
		final int COL_ACTUAL_NUM[] = {2,8,6,8,16};
		this.getJdbcTemplate().execute(new ConnectionCallback() {
			public Object doInConnection(Connection conn) throws SQLException,
					DataAccessException {
				PreparedStatement ps = null;
				//close session auto commit
				conn.setAutoCommit(false);
				ps = conn.prepareStatement("{call web_lygrs_user_import(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				boolean bCheckOK;
				String cellValues[]=new String[MAX_COL_CHECK];
				//
				try 
				{
					InputStream inStream=new FileInputStream(uploadExcel);
					Workbook wb = VTJime.create(inStream);
					Sheet sheet = wb.getSheetAt(0);
					int totalRowNum = sheet.getPhysicalNumberOfRows();
					//curRow
					for(int i=1; i<=totalRowNum;i++)
					{
						Row row = sheet.getRow(i);
						Cell cell;
						bCheckOK=true;
						//curCol
						for(int j=0;j<COL_ACTUAL_NUM[4];j++)
						{
							if(null!=row)
							{
								cell = row.getCell(j);
								cellValues[j] = getValue(cell);
								//
								if(!checkCellOK(i, j, cellValues[j]))
								{
									bCheckOK = false;
								}
								log.info("cellValues[j]:"+cellValues[j]);
							}
							else
							{
								bCheckOK = false;
								log.info("第["+(i+1)+"]行 is null");
							}
						}// end col
						//exec procedure
						log.info("bCheckOK:"+bCheckOK);
						if(bCheckOK)
						{
							//set task number
							ps.setString(1, pino);
							for(int j=0; j<COL_ACTUAL_NUM[4]; j++)
							{
								if(null==cellValues[j] || ""==cellValues[j])
								{
									ps.setString(j+2, null);
								}
								else
								{
									ps.setString(j+2, cellValues[j]);
								}
							}
							ps.addBatch();
							//
							if(i % 1000==0){
				        		//执行批量更新    
				        		ps.executeBatch();
				        		//语句执行完毕，提交本事务 
				        		conn.commit();
				        		ps.clearBatch();
				        	}
						}
					}// end row
					ps.executeBatch();
					conn.commit();
					ps.clearBatch();
					ps.close();
					conn.setAutoCommit(true);
					return null;
				} 
				catch (Exception e) 
				{
					log.error(e);
					return null;
				}
			}
		});
	}
	
	private boolean checkCellOK(int curRow, int curCol, String cellValue) {
		//
		switch (curCol) {
			case 0:
				break;
			case 1:
				break;
			case 2:
				break;
			case 3:
				//车牌号必填
				if(null==cellValue || cellValue.length()<=0)
				{
					log.info("chePaiHao is null:"+cellValue);
					return false;
				}
				break;
				
			default:
				break;
		}
		return true;
	}
	
	/**
	 * 解决类型问题，获取数值
	 * @param cell
	 * @return
	 */
	public String getValue(Cell cell)
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
	
	/**
	 * 查询话务员资料列表
	 */
	public List<Map<String, Object>> queryAgentList() {
		log.info("sp:web_agent_list()");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_agent_list()}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.execute();
				ResultSet rs = cs.getResultSet();
				List list = new ArrayList();
				if(rs!=null){
					while (rs.next()) {
						 Map map = new HashMap();
						 VTJime.putMapDataByColName(map, rs);
						 map.put("telagt", rs.getString("telnum")+"["+rs.getString("agtname")+"]");
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}
	
	/**
	 * 为话务员分配
	 */
	public void allocAgentByPino(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_alloc(?,?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_alloc(?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString(1, customerForm.getPino());
				cs.setInt(2, customerForm.getAllocnum());
				cs.setString(3, customerForm.getAgentlist());
				cs.execute();
				return null;
			}
		});
	}
	
	/**
	 * 清空批次号
	 */
	public void clearPino(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_userdata_clear(?)");
		this.getJdbcTemplate().execute("{call web_lygrs_userdata_clear(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString(1, customerForm.getPino());
				cs.execute();
				return null;
			}
		});
	}

	/**
	 * 重置分配数
	 */
	public void resetFenpei(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_userdata_reset(?)");
		this.getJdbcTemplate().execute("{call web_lygrs_userdata_reset(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString(1, customerForm.getPino());
				cs.execute();
				return null;
			}
		});
	}
	
	/**
	 * 删除批次号
	 */
	public void deletePici(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_import_remove(?)");
		this.getJdbcTemplate().execute("{call web_lygrs_import_remove(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("ids", customerForm.getPino());
				cs.execute();
				return null;
			}
		});
	}
	
	/**
	 * 连云港人寿--车辆信息列表查询
	 */
	public List<Map<String, Object>> queryCustomerInfo(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_userlist_query(?,?,?,?,?,?,?,?,?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_lygrs_userlist_query(?,?,?,?,?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//所属话务员
				cs.setString("agtacc", customerForm.getQ_agtacc());
				//批次号
				cs.setString("ids", customerForm.getQ_pino());
				//车龄
				cs.setString("byear", customerForm.getQ_caryear());
				//客户姓名
				cs.setString("uname", customerForm.getQ_uname());
				//出险次数
				cs.setString("ot", customerForm.getQ_chuxcs());
				//手机号
				cs.setString("telnum", customerForm.getQ_mobile());
				//车牌
				cs.setString("cp", customerForm.getQ_chephm());
				//提取记录数
				cs.setInt("peeknum", 500);
				//查看方式
				cs.setInt("pm", customerForm.getViewall());
				
				//新加查询参数:状态
				if(customerForm.getQ_state()==-1)
				{
					cs.setString("state", null);
				}
				else
				{
					cs.setInt("state", customerForm.getQ_state());
				}
				cs.execute();
				ResultSet rs = cs.getResultSet();
				List list = new ArrayList();
				if(rs!=null){
					while (rs.next()) {
						 Map map = new HashMap();
						 VTJime.putMapDataByColName(map, rs);
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}

	public void exportCustomerData(final CustomerForm customerForm, final HttpServletResponse response) {
		log.info("sp:web_lygrs_userlist_query(?,?,?,?,?,?,?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_userlist_query(?,?,?,?,?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//所属话务员
				cs.setString("agtacc", customerForm.getQ_agtacc());
				//批次号
				cs.setString("ids", customerForm.getQ_pino());
				//车龄
				cs.setString("byear", customerForm.getQ_caryear());
				//客户姓名
				cs.setString("uname", customerForm.getQ_uname());
				//出险次数
				cs.setString("ot", customerForm.getQ_chuxcs());
				//手机号
				cs.setString("telnum", customerForm.getQ_mobile());
				//车版
				cs.setString("cp", customerForm.getQ_chephm());
				//提取记录数
				cs.setInt("peeknum", 0);
				//查看方式
				cs.setInt("pm", 1);
				//新加查询参数:状态
				if(customerForm.getQ_state()==-1)
				{
					cs.setString("state", null);
				}
				else
				{
					cs.setInt("state", customerForm.getQ_state());
				}
				cs.execute();
				//
				ResultSet rs = cs.getResultSet();
				//ResultSetMetaData rsm =rs.getMetaData();
				//int columnCount = rsm.getColumnCount();
				//
				String filePath = ServletActionContext.getServletContext().getRealPath("excelTemplate")+"/"+"customer_exportTemplate.xls";
				HSSFWorkbook wb=VTJime.fromRStoExcel(filePath, 1, true, rs, 20);
				try {
					response.reset();
					response.setHeader("Content-Disposition", "attachment;filename=" + "customerData.xls");
					response.setContentType("application/vnd.ms-excel;charset=UTF-8");	
					wb.write(response.getOutputStream());
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}
		});
	}
	
	/**
	 * 删除客户资料
	 */
	public void deleteCustomerInfo(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_userdata_remove(?)");
		this.getJdbcTemplate().execute("{call web_lygrs_userdata_remove(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//客户编号
				cs.setInt("cid", customerForm.getCid());
				cs.execute();
				return null;
			}
		});
	}
	
	/**
	 * 为指定客户分配话务员
	 */
	public void allocOneAgent(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_alloc_agent(?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_alloc_agent(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//客户编号
				cs.setInt("cid", customerForm.getCid());
				//分配话务员账号
				cs.setString("agtacc", customerForm.getAgtacc());
				cs.execute();
				return null;
			}
		});
	}

	public void queryDetailInfo(final DotSession ds, final CustomerForm customerForm) {
		log.info("sp:web_lygrs_userdata_look(?,?)");
		this.getJdbcTemplate().execute("{call [web_lygrs_userdata_look](?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//客户编号,查看详情时telnum = null
				cs.setInt("cid", customerForm.getCid());
				cs.setString("telnum", null);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				int rid = 0;
				int updateCount = -1;
				ds.list = new ArrayList();
				do
				{
					updateCount = cs.getUpdateCount();
					if(updateCount != -1)
					{	
						cs.getMoreResults();
						continue;
					}
					rs = cs.getResultSet();
					if(null != rs)
					{
						while(rs.next())
						{
							if(rid == 0)
							{
								Map map = new HashMap();
								VTJime.putMapDataByColName(map, rs);
								ds.map = map;
							}
							else if(rid ==1)
							{
								Map map = new HashMap();
								VTJime.putMapDataByColName(map, rs);
				        		ds.list.add(map);
							}
						}
					}
					if(rs != null)
					{
						cs.getMoreResults();
						rid++;
						continue;
					}
				}
				while(!(updateCount == -1 && rs == null));
				return null;
			}
		});
	}
	
	/**
	 * 根据客户ID查询通话记录  delete
	 */
	public List<Map<String, Object>> queryCallRecordByCid(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_userdata_look(?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call [web_lygrs_userdata_look](?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//客户编号
				cs.setInt("cid", customerForm.getCid());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				List list = new ArrayList();
				if(rs!=null){
					while (rs.next()) {
						 Map map = new HashMap();
						 VTJime.putMapDataByColName(map, rs);
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}

	/**
	 * 保存客户资料
	 */
	public void saveCustomerInfo(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_userlist_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_userlist_update(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//批次号
				cs.setString("ids", customerForm.getPino());
				//车辆编号,为空表示创建,否则表示更新
				if(customerForm.getCid()==0)
				{
					cs.setString("cid",null);
				}
				else
				{
					cs.setInt("cid",customerForm.getCid());	
				}
				
				//车龄
				cs.setString("byear", customerForm.getCaryear());
				//出险次数
				cs.setString("ot", customerForm.getChuxcs());
				//车牌号码
				cs.setString("cp", customerForm.getChephm());
				//厂牌号码
				cs.setString("pp", customerForm.getChangphm());
				//车架号
				cs.setString("cfid", customerForm.getChejh());
				//发动机编号
				cs.setString("eid", customerForm.getFadjbh());
				//初登日期
				cs.setString("odt", customerForm.getChudrq());
				//保险到期
				cs.setString("edt", customerForm.getBaoxdq());
				//客户姓名
				cs.setString("uname", customerForm.getUname());
				//身份证号
				cs.setString("crid", customerForm.getIdcard());
				//手机
				cs.setString("mobile", customerForm.getMobile());
				//家庭电话
				cs.setString("home", customerForm.getHometel());
				//办公电话
				cs.setString("office", customerForm.getOfficetel());
				//派送地址
				cs.setString("addr", customerForm.getAddress());
				//备注信息
				cs.setString("noteinfo", customerForm.getNoteinfo());
				cs.execute();
				return null;
			}
		});
	}

	public void setYuyueDateTime(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_set_preddt(?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_set_preddt(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//客户编号
				cs.setInt("cid", customerForm.getCid());
				//预约日期时间
				if(customerForm.getYuyflag()==1)
				{
					cs.setString("predt", customerForm.getYuydate()+" "+customerForm.getYuytime());
				}
				else
				{
					cs.setString("predt", null);
				}
				cs.execute();
				return null;
			}
		});
	}

	/**
	 * 获取弹屏信息
	 */
	public void queryTanpinInfo(final DotSession ds, final CustomerForm customerForm) {
		this.getJdbcTemplate().execute("{call [web_lygrs_userdata_look](?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//客户编号,查看详情时telnum = null
				cs.setString("cid", null);
				cs.setString("telnum", customerForm.getAni());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				int rid = 0;
				ds.list = new ArrayList();
				ds.map = new HashMap();
				int updateCount = -1;
				do
				{
					updateCount = cs.getUpdateCount();
					if(updateCount != -1)
					{	
						cs.getMoreResults();
						continue;
					}
					rs = cs.getResultSet();
					if(null != rs)
					{
						while(rs.next())
						{
							if(rid == 0)
							{
								Map map = new HashMap();
								VTJime.putMapDataByColName(map, rs);
								ds.map = map;
							}
							else if(rid == 1)
							{
								Map map = new HashMap();
								VTJime.putMapDataByColName(map, rs);
				        		ds.list.add(map);
							}
						}
					}
					if(rs != null)
					{
						cs.getMoreResults();
						rid++;
						continue;
					}
				}
				while(!(updateCount == -1 && rs == null));
				return null;
			}
		});
	}

	public void saveTalkContent(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_talk_content(?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_talk_content(?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				//客户编号
				cs.setInt("cid", customerForm.getCid());
				//通话时间
				cs.setString("tdt", customerForm.getTalkdt());
				//通话结果
				cs.setInt("result", customerForm.getTalkresult());
				//通话内容
				cs.setString("noteinfo", customerForm.getNoteinfo());
				cs.execute();
				return null;
			}
		});
	}

	/**
	 * 统计客户状态 
	 */
	public List<Map<String, Object>> queryCustomerStatus(final DotSession ds) {
		log.info("sp:web_lygrs_analy_state(?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_lygrs_analy_state(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("sdts", ds.cursdt);
				cs.setString("edts", ds.curedt);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				List list = new ArrayList();
				if(rs!=null){
					while (rs.next()) {
						 Map map = new HashMap();
						 VTJime.putMapDataByColName(map, rs);
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}
	

	public void exportCustomerStatus(final HttpServletResponse response, final DotSession ds) {
		log.info("sp:web_lygrs_analy_state(?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_analy_state(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("sdts", ds.cursdt);
				cs.setString("edts", ds.curedt);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				//
				String filePath = ServletActionContext.getServletContext().getRealPath("excelTemplate")+"/"+"gendan.xls";
				HSSFWorkbook wb=VTJime.fromRStoExcel(filePath, 1, true, rs, 6);
				try {
					response.reset();
					response.setHeader("Content-Disposition", "attachment;filename=" + "gendan.xls");
					response.setContentType("application/vnd.ms-excel;charset=UTF-8");	
					wb.write(response.getOutputStream());
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}
		});
		
		
		
	}

	/**
	 * 查询客户资料归属
	 */
	public List<Map<String, Object>> queryCustomerGuishu(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_query_owner(?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_lygrs_query_owner(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("cp", customerForm.getQ_chephm());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				List list = new ArrayList();
				if(rs!=null){
					while (rs.next()) {
						 Map map = new HashMap();
						 VTJime.putMapDataByColName(map, rs);
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}

	public void setCustomerState(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_set_state(?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_set_state(?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("cid", customerForm.getCid());
				cs.setInt("state", customerForm.getState());
				cs.execute();
				return null;
			}
		});
	}

	public void saveBaodanInfo(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_set_baodan(?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_set_baodan(?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("cid", customerForm.getCid());
				cs.setString("baofei", customerForm.getBaofei());
				cs.setString("baodan", customerForm.getBaodan());
				cs.setString("baoend", customerForm.getBaoend());
				cs.execute();
				return null;
			}
		});
	}

	public void queryWorkJinZhan(final DotSession ds) {
		log.info("sp:web_lygrs_work_info(?)");
		this.getJdbcTemplate().execute("{call web_lygrs_work_info(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("agtacc", ds.agttelnum);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				int rid = 0;
				int updateCount = -1;
				do
				{
					updateCount = cs.getUpdateCount();
					if(updateCount != -1)
					{	
						cs.getMoreResults();
						continue;
					}
					rs = cs.getResultSet();
					if(null != rs)
					{
						while(rs.next())
						{
							if(rid == 0)
							{
								Map map = new HashMap();
								VTJime.putMapDataByColName(map, rs);
								ds.lygagtMap1 = map;
							}
							else if(rid ==1)
							{
								Map map = new HashMap();
								VTJime.putMapDataByColName(map, rs);
								ds.lygagtMap2 = map;
							}
						}
					}
					if(rs != null)
					{
						cs.getMoreResults();
						rid++;
						continue;
					}
				}
				while(!(updateCount == -1 && rs == null));
				return null;
			}
		});
	}

	public List<Map<String, Object>> queryMissCall(final DotSession ds) {
		log.info("sp:web_agent_getlostlist(?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_agent_getlostlist(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("agtacc", ds.agttelnum);
				cs.execute();
				ResultSet rs = cs.getResultSet();
				List list = new ArrayList();
				if(rs!=null){
					while (rs.next()) {
						 Map map = new HashMap();
						 VTJime.putMapDataByColName(map, rs);
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}
	
	public void queryBaoTotalInfo(final DotSession ds, final CustomerForm customerForm) {
		log.info("sp:web_lygrs_baodan_analy(?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_baodan_analy(?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("sv", ds.cursdt);
				cs.setString("ev", ds.curedt);
				cs.setString("agtacc", customerForm.getQ_agtacc());
				cs.setInt("mode", customerForm.getBaomode());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				int rid = 0;
				int updateCount = -1;
				ds.list = new ArrayList();
				do
				{
					updateCount = cs.getUpdateCount();
					if(updateCount != -1)
					{	
						cs.getMoreResults();
						continue;
					}
					rs = cs.getResultSet();
					if(null != rs)
					{
						while(rs.next())
						{
							if(rid == 0)
							{
								Map map = new HashMap();
								VTJime.putMapDataByColName(map, rs);
								ds.map = map;
							}
							else if(rid ==1)
							{
								Map map = new HashMap();
								VTJime.putMapDataByColName(map, rs);
								ds.list.add(map);
							}
						}
					}
					if(rs != null)
					{
						cs.getMoreResults();
						rid++;
						continue;
					}
				}
				while(!(updateCount == -1 && rs == null));
				return null;
			}
		});
	}

	public void exportBaodanTotalInfo(final CustomerForm customerForm, final HttpServletResponse response, final DotSession ds) {
		final String baodan_files[] = {"baodan_total.xls","baodan_total_agent.xls"};
		log.info("sp:web_lygrs_baodan_analy(?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_lygrs_baodan_analy(?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("sv", ds.cursdt);
				cs.setString("ev", ds.curedt);
				cs.setString("agtacc", customerForm.getQ_agtacc());
				cs.setInt("mode", customerForm.getBaomode());
				cs.execute();
				//
				String expFile = "";
				if(customerForm.getBaomode()==1)
				{
					expFile = baodan_files[1];
				}
				else
				{
					expFile = baodan_files[0];
				}
				ResultSet rs = cs.getResultSet();
				String filePath = ServletActionContext.getServletContext().getRealPath("excelTemplate")+"/"+expFile;
				//
				String dataType[]=new String[60];//Data type
				String FieldName[]=new String[60];//Data type
				HSSFWorkbook workBook = null;
				//String tempFile = null;
				try 
				{
					File file = new File(filePath);
					if(file.exists() && file.isFile())
					{
						workBook = new HSSFWorkbook(new FileInputStream(filePath));
						HSSFSheet sheet = workBook.getSheetAt(0);
				        HSSFCell cell;
				        HSSFRow row1 = sheet.getRow(1);	//HeadRowNum  
				        HSSFRow row2 = sheet.getRow(2);	//HeadRowNum 
				        for(int i=0;i<4;i++)
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
				        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
				        //
				        int i=0;
				        //
				        int rid = 0;
						int updateCount = -1;
						do
						{
							updateCount = cs.getUpdateCount();
							if(updateCount != -1)
							{	
								cs.getMoreResults();
								continue;
							}
							rs = cs.getResultSet();
							if(null != rs)
							{
								while(rs.next())
								{
									if(rid == 0)
									{
										System.out.println("select1");
									}
									else if(rid ==1)
									{
										//export data
										row1 = sheet.getRow(i+1);
										 if(null==row1) row1=sheet.createRow(i+1);
										 for(int j=0;j<4;j++)
										 {
											 cell = row1.getCell(j);
											 if (null==cell) cell = row1.createCell(j);
											 if(null!=cell) cell.setCellStyle(style);
											 if(null!= cell && null!=FieldName[j] && FieldName[j]!="^")
											 {
												 String excelData = getDecimalPoint((String)rs.getString(FieldName[j])); 
												 System.out.println("excelData:"+excelData);
												 if(null!=dataType[j] && dataType[j].equals("N"))
												 {
													 if(null!=excelData && excelData.length()>0)
													 {
														 cell.setCellValue(Double.parseDouble(excelData));
													 }
												 }
												 else
												 {
													 cell.setCellValue(excelData); 
												 }
											 }
										 }//end for
										 i++;
									}
								}
							}
							if(rs != null)
							{
								cs.getMoreResults();
								rid++;
								continue;
							}
						}
						while(!(updateCount == -1 && rs == null));
				        
				        //
					}
					else
					{
						System.out.println("file not exist!");
					}
				}
				catch (Exception e) 
				{
					e.printStackTrace();
				}
				HSSFWorkbook wb= workBook;
				//
				try {
					response.reset();
					response.setHeader("Content-Disposition", "attachment;filename=" + expFile);
					response.setContentType("application/vnd.ms-excel;charset=UTF-8");	
					wb.write(response.getOutputStream());
				} catch (IOException e) {
					e.printStackTrace();
				}
				return null;
			}
		});
	}
	

	public static String getDecimalPoint(String str)
	{
		String substr = "";
		int p = str.indexOf(".");
		if(p > 0)
		{
			substr = str.substring(0, p+3);
			return substr;
		}
		return str;
	}

	public void addCallTimes(final CustomerForm customerForm) {
		log.info("sp:web_lygrs_addcalltimes(?)");
		this.getJdbcTemplate().execute("{call web_lygrs_addcalltimes(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("cid", customerForm.getCid());
				cs.execute();
				return null;
			}
		});
	}

	public void changeCallReply(final CustomerForm customerForm) {
		log.info("sp:web_agent_getlostlist_reply(?)");
		this.getJdbcTemplate().execute("{call web_agent_getlostlist_reply(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setInt("csid", customerForm.getCid());
				cs.execute();
				return null;
			}
		});
	}
}
