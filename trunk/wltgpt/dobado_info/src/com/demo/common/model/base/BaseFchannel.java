package com.demo.common.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseFchannel<M extends BaseFchannel<M>> extends Model<M> implements IBean {

	public void setFchannelId(java.lang.Long fchannelId) {
		set("fchannel_id", fchannelId);
	}

	public java.lang.Long getFchannelId() {
		return get("fchannel_id");
	}

	public void setFchannelName(java.lang.String fchannelName) {
		set("fchannel_name", fchannelName);
	}

	public java.lang.String getFchannelName() {
		return get("fchannel_name");
	}

	public void setAddTime(java.util.Date addTime) {
		set("add_time", addTime);
	}

	public java.util.Date getAddTime() {
		return get("add_time");
	}

}
