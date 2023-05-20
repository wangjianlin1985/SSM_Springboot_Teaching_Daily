/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : teach_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2019-03-07 18:20:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_classinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_classinfo`;
CREATE TABLE `t_classinfo` (
  `classNo` varchar(20) NOT NULL COMMENT 'classNo',
  `className` varchar(50) NOT NULL COMMENT '班级名称',
  `bornDate` varchar(20) default NULL COMMENT '开办日期',
  `mainTeacher` varchar(20) NOT NULL COMMENT '班主任',
  `classDesc` varchar(500) NOT NULL COMMENT '班级备注',
  PRIMARY KEY  (`classNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_classinfo
-- ----------------------------
INSERT INTO `t_classinfo` VALUES ('BJ001', '计算机1班', '2019-02-21', '李晓飞', '测试班级');
INSERT INTO `t_classinfo` VALUES ('BJ002', '计算机2班', '2019-03-07', '王翔', 'test');

-- ----------------------------
-- Table structure for `t_course`
-- ----------------------------
DROP TABLE IF EXISTS `t_course`;
CREATE TABLE `t_course` (
  `courseNo` varchar(20) NOT NULL COMMENT 'courseNo',
  `courseName` varchar(80) NOT NULL COMMENT '课程名称',
  `coursePhoto` varchar(60) NOT NULL COMMENT '课程照片',
  `dagang` varchar(8000) NOT NULL COMMENT '课程大纲',
  `courseHours` int(11) NOT NULL COMMENT '总课时',
  `courseScore` float NOT NULL COMMENT '课程学分',
  `teacherObj` varchar(30) NOT NULL COMMENT '上课老师',
  `classObj` varchar(20) NOT NULL COMMENT '上课班级',
  `courseMemo` varchar(500) default NULL COMMENT '课程备注',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`courseNo`),
  KEY `teacherObj` (`teacherObj`),
  KEY `classObj` (`classObj`),
  CONSTRAINT `t_course_ibfk_1` FOREIGN KEY (`teacherObj`) REFERENCES `t_teacher` (`teacherNo`),
  CONSTRAINT `t_course_ibfk_2` FOREIGN KEY (`classObj`) REFERENCES `t_classinfo` (`classNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_course
-- ----------------------------
INSERT INTO `t_course` VALUES ('KC001', 'PHP网站开发', 'upload/64287465-6a31-4771-a06b-e8a4b183abff.jpg', '<p>第一课：PHP程序员培训开山篇</p><p>第二课：HTML基础（什么是标签、属性、元素、基本HTML的格式、代码注释以及编辑器、调试）</p><p>第三课：常用的HTML标签之文本标签</p><p>第四课：常用的HTML标签之列表和表格</p><p>第五课：CSS基础（简介、语法以及引入）</p><p>第六课：<a href=\"https://link.jianshu.com?t=http://www.leixuesong.cn/1167\" target=\"_blank\">CSS选择器</a>（id、class、组合、嵌套、属性选择器）</p><p>第七课：CSS常用属性和值（宽高、字体大小、颜色、行高、对齐方式、背景、边框、链接、表格、列表）</p><p>第八课：CSS框模型(Box Model)（内边距、宽高、边框、外边距）</p><p>第九课：CSS布局（定位与浮动）</p><p>第十课：HTML+CSS小结与综合练习（ps切片工具的使用、浏览器兼容性）</p><p>第十一课：HTML5与CSS3介绍（HTML新增标签、CSS新增属性）</p><p>第十二课：HTML技巧（图片拼接、代码压缩、减少嵌套、注意代码可维护性、SEO基本常识）</p><p>第十三课：Javascript基础（JS简介、用法、调试）</p><p>第十四课：JS变量、数据类型以及条件语句</p><p>第十五课：JS DOM与BOM</p><p>第十六课：JS函数、闭包以及作用域</p><p>第十七课：JS常用的函数（字符串、数组、日期、数学函数）</p><p>第十八课：HTML + CSS + JS实战</p><p>第十九课：Jquery讲解(选择器、函数、ajax、常用插件)</p><p>第二十课：<a href=\"https://link.jianshu.com?t=http://www.leixuesong.cn/tag/nodejs\" target=\"_blank\">Nodejs讲解（安装、npm用法）</a></p><p>第二十一课：<a href=\"https://link.jianshu.com?t=http://www.leixuesong.cn/tag/bootstrap\" target=\"_blank\">响应式布局以及bootstrap讲解</a></p><p>第二十二课：<a href=\"https://link.jianshu.com?t=http://www.leixuesong.cn/439\" target=\"_blank\">正则表达式（简介、元字符、匹配规则）</a></p><p>第二十三课：WEB前端总结以及结课（对前期的内容总结以及展望）</p><p>第二十四课：PHP安装和WAMP使用</p><p>第二十五课：PHP基础（简介、语法、数据类型）</p><p>第二十六课：PHP变量、数据类型以及条件语句</p><p>第二十七课：PHP超级全局变量、魔术变量、命名空间</p><p>第二十八课：PHP函数（字符串、数组、文件、数学、日期、HTTP、图像处理）</p><p>第二十九课：PHP会话cookie和session</p><p>第三十课：MySQL简介和表设计</p><p>第三十一课：MySQL操作（增、删、查、改、导入、导出）</p><p>第三十二课：<a href=\"https://link.jianshu.com?t=http://www.leixuesong.cn/327\" target=\"_blank\">MySQL常用函数（字符串、数学、时间、数组函数、日期函数、数据库函数）</a></p><p>第三十三课：MySQL高级之触发器以及事件</p><p>第三十四课：PHP面向对象编程</p><p>第三十五课：PHP+MySQL小结与综合练习(常用资源域名、服务器、短信网关)</p><p>第三十六课：PHP常用框架ThinkPHP</p><p>第三十七课：PHP CMS之WordPress和织梦</p><p>第三十八课：网站的部署流程</p><p>第三十九课：Linux简介以及CentOS下LAMP安装（面试时加分项）</p><p>第四十课：NoSQL相关介绍，包括<a href=\"https://link.jianshu.com?t=http://www.leixuesong.cn/tag/redis\" target=\"_blank\">Redis</a>，<a href=\"https://link.jianshu.com?t=http://www.leixuesong.cn/tag/mongodb\" target=\"_blank\">Mongodb</a>，<a href=\"https://link.jianshu.com?t=http://www.leixuesong.cn/tag/memcache\" target=\"_blank\">Memcache</a>（面试时加分项）</p><p>第四十一课：PHP总结与商城练习</p><p>第四十二课：PHP程序员求职技巧（为人谦逊、自信大方</p><p><br/><br/>作者：PHP程序员雷雪松<br/>链接：https://www.jianshu.com/p/10aeee4ca5bd<br/>来源：简书<br/>简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。</p><p><br/></p>', '42', '3.5', 'TH001', 'BJ001', '测试', '2019-02-28 02:17:59');
INSERT INTO `t_course` VALUES ('KC002', '高等数学', 'upload/fa7a9b2a-af0d-4fdc-874a-3d1bd4c4aefd.jpg', '<p style=\"line-height: 0.31in;text-indent: 0.33in;margin-bottom: 0in\"><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><strong>一、课程目标</strong></span></p><p style=\"line-height: 0.31in;text-indent: 0.33in;margin-bottom: 0in\">1<span style=\"font-family: 楷体_gb2312, 楷体, monospace\">、本课程在理工科各专业的教学计划中是一门十分重要的基础理论课程，为学习后继课程和进一步获取数学知识（如概率论与数理统计等）奠定必要的数学基础，也是硕士研究生入学考试的必考课程之一。通过本课程的学习，一方面使学生掌握函数与极限、一元微分学、一元积分学、多元微分学、多元积分学、无穷级数、微分方程等基础知识，能熟练的运用其分析、解决一些实际问题；另一方面通过各个教学环节，培养学生具有一定的抽象思维能力、逻辑推理能力和空间想象能力。</span></p><p style=\"line-height: 0.31in;text-indent: 0.33in;margin-bottom: 0.11in\"><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><strong>二、课程目标、教学方法与毕业要求的对应关系</strong></span></p><table width=\"569\"><colgroup><col width=\"88\"/></colgroup><colgroup><col width=\"250\"/></colgroup><colgroup><col width=\"82\"/></colgroup><colgroup><col width=\"91\"/></colgroup><tbody><tr valign=\"TOP\" class=\"firstRow\"><td width=\"88\"><p><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">毕业要求</span></p></td><td width=\"250\"><p><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">毕业要求指标点</span></p></td><td width=\"82\"><p><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">课程目标</span></p></td><td width=\"91\"><p><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">教学方法</span></p></td></tr><tr><td width=\"88\"><p>1<span style=\"font-family: 楷体_gb2312, 楷体, monospace\">工程知识：能够将数学、自然科学、工程基础和专业知识用于解决复杂工程问题。</span></p></td><td width=\"250\"><p>1.1<span style=\"font-family: 楷体_gb2312, 楷体, monospace\">能将数学、自然科学、工程基础和专业知识运用到复杂计算机工程问题的恰当表述中。</span></p></td><td width=\"82\"><p><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">课程目标</span>1</p></td><td width=\"91\"><p><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">多媒体讲授，阐述基本原理。</span></p></td></tr></tbody></table><p style=\"line-height: 0.31in;text-indent: 0.33in;margin-bottom: 0in\"><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><strong>三、教学基本内容</strong></span></p><p style=\"line-height: 0.31in;text-indent: 0.33in;margin-bottom: 0in\"><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><strong>（一）函数与极限（支撑课程目标</strong></span><strong>1</strong><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">）</span></p><p style=\"line-height: 0.31in;text-indent: 0.33in;margin-bottom: 0in\"><span style=\"font-family: 宋体, simsun\"><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><strong>内容</strong></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">：映射与函数；数列的极限；函数的极限；无穷小与无穷大；极限运算法则；极限存在准则；两个重要极限；无穷小的比较；函数的连续性与间断点；连续函数的运算与初等函数的连续性；闭区间上连续函数的性质。</span></span></p><p style=\"line-height: 0.31in;text-indent: 0.33in;margin-bottom: 0in\"><span style=\"font-family: 宋体, simsun\"><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><strong>要求</strong></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">：理解函数的概念；了解函数奇偶性、单调性、周期性和有界性；理解复合函数的概念；了解反函数的概念；掌握基本初等函数的性质及其图形；会建立简单实际问题中的函数关系式；理解极限的概念（对极限的定义可在学习过程中逐步加深理解，对于给出</span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><img src=\"/ueditor/jsp/upload/image/20190307/1551951483087085184.gif\" width=\"13\" height=\"15\"/></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">求</span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><img src=\"/ueditor/jsp/upload/image/20190307/1551951483183083561.gif\" width=\"19\" height=\"19\"/></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">或</span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><img src=\"/ueditor/jsp/upload/image/20190307/1551951483224060152.gif\" width=\"15\" height=\"19\"/></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">不作要求）；掌握极限四则运算法则；了解两个极限存在准则（夹逼准则和单调有界准则），会用两个重要极限求极限；了解无穷小、无穷大，以及无穷小的阶的概念；会用等价无穷小求极限；理解函数在一点连续的概念；了解间断点的概念，并会判别间断点的类型；了解初等函数的连续性闭区间上连续函数的性质（介值定理和最大、最小值定理）。</span></span></p><p style=\"line-height: 0.31in;text-indent: 0.33in;margin-bottom: 0in\"><span style=\"font-family: 宋体, simsun\"><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><strong>重点</strong></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">：基本初等函数的性质及其图形；极限的概念（对极限的定义可在学习过程中逐步加深理解，对于给出</span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><img src=\"/ueditor/jsp/upload/image/20190307/1551951483267064959.gif\" width=\"13\" height=\"15\"/></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">求</span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><img src=\"/ueditor/jsp/upload/image/20190307/1551951483316007558.gif\" width=\"19\" height=\"19\"/></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">或</span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\"><img src=\"/ueditor/jsp/upload/image/20190307/1551951483361046354.gif\" width=\"15\" height=\"19\"/></span><span style=\"font-family: 楷体_gb2312, 楷体, monospace\">不作要求）；极限四则运算法则；两个重要极限求极限；无穷小、无穷大，以及无穷小的阶的概念；利用等价无穷小求极限；函数在一点连续的概念；间断点的概念，并判别间断点的类型；了解初等函数的连续性闭区间上连续函数的性质（介值定理和最大、最小值定理）。</span></span></p><p><br/></p>', '32', '3.5', 'TH001', 'BJ001', 'test', '2019-03-07 16:20:43');
INSERT INTO `t_course` VALUES ('KC003', '大学英语', 'upload/2d01a999-b03e-4d0f-88b5-21a9c5552871.jpg', '<p style=\"font-family: ����;font-size: 14px;white-space: normal;text-indent: 32px\"><span style=\"font-family:仿宋_GB2312\"><span style=\"font-size:16px\"><span style=\"color: windowtext\">大学英语课程是大学生的一门必修公共基础课程，大学英语教学是高等教育的一个有机组成部分。</span></span></span></p><p style=\"font-family: ����;font-size: 14px;white-space: normal;text-indent: 32px\"><span style=\"font-size:16px\"><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">大学英语课程的教学任务是通过培养学生英语综合应用能力，使学生在完成所规定学时的学习后，能够比较正确地使用英语语言进行交流，能够借助参考书籍阅读英文原版教材，能够进行基本的专业文书翻译，能够用英语进行口头和书面交流。同时，通过在教学中对英美文化的讲授，使学生对英美文化有较多了解，为学生进一步学习英语以及出国深造打下较扎实的语言基础和文化基础。具体体现在四个方面能力的培养：</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">1</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">）培养学生的读写实用能力；</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">2</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">）培养学生的听说应用能力；</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">3</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">）培养学生的自主学习能力；</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">4</span><span style=\"font-family:仿宋_GB2312\"><span style=\"color: windowtext\">）培养学生的文化素养和交际能力。</span></span></span></p><p style=\"font-family: ����;font-size: 14px;white-space: normal;text-indent: 32px\"><span style=\"font-size:16px\"><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">我校大学英语教学按照因材施教的原则，实行分级指导，以适应差异化的现状和个性化的实际需要。结合高考英语成绩，将学生为三个级别，即更高要求（</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">A</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">级）、较高要求（</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">B</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">级）和一般要求（</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">C</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">级）。本大纲适用于更高要求（</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">A</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">级）能力的培养。学生入学的起点词汇量应为</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">2200</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">词（标准要求），最低不得少于</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">1500</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">词。在完成</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">96</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">学时教学后，学生的词汇量应达到</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">4500</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">个单词和</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">600</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">－</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">700</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">个词组；能听懂一般性题材讲座和基本听懂语速适中的英语节目；能就熟悉的话题经准备后作简短发言，能就日常话题和英语国家人士进行交谈；能熟练掌握和运用各种英语通常语法知识，读懂自己专业的英文教材，正确理解中心大意，能抓住主要事实和细节。能够用英文写日常应用文；借助参考书能用英文写出与专业有关的、结构通常清晰、内容充实的报告和文章；能就一般题目在半小时内写出</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">120</span><span style=\"font-family:仿宋_GB2312\"><span style=\"color: windowtext\">字左右的短文，内容完整，语句通顺；能借助词典对题材熟悉的文章进行英汉互译，译文基本流畅，能在翻译时使用适当的翻译技巧。</span></span></span></p><p style=\"font-family: ����;font-size: 14px;white-space: normal;text-indent: 32px\"><span style=\"font-size:16px\"><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">在实际教学中，坚持以学生为中心、以方法为主导、以训练英语思维为导向的教学原则和以交际为目的、师生互动的教学方法，反对</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">“</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">应试教育</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">”</span><span style=\"font-family:仿宋_GB2312\"><span style=\"color: windowtext\">，充分调动、发挥学生主体性的学习方式，彻底实行兴趣驱动学习英语的法则。学英语教学是以英语语言知识与应用技能、学习策略和跨文化交际为主要内容，以外语教学理论为指导，并集多种教学模式和教学手段为一体的教学体系。</span></span></span></p><p style=\"font-family: ����;font-size: 14px;white-space: normal;text-indent: 32px\"><span style=\"font-size:16px\"><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">本课程的作业形式包括随堂测验、课堂听写、课后翻译和课后写作。作业次数为每学期</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">5</span><span style=\"color: windowtext\"><span style=\"font-family:仿宋_GB2312\">到</span></span><span style=\"font-family: &#39;Times New Roman&#39;, serif;color: windowtext\">6</span><span style=\"font-family:仿宋_GB2312\"><span style=\"color: windowtext\">次。本课程考核形式在第一学期为考查，在第二学期为考试。</span></span></span></p><p><br/></p>', '36', '4', 'TH002', 'BJ001', 'test', '2019-03-07 16:32:26');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '教师日程管理系统成立', '<p>管理教师日常工作任务<br/></p>', '2019-02-28 02:19:53');

-- ----------------------------
-- Table structure for `t_student`
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student` (
  `studentNo` varchar(30) NOT NULL COMMENT 'studentNo',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `classObj` varchar(20) NOT NULL COMMENT '所在班级',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`studentNo`),
  KEY `classObj` (`classObj`),
  CONSTRAINT `t_student_ibfk_1` FOREIGN KEY (`classObj`) REFERENCES `t_classinfo` (`classNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_student
-- ----------------------------
INSERT INTO `t_student` VALUES ('STU001', '123', 'BJ001', '张喜红', '女', '2019-02-13', 'upload/6cfbc9e5-122e-4444-baff-af9a08ad6c29.jpg', '13598349834', 'zhangxia@163.com', '四川成都红星路aabb', '2019-02-28 02:11:15');
INSERT INTO `t_student` VALUES ('STU002', '123', 'BJ002', '李晓彤', '女', '2019-03-06', 'upload/09e7f400-0ed9-47ce-a9a2-a6dc90537f12.jpg', '13958342342', 'xiaoteng@163.com', '四川南充机场路12号a', '2019-03-07 17:07:03');

-- ----------------------------
-- Table structure for `t_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_task`;
CREATE TABLE `t_task` (
  `taskId` int(11) NOT NULL auto_increment COMMENT '任务id',
  `title` varchar(80) NOT NULL COMMENT '任务标题',
  `content` varchar(8000) NOT NULL COMMENT '任务内容',
  `workDays` float NOT NULL COMMENT '工作量天数',
  `pubTime` varchar(20) default NULL COMMENT '发布时间',
  `teacherObj` varchar(30) NOT NULL COMMENT '接受任务老师',
  `finishDesc` varchar(5000) NOT NULL COMMENT '完成进度汇报',
  `taskMemo` varchar(500) default NULL COMMENT '任务备注',
  PRIMARY KEY  (`taskId`),
  KEY `teacherObj` (`teacherObj`),
  CONSTRAINT `t_task_ibfk_1` FOREIGN KEY (`teacherObj`) REFERENCES `t_teacher` (`teacherNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_task
-- ----------------------------
INSERT INTO `t_task` VALUES ('1', '完成3月计划表', '<p>完成3月计划表完成3月计划表完成3月计划表完成3月计划表完成3月计划表完成3月计划表完成3月计划表完成3月计划表完成3月计划表</p>', '3.5', '2019-02-28 02:12:08', 'TH001', '<p>40%</p>', '测试');
INSERT INTO `t_task` VALUES ('2', '走访下学生家长', '<p>去学生家访下，了解学生的家庭情况</p>', '15', '2019-03-07 17:36:21', 'TH001', '<p>完成了一半学生家访了</p>', 'test');

-- ----------------------------
-- Table structure for `t_teach`
-- ----------------------------
DROP TABLE IF EXISTS `t_teach`;
CREATE TABLE `t_teach` (
  `teachId` int(11) NOT NULL auto_increment COMMENT '记录id',
  `courseObj` varchar(20) NOT NULL COMMENT '课程名称',
  `teacherObj` varchar(30) NOT NULL COMMENT '上课老师',
  `weekDay` varchar(20) NOT NULL COMMENT '上课时间',
  `sectionNum` varchar(20) NOT NULL COMMENT '上课节次',
  `classRoom` varchar(50) NOT NULL COMMENT '上课教室',
  `teachMemo` varchar(500) default NULL COMMENT '日历备注',
  PRIMARY KEY  (`teachId`),
  KEY `courseObj` (`courseObj`),
  KEY `teacherObj` (`teacherObj`),
  CONSTRAINT `t_teach_ibfk_1` FOREIGN KEY (`courseObj`) REFERENCES `t_course` (`courseNo`),
  CONSTRAINT `t_teach_ibfk_2` FOREIGN KEY (`teacherObj`) REFERENCES `t_teacher` (`teacherNo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teach
-- ----------------------------
INSERT INTO `t_teach` VALUES ('1', 'KC001', 'TH001', '星期二', '上午1-2节', '6A-203', '测试');
INSERT INTO `t_teach` VALUES ('4', 'KC003', 'TH002', '星期二', '下午1,2节', '6A-203', 'test');

-- ----------------------------
-- Table structure for `t_teacher`
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher` (
  `teacherNo` varchar(30) NOT NULL COMMENT 'teacherNo',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `classObj` varchar(20) NOT NULL COMMENT '所在班级',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `teacherPhoto` varchar(60) NOT NULL COMMENT '教师照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `teacherDesc` varchar(8000) NOT NULL COMMENT '教师介绍',
  PRIMARY KEY  (`teacherNo`),
  KEY `classObj` (`classObj`),
  CONSTRAINT `t_teacher_ibfk_1` FOREIGN KEY (`classObj`) REFERENCES `t_classinfo` (`classNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teacher
-- ----------------------------
INSERT INTO `t_teacher` VALUES ('TH001', '123', 'BJ001', '张晓样', '女', '2019-02-13', 'upload/8681f4f1-fb37-4918-bec1-0a691e5e9a80.jpg', '13808083085', '<p>教学经验丰富</p>');
INSERT INTO `t_teacher` VALUES ('TH002', '123', 'BJ001', '李小芳', '女', '2019-03-06', 'upload/205e23ab-fa07-4638-9977-48752cd17fde.jpg', '13808083085', '<p>讲课生动，工作负责！</p>');
