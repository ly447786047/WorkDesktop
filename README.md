# 西部工作台 本地网页 - 使用说明
## 项目介绍
静态单页面工作台，面向西部计划基层办公，包含实时时钟、城市天气、7日预报、气象预警、每日一言、自动切换背景、磨砂玻璃分区卡片，无需后端，双击HTML直接运行。

## 文件夹结构
西部工作台/
├─ index.html        # 主页面（所有配置、样式、脚本都在此文件）
├─ README.md         # 本说明文档
└─ images/
   ├─ xibuLogo.png    # 西部志愿者logo
   ├─ youthLogo.png   # 共青团团徽
   ├─ weather/       # 天气图标存放目录
   └─ background/    # 本地背景图目录，命名01.jpg、02.jpg...

# 一、核心参数修改位置（script脚本区域）
## 1. 修改天气城市
找到第442行代码：
const CITY_NAME = "泽普";
替换引号内文字即可，全局自动同步天气、预警文字。

## 2. 定时刷新时间（单位：毫秒）
1. 背景图切换，第543行
setInterval(autoChangeBg, 600000);
600000 = 10分钟，60000 = 1分钟

2. 天气刷新，第548行
setInterval(fetchZepuWeather, 60000);
建议改为1800000（30分钟）

3. 每日一言刷新，第549行
setInterval(getHitokoto, 60000);
建议改为3600000（1小时）

## 3. 背景图两种模式切换，第530-537行
function autoChangeBg() 内分两套方案，注释切换：
方案1：在线随机风景图（取消两行注释，注释本地代码）
方案2：本地background文件夹图片（默认启用）

本地图片数量修改，第535行：
Math.floor(Math.random() * 3) + 1
数字3代表图片总数，放99张则改为99。

# 二、页面文字与图片修改
1. 网页标题：<title>西部工作台</title>
2. 顶部宣传标语：class="slogan" 内部文字
3. Logo图片：修改img标签内src路径，onclick内可修改点击跳转网址
4. 六个功能卡片标题、描述：content内部每个card下 card-title、card-desc

# 三、UI样式调整（<style>标签内）
1. 头部渐变：.header 的 background-image 渐变色值
2. 卡片渐变：各card类（card-software/card-workall等）内渐变颜色
3. 磨砂模糊：backdrop-filter: blur(数值px); 数值越大越模糊
4. 圆角大小：border-radius 调整数字，越小越接近直角

# 四、功能清单
1. 右上角实时年月日时分秒时钟
2. 鼠标悬浮天气图标展示7天天气预报
3. 有气象预警自动弹出提示框，支持关闭
4. 自动加载每日励志文案，接口异常显示西部计划备用句子
5. 背景淡入淡出平滑切换

# 五、常见问题
1. 本地双击打开天气加载失败：file协议跨域，使用网页服务器打开
2. 本地背景不显示：检查images/background文件夹与图片命名两位数字
3. 天气图标破损：程序自动兜底default.png，补齐缺失图标即可
