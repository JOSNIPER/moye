package com.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.entity.WendanglishiEntity;
import com.service.WendanglishiService;
import com.utils.PageUtils;
import com.utils.Query;
import com.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 文档历史版本
 * 每次保存文档写入一条快照；单篇文档最多保留 50 版，超出自动清理最旧的
 */
@RestController
@RequestMapping("/wendanglishi")
public class WendanglishiController {

    /** 单篇文档保留的最大版本数 */
    private static final int MAX_VERSIONS = 50;

    @Autowired
    private WendanglishiService wendanglishiService;

    /**
     * 版本列表（按文档id过滤，默认时间倒序）
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params) {
        EntityWrapper<WendanglishiEntity> ew = new EntityWrapper<>();
        if (params.get("wendangid") != null && !"".equals(params.get("wendangid"))) {
            ew.eq("wendangid", params.get("wendangid"));
        }
        if (params.get("sidx") == null || "".equals(params.get("sidx"))) {
            params.put("sidx", "id");
            params.put("order", "DESC");
        }
        PageUtils page = new PageUtils(
                wendanglishiService.selectPage(new Query<WendanglishiEntity>(params).getPage(), ew));
        return R.ok().put("data", page);
    }

    /**
     * 版本详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id) {
        return R.ok().put("data", wendanglishiService.selectById(id));
    }

    /**
     * 写入版本快照（保存文档时由前端调用），并清理超出上限的旧版本
     */
    @RequestMapping("/save")
    public R save(@RequestBody WendanglishiEntity lishi) {
        if (lishi.getWendangid() == null) {
            return R.error("缺少文档id");
        }
        lishi.setId(new Date().getTime() + new Double(Math.floor(Math.random() * 1000)).longValue());
        wendanglishiService.insert(lishi);

        // 保留最近 MAX_VERSIONS 版：按 id 倒序取全量，删除多余的最旧记录
        List<WendanglishiEntity> all = wendanglishiService.selectList(
                new EntityWrapper<WendanglishiEntity>().eq("wendangid", lishi.getWendangid()).orderDesc(Arrays.asList("id")));
        if (all.size() > MAX_VERSIONS) {
            List<Long> oldIds = all.subList(MAX_VERSIONS, all.size()).stream()
                    .map(WendanglishiEntity::getId).collect(Collectors.toList());
            wendanglishiService.deleteBatchIds(oldIds);
        }
        return R.ok();
    }

    /**
     * 删除版本
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids) {
        wendanglishiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
}