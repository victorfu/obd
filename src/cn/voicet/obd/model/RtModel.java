package cn.voicet.obd.model;

import java.util.ArrayList;
import java.util.List;

public class RtModel {
	public String deviceno;//设备号
	//
	public List<String> recvdate = new ArrayList<String>();//接收时间
	public List<Double> voltage = new ArrayList<Double>();//电瓶电压
	public List<Double> enginespeed = new ArrayList<Double>();//发动机转速
	public List<Double> runningspeed = new ArrayList<Double>();//行驶车速
	public List<Double> solarttermdooropen = new ArrayList<Double>();//节气门开度
	public List<Double> engineload = new ArrayList<Double>();//发动机负荷
	public List<Double> coolanttermperature = new ArrayList<Double>();//冷却液温度
	public List<Double> creeantoil = new ArrayList<Double>();//瞬时油耗
	public List<Double> averageoil = new ArrayList<Double>();//平均油耗
	public List<Double> mileage = new ArrayList<Double>();//本次行驶里程
	public List<Double> totalmileage = new ArrayList<Double>();//总里程
	public List<Double> fueloil = new ArrayList<Double>();//本次耗油量
	public List<Double> accumulativeoil = new ArrayList<Double>();//累计耗油量
	public List<Double> errorcount = new ArrayList<Double>();//故障码数量
	public List<Double> acceleration = new ArrayList<Double>();//本次急加速
	public List<Double> deceleration = new ArrayList<Double>();//本次急减速

	public RtModel() {
	}
	
	public String getDeviceno() {
		return deviceno;
	}
	public void setDeviceno(String deviceno) {
		this.deviceno = deviceno;
	}
	public List<String> getRecvdate() {
		return recvdate;
	}
	public void setRecvdate(List<String> recvdate) {
		this.recvdate = recvdate;
	}
	public List<Double> getVoltage() {
		return voltage;
	}
	public void setVoltage(List<Double> voltage) {
		this.voltage = voltage;
	}
	public List<Double> getEnginespeed() {
		return enginespeed;
	}
	public void setEnginespeed(List<Double> enginespeed) {
		this.enginespeed = enginespeed;
	}
	public List<Double> getRunningspeed() {
		return runningspeed;
	}
	public void setRunningspeed(List<Double> runningspeed) {
		this.runningspeed = runningspeed;
	}
	public List<Double> getSolarttermdooropen() {
		return solarttermdooropen;
	}
	public void setSolarttermdooropen(List<Double> solarttermdooropen) {
		this.solarttermdooropen = solarttermdooropen;
	}
	public List<Double> getEngineload() {
		return engineload;
	}
	public void setEngineload(List<Double> engineload) {
		this.engineload = engineload;
	}
	public List<Double> getCoolanttermperature() {
		return coolanttermperature;
	}
	public void setCoolanttermperature(List<Double> coolanttermperature) {
		this.coolanttermperature = coolanttermperature;
	}
	public List<Double> getCreeantoil() {
		return creeantoil;
	}
	public void setCreeantoil(List<Double> creeantoil) {
		this.creeantoil = creeantoil;
	}
	public List<Double> getAverageoil() {
		return averageoil;
	}
	public void setAverageoil(List<Double> averageoil) {
		this.averageoil = averageoil;
	}
	public List<Double> getMileage() {
		return mileage;
	}
	public void setMileage(List<Double> mileage) {
		this.mileage = mileage;
	}
	public List<Double> getTotalmileage() {
		return totalmileage;
	}
	public void setTotalmileage(List<Double> totalmileage) {
		this.totalmileage = totalmileage;
	}
	public List<Double> getFueloil() {
		return fueloil;
	}
	public void setFueloil(List<Double> fueloil) {
		this.fueloil = fueloil;
	}
	public List<Double> getAccumulativeoil() {
		return accumulativeoil;
	}
	public void setAccumulativeoil(List<Double> accumulativeoil) {
		this.accumulativeoil = accumulativeoil;
	}
	public List<Double> getErrorcount() {
		return errorcount;
	}
	public void setErrorcount(List<Double> errorcount) {
		this.errorcount = errorcount;
	}
	public List<Double> getAcceleration() {
		return acceleration;
	}
	public void setAcceleration(List<Double> acceleration) {
		this.acceleration = acceleration;
	}
	public List<Double> getDeceleration() {
		return deceleration;
	}
	public void setDeceleration(List<Double> deceleration) {
		this.deceleration = deceleration;
	}
	
}
