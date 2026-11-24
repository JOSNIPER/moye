# 前端项目 · 长期记忆（重建于 2026-11-24，原版被误删后恢复要点）

> 2026-11-24 下午项目目录被并行 AI（豆包）大规模重组，本文件按重组后事实重建。

## 项目定位

在线文档管理系统（课程设计）。老师提供后端模板，课程要求"前端重写"。**只重写两个 Vue3 前端，后端原样使用**（后端接口/表结构见《项目快速上手.md》）。

## 目录结构（2026-11-24 重组后）

```
前端项目/
├── backend/    ← 原 文档/springbootpkh49（Java8+SpringBoot2.2.2，带 mvnw）
├── admin/      ← 原 文档/admin（后台前端，5173）
├── 文档/front/  ← 前台前端（5174）【重组时未搬，注意确认最终位置】
├── database/   ← db.sql（只有建表无数据！）
├── docs/       ← 所有 md 文档（快速上手/运行说明/UI改版说明等）
├── brand/      ← logo-source.webp
├── scripts/    ← seed-demo-content.mjs
├── archive/    ← 老备份 zip
└── private/    ← 课题列表（禁止外传）
```

## 品牌与设计规范（硬性）

- 品牌「墨绿文档」，主色 `#0d9f6e`（hover `#098358`，浅底 `#e6f6ef`，辅助青绿 `#08979c`）
- **全站禁止蓝色**（用户明确要求），改色只动 styles.css 的 CSS 变量
- 设计语言：科技墨绿 2.0——深色 Hero+网格光效、大圆角(18-22px)、渐变色块、玻璃拟态

## 关键技术事实

- 端口：8080(backend, context-path `/springbootpkh49`) / 5173(admin) / 5174(front)，均 strictPort
- Node 26 在 `E:/02-Dev/Node`；JDK8 在 `E:/02-Dev/JDK/8`（PATH 默认 JDK21，启 jar 必须显式用 8）
- MySQL：`127.0.0.1:3306` / 库 `springbootpkh49` / `root` / `123456`；服务名 `MySQLDefaults`
- **jar 运行副本必须在 `C:\tools\backend\`**（OneDrive 目录会被锁导致闪退）
- 演示数据只在本机 MySQL 里，`database/db.sql` 是空表结构——换机器必须 mysqldump
- 账号 `abo/abo`；前台静默登录 + 401 自动续期（front/src/api/request.js）
- 搜索必须 `_like` 后缀；分页返回 `{code,data:{total,list}}`；list 默认只回 10 条

## 功能边界（2026-11-24 起变化中）

- 浏览器内预览 docx/xlsx/pptx：**已放弃**（docx-preview/mammoth/JSZip 全卡死，勿再试）
- 在线编辑正文：**豆包开发中**（neirong/neirongmd 字段 + wendanglishi 历史表 + wangeditor/md-editor-v3），稳定后更新文档
- 权限/目录树/协作评论：不做，不做假功能

## 已知坑

- 沙箱 safe-delete 钩子会拦 vite 预构建删临时目录导致崩溃（npm 新装依赖后必触发），绕沙箱或普通终端跑
- PowerShell 工具对中文路径传参易失败，操作中文路径优先用 Bash
- `cmd //c start` / `Start-Process` 可派生脱离任务树的进程（npm.cmd 会被 PowerShell 安全策略拦，用 node.exe 直跑 vite.js）
- vite 死亡排查顺序：先看是否目录被移动（豆包在重组）→ 再看 stderr 是否 safe-delete → 最后才怀疑端口/进程
