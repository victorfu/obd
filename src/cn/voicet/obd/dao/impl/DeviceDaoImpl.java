package cn.voicet.obd.dao.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.stereotype.Repository;

import cn.voicet.common.dao.impl.BaseDaoImpl;
import cn.voicet.common.util.DotSession;
import cn.voicet.common.util.ExcelUtil;
import cn.voicet.common.util.VTJime;
import cn.voicet.obd.dao.DeviceDao;
import cn.voicet.obd.form.DeviceForm;

@Repository(DeviceDao.SERVICE_NAME)
@SuppressWarnings("unchecked")
public class DeviceDaoImpl extends BaseDaoImpl implements DeviceDao {
	public static final Logger log = Logger.getLogger(DeviceDaoImpl.class);
	
	public List<Map<String, Object>> queryDeviceList(final DotSession ds, final DeviceForm deviceForm) {
		log.info("sp:web_dev_query(?,?,?,?,?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_dev_query(?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("devno", deviceForm.getDevno());
				cs.setString("agent", deviceForm.getProxy());
				cs.setString("sdt", ds.cursdttm);
				cs.setString("edt", ds.curedttm);
				cs.setString("state", deviceForm.getState());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> map = null;
				List<Object> list = new ArrayList<Object>();
				if(rs!=null){
					while (rs.next()) {
						 map = new HashMap<String, Object>();
						 VTJime.putMapDataByColName(map, rs);
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}

	public void batchImportData(final DeviceForm deviceForm, final File uploadExcel) {
		log.info("sp:web_dev_update(?,?,?,?,?,?,?)");

		//excel max column num
		final int MAX_COL_CHECK = 200;
		//max_col[] excel actual column num
		final int COL_ACTUAL_NUM[] = {2,8,6,3,16};
		//
		this.getJdbcTemplate().execute(new ConnectionCallback() {
			public Object doInConnection(Connection con) throws SQLException,
					DataAccessException {
				PreparedStatement ps = null;
				// close session auto commit;
				con.setAutoCommit(false);
				ps = con.prepareStatement("{call web_dev_update(?,?,?,?,?,?,?)}");
				boolean bCheckOK;
				String cellValues[] = new String[MAX_COL_CHECK];
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
						for(int j=0;j<COL_ACTUAL_NUM[3];j++)
						{
							if(null!=row)
							{
								cell = row.getCell(j);
								cellValues[j] = ExcelUtil.getValue(cell);
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
						}// end curCol
						//
						log.info("bCheckOK:"+bCheckOK);
						if(bCheckOK)
						{
							for(int j=0; j<COL_ACTUAL_NUM[3]; j++)
							{
								//设备号
								if(j==0)
								{
									if(null==cellValues[j] || ""==cellValues[j])
									{
										ps.setString(1, null);
									}
									else
									{
										ps.setString(1, cellValues[j]);
									}
								}
								//设备状态
								else if(j==1)
								{
									if(null==cellValues[j] || ""==cellValues[j])
									{
										ps.setString(3, null);
									}
									else
									{
										ps.setString(3, cellValues[j]);
									}
								}
								//有效期
								else if(j==2)
								{
									if(null==cellValues[j] || ""==cellValues[j])
									{
										ps.setString(6, null);
									}
									else
									{
										ps.setString(6, cellValues[j]);
									}	
								}
							}
							//
							ps.setInt(2, deviceForm.getType());
							ps.setString(4, null);
							ps.setString(5, null);
							ps.setString(7, null);
							//
							ps.addBatch();
							//
							if(i % 1000==0){
				        		//执行批量更新    
				        		ps.executeBatch();
				        		//语句执行完毕，提交本事务 
				        		con.commit();
				        		ps.clearBatch();
				        	}
						}
					}// end curRow
					ps.executeBatch();
					con.commit();
					ps.clearBatch();
					ps.close();
					con.setAutoCommit(true);
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
				//设备号必填
				
				break;
				
			default:
				break;
		}
		return true;
	}

	public void saveDevice(final DeviceForm deviceForm) {
		log.info("sp:web_dev_update(?,?,?,?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_dev_update(?,?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("devno", deviceForm.getDevno());
				//cs.setString("aid", deviceForm.getProxy());
				cs.setInt("devtype", deviceForm.getType());
				cs.setString("istate", deviceForm.getState());
				cs.setString("cj", deviceForm.getChangj());
				cs.setString("xh", deviceForm.getDevxh());
				cs.setString("ydt", deviceForm.getValdt());
				cs.setString("pmk", deviceForm.getIdenti());
				cs.execute();
				return null;
			}
		});
	}
	
	public void deleteDevice(final DeviceForm deviceForm) {
		log.info("sp:web_dev_del(?)");
		this.getJdbcTemplate().execute("{call web_dev_del(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("dsn", deviceForm.getDevno());
				cs.execute();
				return null;
			}
		});
	}

	public List<Map<String, Object>> queryDeviceTypeList(final DeviceForm deviceForm) {
		log.info("sp:web_dev_Type_query(?)");
		return (List<Map<String, Object>>)this.getJdbcTemplate().execute("{call web_dev_Type_query(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("vid", deviceForm.getTypeno());
				cs.execute();
				ResultSet rs = cs.getResultSet();
				Map<String, Object> map = null;
				List<Object> list = new ArrayList<Object>();
				if(rs!=null){
					while (rs.next()) {
						 map = new HashMap<String, Object>();
						 VTJime.putMapDataByColName(map, rs);
						 map.put("vid_name", rs.getString("vid")+":"+rs.getString("dname"));
		        		 list.add(map);
					}
				}
				return list;
			}
		});
	}

	public void saveDeviceType(final DeviceForm deviceForm) {
		log.info("sp:web_dev_Type_Update(?,?,?,?,?,?,?,?,?)");
		this.getJdbcTemplate().execute("{call web_dev_Type_Update(?,?,?,?,?,?,?,?,?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("vid", deviceForm.getTypeno());
				cs.setString("fat", deviceForm.getChangj());
				cs.setString("dName", deviceForm.getTpname());
				cs.setString("addr", deviceForm.getAddr());
				cs.setString("tel", deviceForm.getTelnum());
				cs.setString("mobile", deviceForm.getMobile());
				cs.setString("QQ", deviceForm.getQq());
				cs.setString("mail", deviceForm.getEmail());
				cs.setString("url", deviceForm.getCjurl());
				cs.execute();
				return null;
			}
		});		
	}

	public void deleteDeviceType(final DeviceForm deviceForm) {
		log.info("sp:web_dev_Type_Del(?)");
		this.getJdbcTemplate().execute("{call web_dev_Type_Del(?)}", new CallableStatementCallback() {
			public Object doInCallableStatement(CallableStatement cs)
					throws SQLException, DataAccessException {
				cs.setString("vid", deviceForm.getTypeno());
				cs.execute();
				return null;
			}
		});
	}

}
