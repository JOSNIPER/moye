-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: springbootpkh49
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bumenxinxi`
--

DROP TABLE IF EXISTS `bumenxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bumenxinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `bumen` varchar(200) NOT NULL COMMENT '部门',
  `renshu` int NOT NULL COMMENT '人数',
  `renyuanjiagou` longtext COMMENT '人员架构',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1617346382778 DEFAULT CHARSET=utf8mb3 COMMENT='部门信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bumenxinxi`
--

LOCK TABLES `bumenxinxi` WRITE;
/*!40000 ALTER TABLE `bumenxinxi` DISABLE KEYS */;
INSERT INTO `bumenxinxi` VALUES (21,'2021-04-02 06:39:35','部门1',1,'人员架构1'),(22,'2021-04-02 06:39:35','部门2',2,'人员架构2'),(23,'2021-04-02 06:39:35','部门3',3,'人员架构3'),(24,'2021-04-02 06:39:35','部门4',4,'人员架构4'),(25,'2021-04-02 06:39:35','部门5',5,'人员架构5'),(26,'2021-04-02 06:39:35','部门6',6,'人员架构6'),(1617346382777,'2021-04-02 06:53:02','市场部',20,'<p><img src=\"http://localhost:8080/springbootpkh49/upload/1617346381259.jpg\"></p>');
/*!40000 ALTER TABLE `bumenxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '配置参数名称',
  `value` varchar(100) DEFAULT NULL COMMENT '配置参数值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='配置文件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'picture1','http://localhost:8080/springbootpkh49/upload/picture1.jpg'),(2,'picture2','http://localhost:8080/springbootpkh49/upload/picture2.jpg'),(3,'picture3','http://localhost:8080/springbootpkh49/upload/picture3.jpg'),(6,'homepage',NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gangwei`
--

DROP TABLE IF EXISTS `gangwei`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gangwei` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gangwei` varchar(200) NOT NULL COMMENT '岗位',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gangwei` (`gangwei`)
) ENGINE=InnoDB AUTO_INCREMENT=1617346393893 DEFAULT CHARSET=utf8mb3 COMMENT='岗位';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gangwei`
--

LOCK TABLES `gangwei` WRITE;
/*!40000 ALTER TABLE `gangwei` DISABLE KEYS */;
INSERT INTO `gangwei` VALUES (31,'2021-04-02 06:39:35','岗位1'),(32,'2021-04-02 06:39:35','岗位2'),(33,'2021-04-02 06:39:35','岗位3'),(34,'2021-04-02 06:39:35','岗位4'),(35,'2021-04-02 06:39:35','岗位5'),(36,'2021-04-02 06:39:35','岗位6'),(1617346389554,'2021-04-02 06:53:08','专员'),(1617346393892,'2021-04-02 06:53:13','主管');
/*!40000 ALTER TABLE `gangwei` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gonggaoxinxi`
--

DROP TABLE IF EXISTS `gonggaoxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gonggaoxinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gonggaobiaoti` varchar(200) NOT NULL COMMENT '公告标题',
  `tupian` varchar(200) DEFAULT NULL COMMENT '图片',
  `neirong` longtext COMMENT '内容',
  `faburiqi` date DEFAULT NULL COMMENT '发布日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COMMENT='公告信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gonggaoxinxi`
--

LOCK TABLES `gonggaoxinxi` WRITE;
/*!40000 ALTER TABLE `gonggaoxinxi` DISABLE KEYS */;
INSERT INTO `gonggaoxinxi` VALUES (1,'2026-11-24 07:04:12','墨页品牌上线：新图标与视觉语言','http://localhost:8080/springbootpkh49/upload/gonggaoxinxi_tupian1.jpg','<p>平台品牌升级为「墨页」：两字品牌名呼应页面意象，新图标采用薄荷圆角底、折角页文档、环绕轨道与云上传徽章。</p><p>官网与工作台共用同一套设计语言：黑胶囊主按钮、超大黑标题、薄荷网格面板与黑色描边收尾；亮暗双主题可在设置菜单随时切换。</p>','2026-11-24'),(2,'2026-11-24 07:04:12','Markdown 全链路上线','http://localhost:8080/springbootpkh49/upload/gonggaoxinxi_tupian2.jpg','<p>Markdown 导入、编辑、预览、下载四段打通：.md 拖拽即建档，MdEditor 源码写作，MdPreview 纸张式渲染，一键导出当前内容。</p><p>已有 Markdown 资产可无缝迁入，技术文档与手册从此有安静的安放之处。</p>','2026-11-22'),(3,'2026-11-24 07:04:12','历史版本功能上线','http://localhost:8080/springbootpkh49/upload/gonggaoxinxi_tupian3.jpg','<p>保存自动快照，单文档保留最近 50 版；历史抽屉支持逐版预览正文与一键恢复，恢复前自动快照，确保每次回退都可追溯。</p><p>误删与误改不再不可逆，版本链就是文档的后悔药。</p>','2026-11-21'),(4,'2026-11-24 07:04:12','项目分类功能上线','http://localhost:8080/springbootpkh49/upload/gonggaoxinxi_tupian4.jpg','<p>文档可归属项目，在线文档、Markdown 与 Office 附件跨格式聚合；侧栏实时计数，一键直达项目视图。</p><p>项目筛选与格式筛选、全局搜索可叠加，逐层收窄，沉淀再多也井然有序。</p>','2026-11-20'),(5,'2026-11-24 07:04:12','拖拽导入功能上线','http://localhost:8080/springbootpkh49/upload/gonggaoxinxi_tupian5.jpg','<p>文档中心支持整页拖拽：.md 与 Office 文件落页即自动建档，记录格式徽章与首版历史，全程无需点击按钮。</p><p>批量归档旧文件变成一次拖拽的事，迁移成本几乎为零。</p>','2026-11-19'),(6,'2026-11-24 07:04:12','暗色模式与设置菜单上线','http://localhost:8080/springbootpkh49/upload/gonggaoxinxi_tupian6.jpg','<p>右上角齿轮升级为设置菜单：亮暗切换、减少动效、默认视图三项设置本地持久化，菜单末项为后台入口。</p><p>暗色为完整变量层的真暗色，编辑器与表格同步换肤，夜间阅读不再刺眼。</p>','2026-11-23'),(7,'2026-11-24 07:04:12','附件格式支持说明','http://localhost:8080/springbootpkh49/upload/1617346355504.jpg','<p>平台支持 Word、PPT、Excel 三类 Office 附件上传与下载，拖拽导入自动记录格式与首版历史。</p><p>附件文档可与在线正文共存：正文快速浏览，附件深度阅读与离线流转，各取所需。</p>','2026-11-18');
/*!40000 ALTER TABLE `gonggaoxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `role` varchar(100) DEFAULT '管理员' COMMENT '角色',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'abo','abo','管理员','2021-04-02 06:39:35');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wendanglishi`
--

DROP TABLE IF EXISTS `wendanglishi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wendanglishi` (
  `id` bigint NOT NULL COMMENT '主键id',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `wendangid` bigint NOT NULL COMMENT '文档id',
  `wendangmingcheng` varchar(200) DEFAULT NULL COMMENT '文档名称快照',
  `leixing` varchar(200) DEFAULT NULL COMMENT '类型快照',
  `neirong` longtext COMMENT '富文本正文快照',
  `neirongmd` longtext COMMENT 'Markdown源码快照',
  `xiangmu` varchar(200) DEFAULT '' COMMENT '项目快照',
  `bianjiren` varchar(100) DEFAULT '访客' COMMENT '编辑人',
  `beizhu` varchar(200) DEFAULT '' COMMENT '版本备注',
  PRIMARY KEY (`id`),
  KEY `idx_wendangid` (`wendangid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档历史版本';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wendanglishi`
--

LOCK TABLES `wendanglishi` WRITE;
/*!40000 ALTER TABLE `wendanglishi` DISABLE KEYS */;
INSERT INTO `wendanglishi` VALUES (1795499422865,'2026-11-24 05:50:22',14,'校园网运维巡检手册','Markdown',' ','# 校园网运维巡检手册\n\n## 一、巡检范围\n\n- 核心交换机与汇聚链路\n- 无线 AP 在线率\n- MAC 地址绑定表清理\n\n## 二、常用命令\n\n```text\ndisplay interface brief\ndisplay mac-address\n```\n\n## 三、记录模板\n\n| 项目 | 状态 | 备注 |\n| --- | --- | --- |\n| 核心链路 | 正常 | 双上行 |\n| AP 在线率 | 98% | 3 台离线待查 |\n\n> 巡检结果当日录入系统，异常项挂公告跟进。','网络运维小组','访客','Markdown 导入'),(1795499523782,'2026-11-24 05:52:02',14,'校园网运维巡检手册','Markdown',' ','# 校园网运维巡检手册\n\n## 一、巡检范围\n\n- 核心交换机与汇聚链路\n- 无线 AP 在线率\n- MAC 地址绑定表清理\n\n## 二、常用命令\n\n```text\ndisplay interface brief\ndisplay mac-address\n```\n\n## 三、记录模板\n\n| 项目 | 状态 | 备注 |\n| --- | --- | --- |\n| 核心链路 | 正常 | 双上行 |\n| AP 在线率 | 98% | 3 台离线待查 |\n\n> 巡检结果当日录入系统，异常项挂公告跟进。\n\n## 四、补充\n\n- 本行由历史版本链路测试追加（v2）。','网络运维小组','访客','编辑保存'),(1795499596288,'2026-11-24 05:53:15',14,'校园网运维巡检手册','Markdown',' ','# 校园网运维巡检手册\n\n## 一、巡检范围\n\n- 核心交换机与汇聚链路\n- 无线 AP 在线率\n- MAC 地址绑定表清理\n\n## 二、常用命令\n\n```text\ndisplay interface brief\ndisplay mac-address\n```\n\n## 三、记录模板\n\n| 项目 | 状态 | 备注 |\n| --- | --- | --- |\n| 核心链路 | 正常 | 双上行 |\n| AP 在线率 | 98% | 3 台离线待查 |\n\n> 巡检结果当日录入系统，异常项挂公告跟进。\n\n## 四、补充\n\n- 本行由历史版本链路测试追加（v2）。','网络运维小组','访客','恢复前自动快照'),(1795499596492,'2026-11-24 05:53:16',14,'校园网运维巡检手册','Markdown',' ','# 校园网运维巡检手册\n\n## 一、巡检范围\n\n- 核心交换机与汇聚链路\n- 无线 AP 在线率\n- MAC 地址绑定表清理\n\n## 二、常用命令\n\n```text\ndisplay interface brief\ndisplay mac-address\n```\n\n## 三、记录模板\n\n| 项目 | 状态 | 备注 |\n| --- | --- | --- |\n| 核心链路 | 正常 | 双上行 |\n| AP 在线率 | 98% | 3 台离线待查 |\n\n> 巡检结果当日录入系统，异常项挂公告跟进。','网络运维小组','访客','恢复自 2026-11-24 13:50:22'),(1795503805080,'2026-11-24 07:03:24',1795497326184,'外观与个性化设置','在线文档','<p>右上角齿轮不再是后台直达入口，而是一个即开即合的设置菜单。</p>\n<h2>设置菜单</h2>\n<ul><li>外观：亮 / 暗分段切换，暗色为完整变量层的真暗色，而非简单反色；</li><li>减少动效：一键关闭滚动显现、跑马灯与呼吸光晕，低配设备与晕动用户友好；</li><li>默认视图：卡片 / 列表分段，记住你打开文档中心的偏好；</li><li>菜单末项「进入后台」，管理入口收纳但始终在场。</li></ul>\n<h2>持久化</h2>\n<p>全部设置写入 localStorage，下次打开自动恢复；主胶囊按钮随主题黑白反转，亮暗两态都保证对比度。</p>',NULL,'产品手册','访客','内容重写·首版'),(1795503805358,'2026-11-24 07:03:24',1795497326078,'附件管理与格式支持','在线文档','<p>离线文件也是文档资产：墨页为 Office 附件提供统一上传、归档与下载。</p>\n<h2>支持格式</h2>\n<ul><li>Word（.doc / .docx）：手册、制度、报告；</li><li>PPT（.ppt / .pptx）：演示、课件、答辩稿；</li><li>Excel（.xls / .xlsx）：台账、统计、名单。</li></ul>\n<h2>上传与拖拽</h2>\n<p>文档中心支持按钮上传与整页拖拽：文件落页即自动建档，记录格式徽章与首版历史。</p>\n<h2>下载与阅读</h2>\n<p>附件文档在阅读页提供原文件下载；在线正文与附件可共存，正文用于快速浏览，附件用于深度阅读。</p>',NULL,'产品手册','访客','内容重写·首版'),(1795503805438,'2026-11-24 07:03:24',52,'在线写作与阅读','在线文档','<p>工作台提供富文本与 Markdown 两种写作形态，写完即存，存完即可在文档中心检索与阅读。</p>\n<h2>写作</h2>\n<ul><li>富文本：wangEditor 编辑器，标题、列表、引用、图片与表格所见即所得；</li><li>Markdown：MdEditor 源码编辑、实时预览，适合技术文档与手册；</li><li>保存时自动记录历史版本，误改可随时回退。</li></ul>\n<h2>阅读</h2>\n<p>阅读页采用纸张式排版：薄荷引用简介、清晰标题层级、代码块高亮；操作条提供编辑、历史、下载胶囊按钮，读写切换不离开页面。</p>\n<blockquote>写完即沉淀，沉淀即可查——这是墨页的核心循环。</blockquote>',NULL,'产品手册','访客','内容重写·首版'),(1795503805439,'2026-11-24 07:03:24',51,'墨页平台总览','在线文档','<p>墨页是一个轻量在线文档管理平台：写作、管理、沉淀与分享，一个工作台就够了。</p>\n<h2>定位</h2>\n<p>把散落的文件与想法变成<strong>可检索、可维护</strong>的文档资产：在线写作即写即沉淀，附件上传统一归档，项目分类跨格式聚合。</p>\n<h2>技术架构</h2>\n<ul><li>后端：SpringBoot 2.2.2 + MyBatis-Plus + MySQL，统一 REST 接口与 Token 鉴权；</li><li>前端：Vue3 + Vite6 + Element Plus，访客工作台与管理后台双前端；</li><li>编辑器：wangEditor 富文本与 MdEditor Markdown 双引擎。</li></ul>\n<h2>设计语言</h2>\n<p>浅色极简底、薄荷绿主色，黑胶囊主按钮、超大黑标题与薄荷网格面板；工作台与官网共用同一套视觉基因，并支持真暗色模式。</p>',NULL,'产品手册','访客','内容重写·首版'),(1795503805581,'2026-11-24 07:03:24',53,'Markdown 全链路','在线文档','<p>Markdown 在墨页是一等公民：导入、编辑、预览、下载四段全部打通。</p>\n<h2>导入</h2>\n<p>支持 .md 文件选择上传与拖拽导入，导入后自动建档并记录首版历史。</p>\n<h2>编辑与预览</h2>\n<p>MdEditor 源码模式与预览模式自由切换；阅读页由 MdPreview 渲染，标题、表格、代码块完整支持，暗色模式下同步换肤。</p>\n<h2>下载</h2>\n<p>一键导出当前内容为 .md 文件，文件名与文档名一致，离开平台也能在其他工具里继续使用。</p>',NULL,'产品手册','访客','内容重写·首版'),(1795503805585,'2026-11-24 07:03:24',56,'项目分类与检索','在线文档','<p>文档可以归属项目，跨格式聚合，一次筛选直达全部。</p>\n<h2>项目分类</h2>\n<p>在线文档、Markdown、Word、PPT、Excel 任意格式都可归属同一项目；侧栏项目分类实时计数，点击进入该项目聚合视图。</p>\n<h2>检索</h2>\n<ul><li>顶栏全局搜索：文档名称与简介模糊匹配；</li><li>文档中心格式筛选：在线正文 / Markdown / Word / PPT / Excel 分类查看；</li><li>项目筛选与格式筛选可叠加，逐层收窄。</li></ul>\n<h2>管理端</h2>\n<p>后台文档列表提供项目列与搜索框，可批量维护归属与简介，前台聚合始终准确。</p>',NULL,'产品手册','访客','内容重写·首版'),(1795503805685,'2026-11-24 07:03:24',55,'历史版本与恢复','在线文档','<p>每次保存都会生成快照，每次误改都有后悔药。</p>\n<h2>自动快照</h2>\n<p>文档保存时系统把保存前内容写入历史版本表，单文档自动裁剪保留最近 50 版，无需手动维护。</p>\n<h2>查看与恢复</h2>\n<p>历史抽屉按时间倒序列出各版本，可预览每版正文；恢复前先对当前内容快照，再覆盖为目标版本，恢复操作本身也可追溯。</p>\n<h2>适用场景</h2>\n<ul><li>误删大段内容，想找回上一版；</li><li>对比两次修改的措辞差异；</li><li>多人改乱后回退到稳定版本。</li></ul>',NULL,'产品手册','访客','内容重写·首版'),(1795505211434,'2026-11-24 07:26:50',1617346475920,'Excel 格式上传示例','Excel','<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"121\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr></tbody></table><h2>台账说明</h2><p>本台账记录各部门文档资产的季度盘点结果，附件 Excel 为明细数据。</p><h3>统计口径</h3><ul><li>在线文档：正文非空的文档记录；</li><li>附件文档：挂有附件文件的记录；</li><li>同一记录可同时属于两类。</li></ul><p>明细请下载附件查看。</p>',' ','','访客','编辑保存'),(1795505233516,'2026-11-24 07:27:12',1617346475920,'Excel 格式上传示例','Excel','<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"121\">在线文档</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在线文档</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在线文档：</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr></tbody></table><h2>台账说明</h2><p>本台账记录各部门文档资产的季度盘点结果，附件 Excel 为明细数据。</p><h3>统计口径</h3><ul><li>在线文档：正文非空的文档记录；</li><li>附件文档：挂有附件文件的记录；</li><li>同一记录可同时属于两类。</li></ul><p>明细请下载附件查看。</p>',' ','','访客','编辑保存');
/*!40000 ALTER TABLE `wendanglishi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wendangxinxi`
--

DROP TABLE IF EXISTS `wendangxinxi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wendangxinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `wendangmingcheng` varchar(200) NOT NULL COMMENT '文档名称',
  `leixing` varchar(200) NOT NULL COMMENT '类型',
  `xiangmu` varchar(200) DEFAULT NULL COMMENT '所属项目',
  `wendangjieshao` longtext COMMENT '文档介绍',
  `neirong` longtext COMMENT '文档正文(富文本HTML)',
  `neirongmd` longtext COMMENT 'Markdown源码',
  `fujian` varchar(200) NOT NULL DEFAULT '' COMMENT '附件',
  `faburiqi` date DEFAULT NULL COMMENT '发布日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COMMENT='文档信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wendangxinxi`
--

LOCK TABLES `wendangxinxi` WRITE;
/*!40000 ALTER TABLE `wendangxinxi` DISABLE KEYS */;
INSERT INTO `wendangxinxi` VALUES (1,'2026-11-24 07:04:12','墨页平台总览','在线文档','产品手册','平台定位、技术架构与设计语言总览。','<p>墨页是一个轻量在线文档管理平台：写作、管理、沉淀与分享，一个工作台就够了。</p>\n<h2>定位</h2>\n<p>把散落的文件与想法变成<strong>可检索、可维护</strong>的文档资产：在线写作即写即沉淀，附件上传统一归档，项目分类跨格式聚合。</p>\n<h2>技术架构</h2>\n<ul><li>后端：SpringBoot 2.2.2 + MyBatis-Plus + MySQL，统一 REST 接口与 Token 鉴权；</li><li>前端：Vue3 + Vite6 + Element Plus，访客工作台与管理后台双前端；</li><li>编辑器：wangEditor 富文本与 MdEditor Markdown 双引擎。</li></ul>\n<h2>设计语言</h2>\n<p>浅色极简底、薄荷绿主色，黑胶囊主按钮、超大黑标题与薄荷网格面板；工作台与官网共用同一套视觉基因，并支持真暗色模式。</p>',NULL,'http://localhost:8080/springbootpkh49/upload/1617346216078.pptx','2026-11-24'),(2,'2026-11-24 07:04:12','在线写作与阅读','在线文档','产品手册','富文本与 Markdown 双引擎写作、纸张式阅读体验说明。','<p>工作台提供富文本与 Markdown 两种写作形态，写完即存，存完即可在文档中心检索与阅读。</p>\n<h2>写作</h2>\n<ul><li>富文本：wangEditor 编辑器，标题、列表、引用、图片与表格所见即所得；</li><li>Markdown：MdEditor 源码编辑、实时预览，适合技术文档与手册；</li><li>保存时自动记录历史版本，误改可随时回退。</li></ul>\n<h2>阅读</h2>\n<p>阅读页采用纸张式排版：薄荷引用简介、清晰标题层级、代码块高亮；操作条提供编辑、历史、下载胶囊按钮，读写切换不离开页面。</p>\n<blockquote>写完即沉淀，沉淀即可查——这是墨页的核心循环。</blockquote>',NULL,'','2026-11-24'),(3,'2026-11-24 07:04:12','Markdown 全链路','在线文档','产品手册','Markdown 导入、编辑、预览、下载四段全链路说明。','<p>Markdown 在墨页是一等公民：导入、编辑、预览、下载四段全部打通。</p>\n<h2>导入</h2>\n<p>支持 .md 文件选择上传与拖拽导入，导入后自动建档并记录首版历史。</p>\n<h2>编辑与预览</h2>\n<p>MdEditor 源码模式与预览模式自由切换；阅读页由 MdPreview 渲染，标题、表格、代码块完整支持，暗色模式下同步换肤。</p>\n<h2>下载</h2>\n<p>一键导出当前内容为 .md 文件，文件名与文档名一致，离开平台也能在其他工具里继续使用。</p>',NULL,'','2026-11-24'),(4,'2026-11-24 07:04:12','历史版本与恢复','在线文档','产品手册','保存自动快照、50 版上限与恢复机制说明。','<p>每次保存都会生成快照，每次误改都有后悔药。</p>\n<h2>自动快照</h2>\n<p>文档保存时系统把保存前内容写入历史版本表，单文档自动裁剪保留最近 50 版，无需手动维护。</p>\n<h2>查看与恢复</h2>\n<p>历史抽屉按时间倒序列出各版本，可预览每版正文；恢复前先对当前内容快照，再覆盖为目标版本，恢复操作本身也可追溯。</p>\n<h2>适用场景</h2>\n<ul><li>误删大段内容，想找回上一版；</li><li>对比两次修改的措辞差异；</li><li>多人改乱后回退到稳定版本。</li></ul>',NULL,'','2026-11-24'),(5,'2026-11-24 07:04:12','项目分类与检索','在线文档','产品手册','项目聚合、格式筛选与全局搜索说明。','<p>文档可以归属项目，跨格式聚合，一次筛选直达全部。</p>\n<h2>项目分类</h2>\n<p>在线文档、Markdown、Word、PPT、Excel 任意格式都可归属同一项目；侧栏项目分类实时计数，点击进入该项目聚合视图。</p>\n<h2>检索</h2>\n<ul><li>顶栏全局搜索：文档名称与简介模糊匹配；</li><li>文档中心格式筛选：在线正文 / Markdown / Word / PPT / Excel 分类查看；</li><li>项目筛选与格式筛选可叠加，逐层收窄。</li></ul>\n<h2>管理端</h2>\n<p>后台文档列表提供项目列与搜索框，可批量维护归属与简介，前台聚合始终准确。</p>',NULL,'','2026-11-24'),(6,'2026-11-24 07:04:12','PPT 格式上传示例','PPT','','演示演示文稿上传、类型徽章与下载链路；附件为通用模板文件。',NULL,NULL,'http://localhost:8080/springbootpkh49/upload/1617346465322.pptx','2021-04-02'),(7,'2026-11-24 07:04:12','Word 格式上传示例','Word','','演示 Word 上传与在线正文共存；附件为通用手册文件。','<h2>一、系统简介</h2><p>墨绿文档是一个基于 <strong>SpringBoot + Vue3</strong> 的在线文档管理系统，支持<strong>在线撰写</strong>与<strong>附件管理</strong>两种文档形态。</p><h2>二、快速上手</h2><ol><li>打开前台工作台，点击顶栏「新建文档」；</li><li>填写标题、选择类型，在正文编辑器中直接书写；</li><li>需要挂附件时点击「上传附件」，支持 Word / PPT / Excel / PDF；</li><li>点击「保存」，文档立即出现在文档中心，可在线阅读。</li></ol><h2>三、检索与筛选</h2><p>文档中心支持关键词模糊搜索（命中高亮）、按类型筛选、按日期或名称排序。左侧分类导航实时显示各类型数量。</p><blockquote>提示：后台管理入口在工作台右上角齿轮图标，账号 abo / abo。</blockquote>',NULL,'/springbootpkh49/upload/在线文档管理系统使用手册.docx','2026-11-20'),(8,'2026-11-24 07:04:12','Word 拖拽导入示例','Word','','演示拖拽 .docx 自动建档与首版历史；附件为通用指引文件。','<h2>欢迎加入</h2>\n<p>本指引帮助新同事在入职第一周快速熟悉环境与流程。</p>\n<h3>第 1 天：账号与环境</h3>\n<ul><li>领取工卡与设备，激活企业邮箱；</li><li>登录本系统，阅读部门文档库中的制度文件。</li></ul>\n<h3>第 2-3 天：制度学习</h3>\n<ul><li>考勤与请假制度；</li><li>信息安全与保密规范；</li><li>报销流程与标准。</li></ul>\n<h3>第 4-5 天：融入团队</h3>\n<p>与导师完成一次一对一沟通，明确试用期目标；参加部门例会并做自我介绍。</p>\n<blockquote>有任何问题，联系 HR 或你的入职导师。</blockquote>',NULL,'/springbootpkh49/upload/新员工入职指引.docx','2026-11-20'),(9,'2026-11-24 07:04:12','PPT 拖拽导入示例','PPT','','演示拖拽 .pptx 自动建档与格式徽章；附件为通用汇报文件。','<h2>季度概览</h2>\n<p>本季度围绕「文档资产沉淀」与「协作效率」两条主线推进工作。</p>\n<h3>关键成果</h3>\n<ul><li>文档库新增在线正文能力，沉淀效率显著提升；</li><li>完成历史附件文档的分类归档；</li><li>公告通道完成富文本化改造。</li></ul>\n<h3>下季度计划</h3>\n<p>推进文档质量评审机制，探索版本历史与权限细化。</p>',NULL,'/springbootpkh49/upload/2026年第一季度工作汇报.pptx','2026-11-20'),(10,'2026-11-24 07:04:12','Excel 格式上传示例','Excel',NULL,'演示表格附件归档与下载；附件为通用台账文件。','<table style=\"width: auto;\"><tbody><tr><th colSpan=\"1\" rowSpan=\"1\" width=\"121\">在线文档</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在线文档</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\">在线文档：</th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th><th colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></th></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr><tr><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td><td colSpan=\"1\" rowSpan=\"1\" width=\"auto\"></td></tr></tbody></table><h2>台账说明</h2><p>本台账记录各部门文档资产的季度盘点结果，附件 Excel 为明细数据。</p><h3>统计口径</h3><ul><li>在线文档：正文非空的文档记录；</li><li>附件文档：挂有附件文件的记录；</li><li>同一记录可同时属于两类。</li></ul><p>明细请下载附件查看。</p>',' ','/springbootpkh49/upload/部门文档统计台账.xlsx','2026-11-20'),(11,'2026-11-24 07:04:12','Excel 检索筛选示例','Excel','','演示附件文档参与搜索与类型筛选；附件为通用名单文件。','<h2>通讯录说明</h2>\n<p>本通讯录按部门整理全员联系方式，附件 Excel 为完整名单。</p>\n<blockquote>个人信息仅限内部工作联络使用，请勿外传。</blockquote>',NULL,'/springbootpkh49/upload/员工通讯录.xlsx','2026-11-20'),(12,'2026-11-24 07:04:12','附件管理与格式支持','在线文档','产品手册','Office 附件上传、拖拽与下载支持说明。','<p>离线文件也是文档资产：墨页为 Office 附件提供统一上传、归档与下载。</p>\n<h2>支持格式</h2>\n<ul><li>Word（.doc / .docx）：手册、制度、报告；</li><li>PPT（.ppt / .pptx）：演示、课件、答辩稿；</li><li>Excel（.xls / .xlsx）：台账、统计、名单。</li></ul>\n<h2>上传与拖拽</h2>\n<p>文档中心支持按钮上传与整页拖拽：文件落页即自动建档，记录格式徽章与首版历史。</p>\n<h2>下载与阅读</h2>\n<p>附件文档在阅读页提供原文件下载；在线正文与附件可共存，正文用于快速浏览，附件用于深度阅读。</p>',NULL,'','2026-11-24'),(13,'2026-11-24 07:04:12','外观与个性化设置','在线文档','产品手册','设置菜单、真暗色模式与本地持久化说明。','<p>右上角齿轮不再是后台直达入口，而是一个即开即合的设置菜单。</p>\n<h2>设置菜单</h2>\n<ul><li>外观：亮 / 暗分段切换，暗色为完整变量层的真暗色，而非简单反色；</li><li>减少动效：一键关闭滚动显现、跑马灯与呼吸光晕，低配设备与晕动用户友好；</li><li>默认视图：卡片 / 列表分段，记住你打开文档中心的偏好；</li><li>菜单末项「进入后台」，管理入口收纳但始终在场。</li></ul>\n<h2>持久化</h2>\n<p>全部设置写入 localStorage，下次打开自动恢复；主胶囊按钮随主题黑白反转，亮暗两态都保证对比度。</p>',NULL,'','2026-11-24'),(14,'2026-11-24 05:50:22','校园网运维巡检手册','Markdown','网络运维小组','Markdown 导入与渲染演示文档',' ','# 校园网运维巡检手册\n\n## 一、巡检范围\n\n- 核心交换机与汇聚链路\n- 无线 AP 在线率\n- MAC 地址绑定表清理\n\n## 二、常用命令\n\n```text\ndisplay interface brief\ndisplay mac-address\n```\n\n## 三、记录模板\n\n| 项目 | 状态 | 备注 |\n| --- | --- | --- |\n| 核心链路 | 正常 | 双上行 |\n| AP 在线率 | 98% | 3 台离线待查 |\n\n> 巡检结果当日录入系统，异常项挂公告跟进。','','2026-11-24');
/*!40000 ALTER TABLE `wendangxinxi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `yuangong`
--

DROP TABLE IF EXISTS `yuangong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `yuangong` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yuangonggonghao` varchar(200) NOT NULL COMMENT '员工工号',
  `mima` varchar(200) NOT NULL COMMENT '密码',
  `yuangongxingming` varchar(200) DEFAULT NULL COMMENT '员工姓名',
  `xingbie` varchar(200) DEFAULT NULL COMMENT '性别',
  `touxiang` varchar(200) DEFAULT NULL COMMENT '头像',
  `bumen` varchar(200) DEFAULT NULL COMMENT '部门',
  `gangwei` varchar(200) DEFAULT NULL COMMENT '岗位',
  `nianling` int DEFAULT NULL COMMENT '年龄',
  `shouji` varchar(200) DEFAULT NULL COMMENT '手机',
  `youxiang` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `shenfenzheng` varchar(200) DEFAULT NULL COMMENT '身份证',
  PRIMARY KEY (`id`),
  UNIQUE KEY `yuangonggonghao` (`yuangonggonghao`)
) ENGINE=InnoDB AUTO_INCREMENT=1617346426235 DEFAULT CHARSET=utf8mb3 COMMENT='员工';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yuangong`
--

LOCK TABLES `yuangong` WRITE;
/*!40000 ALTER TABLE `yuangong` DISABLE KEYS */;
INSERT INTO `yuangong` VALUES (41,'2021-04-02 06:39:35','员工1','123456','员工姓名1','男','http://localhost:8080/springbootpkh49/upload/yuangong_touxiang1.jpg','部门1','岗位1',1,'13823888881','773890001@qq.com','440300199101010001'),(42,'2021-04-02 06:39:35','员工2','123456','员工姓名2','男','http://localhost:8080/springbootpkh49/upload/yuangong_touxiang2.jpg','部门2','岗位2',2,'13823888882','773890002@qq.com','440300199202020002'),(43,'2021-04-02 06:39:35','员工3','123456','员工姓名3','男','http://localhost:8080/springbootpkh49/upload/yuangong_touxiang3.jpg','部门3','岗位3',3,'13823888883','773890003@qq.com','440300199303030003'),(44,'2021-04-02 06:39:35','员工4','123456','员工姓名4','男','http://localhost:8080/springbootpkh49/upload/yuangong_touxiang4.jpg','部门4','岗位4',4,'13823888884','773890004@qq.com','440300199404040004'),(45,'2021-04-02 06:39:35','员工5','123456','员工姓名5','男','http://localhost:8080/springbootpkh49/upload/yuangong_touxiang5.jpg','部门5','岗位5',5,'13823888885','773890005@qq.com','440300199505050005'),(46,'2021-04-02 06:39:35','员工6','123456','员工姓名6','男','http://localhost:8080/springbootpkh49/upload/yuangong_touxiang6.jpg','部门6','岗位6',6,'13823888886','773890006@qq.com','440300199606060006'),(1617346426234,'2021-04-02 06:53:46','1','1','陈一','女','http://localhost:8080/springbootpkh49/upload/1617346408141.jpg','市场部','专员',25,'12345678978','123@qq.com','123456789789456123');
/*!40000 ALTER TABLE `yuangong` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-27  8:55:10
