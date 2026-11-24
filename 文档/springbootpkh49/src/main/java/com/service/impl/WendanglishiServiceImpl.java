package com.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.dao.WendanglishiDao;
import com.entity.WendanglishiEntity;
import com.service.WendanglishiService;
import org.springframework.stereotype.Service;

@Service("wendanglishiService")
public class WendanglishiServiceImpl extends ServiceImpl<WendanglishiDao, WendanglishiEntity> implements WendanglishiService {
}