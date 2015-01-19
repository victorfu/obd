package cn.voicet.obd.model;

import java.util.ArrayList;
import java.util.List;

public class HbtModel {
	public String deviceno;//设备号
	public List<String> recvdate = new ArrayList<String>();//接收时间
	public List<Double> totallgnition = new ArrayList<Double>();//总点火次数
	public List<Double> accumulativetime = new ArrayList<Double>();//累计行驶时间
	public List<Double> accumulativeidletime = new ArrayList<Double>();//累计怠速时间
	public List<Double> averageheating = new ArrayList<Double>();//平均热车时间
	public List<Double> averagespeed = new ArrayList<Double>();//平均车速
	public List<Double> maxspeed = new ArrayList<Double>();//最高车速
	public List<Double> highestspeed = new ArrayList<Double>();//最高转速
	public List<Double> acceleration = new ArrayList<Double>();//累计急加速
	public List<Double> tdeceleration = new ArrayList<Double>();//累计急减速
	public List<Double> tswerve = new ArrayList<Double>();//累计急转弯
	
	public HbtModel() {
	}
	
	public HbtModel(String deviceno, List<String> recvdate,
			List<Double> totallgnition, List<Double> accumulativetime,
			List<Double> accumulativeidletime, List<Double> averageheating,
			List<Double> averagespeed, List<Double> maxspeed,
			List<Double> highestspeed, List<Double> acceleration,
			List<Double> tdeceleration, List<Double> tswerve) {
		this.deviceno = deviceno;
		this.recvdate = recvdate;
		this.totallgnition = totallgnition;
		this.accumulativetime = accumulativetime;
		this.accumulativeidletime = accumulativeidletime;
		this.averageheating = averageheating;
		this.averagespeed = averagespeed;
		this.maxspeed = maxspeed;
		this.highestspeed = highestspeed;
		this.acceleration = acceleration;
		this.tdeceleration = tdeceleration;
		this.tswerve = tswerve;
	}
	
	
}
