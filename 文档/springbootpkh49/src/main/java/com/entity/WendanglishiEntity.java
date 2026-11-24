package com.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * 文档历史版本
 * 每次保存文档时写入一条快照，单篇文档保留最近 50 版（Controller 内清理）
 */
@TableName("wendanglishi")
public class WendanglishiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@TableId
	private Long id;

	@JsonFormat(locale = "zh", timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	/** 文档id */
	private Long wendangid;
	/** 文档名称快照 */
	private String wendangmingcheng;
	/** 类型快照 */
	private String leixing;
	/** 富文本正文快照 */
	private String neirong;
	/** Markdown源码快照 */
	private String neirongmd;
	/** 项目快照 */
	private String xiangmu;
	/** 编辑人 */
	private String bianjiren;
	/** 版本备注 */
	private String beizhu;

	public Long getId() { return id; }
	public void setId(Long id) { this.id = id; }
	public Date getAddtime() { return addtime; }
	public void setAddtime(Date addtime) { this.addtime = addtime; }
	public Long getWendangid() { return wendangid; }
	public void setWendangid(Long wendangid) { this.wendangid = wendangid; }
	public String getWendangmingcheng() { return wendangmingcheng; }
	public void setWendangmingcheng(String wendangmingcheng) { this.wendangmingcheng = wendangmingcheng; }
	public String getLeixing() { return leixing; }
	public void setLeixing(String leixing) { this.leixing = leixing; }
	public String getNeirong() { return neirong; }
	public void setNeirong(String neirong) { this.neirong = neirong; }
	public String getNeirongmd() { return neirongmd; }
	public void setNeirongmd(String neirongmd) { this.neirongmd = neirongmd; }
	public String getXiangmu() { return xiangmu; }
	public void setXiangmu(String xiangmu) { this.xiangmu = xiangmu; }
	public String getBianjiren() { return bianjiren; }
	public void setBianjiren(String bianjiren) { this.bianjiren = bianjiren; }
	public String getBeizhu() { return beizhu; }
	public void setBeizhu(String beizhu) { this.beizhu = beizhu; }
}