package com.demo.common.model;

import java.util.List;

import com.demo.common.model.base.BaseZxarticleCategory;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;

/**
 * Generated by JFinal.
 * 分类
 */
@SuppressWarnings("serial")
public class ZxarticleCategory extends BaseZxarticleCategory<ZxarticleCategory> {
	public static final ZxarticleCategory dao = new ZxarticleCategory();
	//文章一级分类所有信息
	public Page<ZxarticleCategory> wzfenleiData(int pageNumber, int pageSize){
		return paginate(pageNumber, pageSize, "select *", "from t_zxarticle_category t ");
	}
	public List<ZxarticleCategory>  getflData(){
		return find("SELECT * FROM t_zxarticle_category");
	}
	public int delete(String sId){
		String sql = "DELETE FROM t_zxarticle_category  WHERE article_category_id IN("+sId+")";
		try {
			return Db.update(sql);
		} catch (Exception e) {
			return 0;
		}
	}
}
