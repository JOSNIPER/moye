package com.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;


/**
 * 文档信息
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2021-04-02 14:39:25
 */
@TableName("wendangxinxi")
public class WendangxinxiEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public WendangxinxiEntity() {
		
	}
	
	public WendangxinxiEntity(T t) {
		try {
			BeanUtils.copyProperties(this, t);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 主键id
	 */
	@TableId
	private Long id;
	/**
	 * 文档名称
	 */
					
	private String wendangmingcheng;
	
	/**
	 * 类型
	 */
					
	private String leixing;
	
	/**
	 * 文档介绍
	 */
					
	private String wendangjieshao;
	
	/**
	 * 文档正文（富文本HTML，在线编辑内容）
	 */

	private String neirong;

	/**
	 * Markdown 源码（leixing=Markdown 时使用）
	 */

	private String neirongmd;

	/**
	 * 所属项目（跨格式的项目分类）
	 * IGNORED：允许更新为 null（清除归属），调用方需传完整对象
	 */
	@TableField(strategy = com.baomidou.mybatisplus.enums.FieldStrategy.IGNORED)
	private String xiangmu;

	/**
	 * 附件
	 */
					
	private String fujian;
	
	/**
	 * 发布日期
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd")
	@DateTimeFormat 		
	private Date faburiqi;
	
	
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * 设置：文档名称
	 */
	public void setWendangmingcheng(String wendangmingcheng) {
		this.wendangmingcheng = wendangmingcheng;
	}
	/**
	 * 获取：文档名称
	 */
	public String getWendangmingcheng() {
		return wendangmingcheng;
	}
	/**
	 * 设置：类型
	 */
	public void setLeixing(String leixing) {
		this.leixing = leixing;
	}
	/**
	 * 获取：类型
	 */
	public String getLeixing() {
		return leixing;
	}
	/**
	 * 设置：文档介绍
	 */
	public void setWendangjieshao(String wendangjieshao) {
		this.wendangjieshao = wendangjieshao;
	}
	/**
	 * 获取：文档介绍
	 */
	public String getWendangjieshao() {
		return wendangjieshao;
	}
	/**
	 * 设置：文档正文
	 */
	public void setNeirong(String neirong) {
		this.neirong = neirong;
	}
	/**
	 * 获取：文档正文
	 */
	public String getNeirong() {
		return neirong;
	}
	/**
	 * 设置：Markdown 源码
	 */
	public void setNeirongmd(String neirongmd) {
		this.neirongmd = neirongmd;
	}
	/**
	 * 获取：Markdown 源码
	 */
	public String getNeirongmd() {
		return neirongmd;
	}
	/**
	 * 设置：所属项目
	 */
	public void setXiangmu(String xiangmu) {
		this.xiangmu = xiangmu;
	}
	/**
	 * 获取：所属项目
	 */
	public String getXiangmu() {
		return xiangmu;
	}
	/**
	 * 设置：附件
	 */
	public void setFujian(String fujian) {
		this.fujian = fujian;
	}
	/**
	 * 获取：附件
	 */
	public String getFujian() {
		return fujian;
	}
	/**
	 * 设置：发布日期
	 */
	public void setFaburiqi(Date faburiqi) {
		this.faburiqi = faburiqi;
	}
	/**
	 * 获取：发布日期
	 */
	public Date getFaburiqi() {
		return faburiqi;
	}

}
