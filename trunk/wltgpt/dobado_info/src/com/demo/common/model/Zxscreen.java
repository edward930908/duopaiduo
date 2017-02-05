package com.demo.common.model;

import java.util.List;

import com.demo.common.model.base.BaseZxscreen;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

/**
 * Generated by JFinal.
 */
@SuppressWarnings("serial")
public class Zxscreen extends BaseZxscreen<Zxscreen> {
	public static final Zxscreen dao = new Zxscreen();
	public List<Zxscreen> getBoke(Integer num,Integer tpid){
		return find("SELECT * FROM t_zxscreen t WHERE t.type = ? ORDER BY t.screenId DESC LIMIT ?",tpid,num);
	}
	

	public Page<Zxscreen> adData(int pageNumber, int pageSize,int typeId){
		String sql ="from t_zxscreen t  where type ="+typeId;
		return paginate(pageNumber, pageSize,"select *", sql);
	}
	
	public int delete(String sId){
		String sql = "DELETE FROM t_zxscreen  WHERE screenId IN("+sId+")";
		try {
			return Db.update(sql);
		} catch (Exception e) {
			return 0;
		}
	}
}