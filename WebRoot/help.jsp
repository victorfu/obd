<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>帮助中心&nbsp;PICC-呼叫中心系统</title>
	<link type="text/css" href="<c:url value='ihelp/ihelp.css?v=4'/>" rel="stylesheet" />
</head>
<body>
	<div id="container">
		<div class="post">
			<h1 class="post-title entry-title">一、如何在IE浏览器中调用未签名ActiveX控件的设置方法？</h1>
			<div class="entry-content">
				<p>ActiveX控件做为IE浏览器专门一种插件程序，在我们使用IE过程中是会经常遇到的。比如当我们使用网银或支付宝等安全要求比较高的网站，都会提示我们需要安装ActiveX控件。</p>
				<p>我们可以通过下面的方法来进行解决：</p>
				<p>1、首先打开Internet选项[IE命令栏-工具]，在“高级”菜单中勾选“允许运行或安装软件，即使签名无效”菜单，然后确认保存。</p>
				<p><img class="aligncenter size-full wp-image-20811" title="允许运行或安装软件，即使签名无效" src="./ihelp/gouxuan-yunxing-ruanjian.png" alt="允许运行或安装软件，即使签名无效" width="491" height="686"/></p>
				<p>2、然后在Internet选项中继续切换到“安全”选项卡，单击下面的“自定义级别”，在弹出的菜单中勾选如下选项：</p>
				<p><img class="aligncenter size-full wp-image-20812" title="自定义设置IE的安全级别" src="./ihelp/zidingy-jibie.png" alt="自定义设置IE的安全级别" width="495" height="617"/></p>
				<p><img class="aligncenter size-full wp-image-20813" title="自定义设置IE的安全级别-2" src="./ihelp/zidingyi-jibie-2.png" alt="自定义设置IE的安全级别-2" width="490" height="612"/></p>
				<p><img class="aligncenter size-full wp-image-20814" title="自定义设置IE的安全级别-2" src="./ihelp/zidingy-jibie-3.png" alt="自定义设置IE的安全级别-3" width="492" height="617"/></p>
				<p>3、同样在“安全”选项卡中，选中“受信任的站点”在单击“站点”按钮，然后添加你要访问的网站的地址：</p>
				<p><img class="aligncenter size-full wp-image-20815" title="设置IE受信任的站点" src="./ihelp/shouxinren-zhandian.png" alt="设置IE受信任的站点" width="486" height="686"/></p>
				<p><img class="aligncenter size-full wp-image-20816" title="添加你要访问的网站的地址" src="./ihelp/tianjia-zhandian.png" alt="添加你要访问的网站的地址" width="478" height="683"/></p>
				<p>然后重新启动浏览器即可。</p>
			</div>
		</div>
	</div><!--container end-->
</body>
</html>
