<%@ language="jscript"%>
<!-- #include file="udm-custom.asp" -->
<%
// UDMv4.6 //
/***************************************************************\
                                                                 
  ULTIMATE DROP DOWN MENU Version 4.6 by UDM
  http://www.udm4.com/                                           
                                                                 
  This script may not be used or distributed without license     
                                                                 
\***************************************************************/

//if speech module exists enforce vertical orientation and turn off repositioning
if(typeof um.speech != 'undefined') { um.orientation[0]='vertical';um.behaviors[2]='no'; }

//restrict positions to positive values
if(/\-/.test(um.orientation[4])) { um.orientation[4]='0'; }
if(/\-/.test(um.orientation[5])) { um.orientation[5]='0'; }

//get writing mode from h align variable, set right alignment if it's there and set negative x value
um.dir='left';
if(um.orientation[1]=='rtl')
{
	um.dir='right';
	um.orientation[1]='right';
	um.orientation[4]='-'+um.orientation[4];
}

//map old values for windowed control management for backward compatibility
if(um.behaviors[3]=='yes') { um.behaviors[3]='default'; }
if(um.behaviors[3]=='no') { um.behaviors[3]='iframe'; }

//check for undefined new variables
if(typeof um.reset == 'undefined') { um.reset=['yes','yes','yes']; }
if(typeof um.hstrip == 'undefined') { um.hstrip=['none','yes']; }
if(typeof um.reset[3] == 'undefined') { um.reset[3]='no'; }

//detect popup alignment
um.p=(um.orientation[0]=='popup');

//convert values for popup aligment
if(um.p)
{
	um.orientation[1]='left';
	um.orientation[2]='top';
	um.orientation[3]='absolute';
	um.orientation[4]='-2000px';
	um.orientation[5]='-2000px';
	um.navbar[0]=0;
	um.navbar[1]=0;
}

//remember images so we can cache them
var m=0;um.imgs=[];

//core javascript string, global udm object
um.js='var um=new Object;';

//create um.e javascript array of menu and menu item data
//testing for number variables and outputting as appropriate
um.ary=['orientation','list','behaviors','navbar','items','menus','menuItems'];
um.js+='um.e=[';
for(var i in um.ary)
{
	for(var j in um[um.ary[i]])
	{
		var data = um[um.ary[i]][j];
		um.js+=/^[+\-]?[0-9]+$/.test(data) ? data+',' : "'"+data+"',";
		//if this value is an image then remember it
		if(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(data)) { um.imgs[m++]=data; }
	}
}
um.js+=',];';

//create um.v javascript array of adhoc menu data - has an extra trailing item for consistency with PHP version
um.js+='um.v=[];';
for(i in um.menuClasses)
{
	um.js+="um.v['" + i + "']=[";
	for(j in um.menuClasses[i])
	{
		var data = um.menuClasses[i][j];
		um.js+="'" + data + "',";
		//if this value is an image then remember it
		if(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(data)) { um.imgs[m++]=data; }
	}
	um.js+=',];';
}

//create um.w javascript array of adhoc menu item data - has an extra trailing item for consistency with PHP version
um.js+='um.w=[];';
for(i in um.itemClasses)
{
	um.js+="um.w['" + i + "']=[";
	for(j in um.itemClasses[i])
	{
		var data = um.itemClasses[i][j];
		um.js+="'" + data + "',";
		//if this value is an image then remember it
		if(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(data)) { um.imgs[m++]=data; }
	}
	um.js+=',];';
}

//count ad-hoc classes
um.mcLen=0;for(i in um.menuClasses){um.mcLen++;}
um.icLen=0;for(i in um.itemClasses){um.icLen++;}
um.js+='um.vl='+(um.mcLen)+';';
um.js+='um.wl='+(um.icLen)+';';

//compile dynamic menus arrays, if there are any
um.js+='um.menuCode=[];';
for(i in um.menuCode)
{
	um.js+='um.menuCode[\''+i+'\']=\''+um.menuCode[i]+'\';';
}

//baseSRC
um.js+='um.baseSRC=\''+um.baseSRC+'\';';

//initialization trigger element, if a value is defined
if(typeof um.trigger != 'undefined') { um.js+='um.trigger=\''+um.trigger+'\';'; }

//declare i and j to avoid strict errors
um.js+='var i,j;';

//if there are any stored images
if(um.imgs.length>0)
{
	//open javascript array
	um.js+='um.imn=[';

	//add each to array
	for(i in um.imgs)
	{
		um.js+="'" + um.imgs[i] + "',";
	}

	//close javascript array and write caching loop
	um.js+=',];um.im=[];i=0;do{um.im[i]=new Image;um.im[i].src=um.baseSRC+um.imn[i];i++;}while(i<'+um.imgs.length+');';
}

//continue compiling core javascript
um.js+='var umTree=null;um.gp=function(umRI){return umRI?um.vn(umRI.nodeName).toLowerCase()==\'li\'?umRI:this.gp(umRI.parentNode):null;};um.ready=0;um.pi=function(n){n=parseInt(n,10);return (isNaN(n)?0:n);};um.un=\'undefined\';um.m=document;um.gd=function(umD){return um.m.getElementById(umD);};um.xd=function(umD){umD.style.display=\'block\';};um.xn=function(umD){umD.style.display=\'none\';};um.xv=function(umD){umD.style.visibility=\'visible\';};um.xh=function(umD){umD.style.visibility=\'hidden\';};um.ne=function(umD){return umD.parentNode.className==\'udm\';};um.u=navigator.userAgent.toLowerCase();um.d=(typeof um.m.getElementById!=um.un&&(typeof um.m.createElement!=um.un||typeof um.m.createElementNS!=um.un)&&typeof navigator.IBM_HPR==um.un);um.o5=/opera[\\/ ][56]/.test(um.u);um.k=(navigator.vendor==\'KDE\');if(um.o5){um.d=0;};um.b=(um.d||um.o5);um.o7=(um.d&&typeof window.opera!=um.un);um.o75=0;um.o73=0;um.o71=0;um.o9=0;if(um.o7){um.ova=um.pi(um.u.split(/opera[\\/ ]/)[1].match(/[17-9]/)[0]);um.ovi=um.pi(um.u.split(/opera[\\/ ][17-9]\\./)[1].match(/^[0-9]/)[0]);um.o9=(um.ova>=9||um.ova==1);um.o75=(um.ova>=8||um.ovi>=5);um.o73=(um.ova>=8||um.ovi>=3);um.o71=(um.ova==7&&um.ovi<=1);}um.s=(navigator.vendor==\'Apple Computer, Inc.\');um.s2=(um.s&&typeof XMLHttpRequest!=um.un);um.s3=(um.s&&/applewebkit\\/[5-9]/.test(um.u));um.ie9=/msie 9\\.0/.test(um.u);um.ggc=(navigator.vendor==\'Google Inc.\');um.k4=(um.k&&/khtml\\/[4-9]/.test(um.u));if(um.ggc||um.k4){um.s=1;um.s2=1;um.s3=1;}um.wie=(um.d&&typeof um.m.all!=um.un&&typeof window.opera==um.un&&!um.k);um.mie=(um.wie&&um.u.indexOf(\'mac\')>0);um.mx=0;um.omie=0;if(um.mie){um.wie=0;um.omie=(/msie 5\\.[0-1]/.test(um.u));}um.ie=(um.wie||um.mie);um.wie5=(um.wie&&um.u.indexOf(\'msie 5\')>0);um.wie55=(um.wie&&um.u.indexOf(\'msie 5.5\')>0);um.wie50=(um.wie5&&!um.wie55);um.wie6=(um.wie&&um.u.indexOf(\'msie 6\')>0);um.wie7=(um.wie&&typeof XMLHttpRequest!=um.un);um.wie8=(um.wie&&um.u.indexOf(\'msie 8\')>0);if(um.wie6){um.wie55=1;}um.q=(um.wie5||um.mie||((um.wie6||um.wie7||um.o7)&&um.m.compatMode!=\'CSS1Compat\'));um.og=0;um.dg=0;if(navigator.product==\'Gecko\'&&!um.s){um.sub=um.pi(navigator.productSub);um.og=(um.sub<20030312);um.dg=(um.sub<20030208);}';

//create other core javascript arrays

//hstrip
um.ary=[];
for(i in um.hstrip)
{
	um.ary[i]='"' + um.hstrip[i] + '",';
}
um.js+='um.hstrip=['+um.ary.join('')+'];';

//reset
um.ary=[];
for(i in um.reset)
{
	um.ary[i]='"' + um.reset[i] + '",';
}
um.js+='um.reset=['+um.ary.join('')+'];';

//keys - this leaves a trailing comma in the array
um.kb=(typeof um.keys != 'undefined');
if(um.kb)
{
	um.js+='um.keys=[';
	for(i in um.keys)
	{
		//convert key handling codes to numbers
		um.js+=/^[0-9]+$/.test(um.keys[i]) ? um.keys[i]+',' : '"'+um.keys[i]+'",'
	}
	um.js+=',];';
}

//speech
um.sp=(um.kb&&(typeof um.speech != 'undefined'));
if(um.sp)
{
	um.ary=[];
	for(i in um.speech)
	{
		um.ary[i]='"' + um.speech[i] + '",';
	}
	um.js+='um.speech=['+um.ary.join(',')+'];';
}

//carry on compiling core javascript
um.js+='um.kb=('+(um.kb)+'&&!(um.mie||um.o7||(um.k&&!um.k4)||(um.s&&!um.s2)));um.skb=(um.kb||('+(um.kb)+'&&((um.o7&&!um.o71)||(um.k&&!um.k4))));um.sp=('+(um.sp)+'&&um.wie);if(um.wie50&&um.rp){um.e[12]=\'no\';}um.rp='+(um.orientation[3]=='relative')+';um.p='+(um.p)+';um.hz=((um.wie50&&'+(um.behaviors[3]=='default')+')||(um.wie&&'+(um.behaviors[3]=='hide')+'));um.a='+(um.orientation[1]=='right')+';um.h='+(um.orientation[0]=='horizontal')+';um.rg=(um.h&&'+(um.list[0]=='rigid')+'&&'+(um.dir!='right')+');um.ep=0;if('+(um.orientation[0]=='expanding')+'){um.ep=1;um.e[0]=\'vertical\';}um.fe=false;if(um.e[3]==\'allfixed\'){um.e[3]=\'fixed\';if(um.wie5||um.wie6){um.fe=true;}}um.f=(um.e[3]==\'fixed\'&&!(um.wie5||um.wie6||um.og));um.nc='+((um.items[0]==0&&um.items[2]=='collapse'))+';um.mc='+(um.menuItems[0]==0&&um.menuItems[2]=='collapse')+';um.nm=((um.og&&um.rp)||(um.omie&&um.h)||((um.dg||um.wie50)&&'+(um.dir=='right')+'));um.nr=(um.nm||um.mie);um.ns=(um.dg||um.o71||(um.wie50&&um.rp)||(um.o7&&um.f)||um.mie);um.cns=(typeof um.m.createElementNS!=um.un);um.ss=(um.cns&&typeof um.m.styleSheets!=um.un&&!(um.s||um.k));um.ni='+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.items[28]))+';um.mi='+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menuItems[28]))+';um.rn=0;um.rv=[];um.addReceiver=function(umFC,umEC){um.rv[um.rn++]=[umFC,umEC];};um.createElement=function(umE,umA){um.el=(um.cns)?um.m.createElementNS(\'http://www.w3.org/1999/xhtml\',umE):um.m.createElement(umE);if(typeof umA!=um.un){for(var i in umA){switch(i){case \'text\' :um.el.appendChild(um.m.createTextNode(umA[i]));break;case \'class\' : um.el.className=umA[i];break;default : um.el.setAttribute(i,\'\');um.el[i]=umA[i];break;}}}return um.el;};';

//whether to include iframe code and select-hiding code
um.ifr=(um.behaviors[3]=='default'||um.behaviors[3]=='iframe');
um.hz=(um.behaviors[3]=='default'||um.behaviors[3]=='hide');

//whether rigid width is in use
um.rw=(um.orientation[0]=='horizontal'&&um.list[0]=='rigid');

//whether dropshadows are in use
um.ds=(um.menus[9]!='none');

//whether arrows are in use at all
um.az=(um.items[28]!='none'||um.menuItems[28]!='none');

//remove trailing commas from output arrays
um.js = um.js.replace(/\,\]\;/g,'];');



//*************************************************************//
//*************************************************************//
//begin compiling dom script

var j=0;
um.jd=[];

um.jd[j++]="um.ap=function(c,v){var r=um.rv.length;if(r>0){for(var i=0;i<r;i++){if(um.rv[i][1]==''){um.rv[i][0](v,c);}else if(c==um.rv[i][1]){um.rv[i][0](v);}}}};if(um.wie){um.eva=[];um.ex=['onmouseover','onmouseout','onmousedown','onmouseup','onclick','onmousewheel','onfilterchange','onkeydown','onfocus','onactivate','onscroll','over','out'];um.gg=um.ex.length;window.attachEvent('onunload',function(){um.lil=umTree.getElementsByTagName('li');um.lin=um.lil.length;i=0;do{um.gc(um.lil[i]).detachEvent((um.wie55)?'onactivate':'onfocus',um.eva[i]);i++;}while(i<um.lin);um.da=document.all.length;i=0;do{um.t=document.all[i];j=0;do{um.t[um.ex[j]]=null;j++;}while(j<um.gg);i++;}while(i<um.da);});}";
um.jd[j++]="if(!um.k&&typeof window.addEventListener!=um.un){window.addEventListener('load',umIni,0);}else if(um.o7){um.m.addEventListener('load',umIni,0);}else if(um.wie){window.attachEvent('onload',umIni);}else{if(typeof window.onload=='function'){um.on=onload;window.onload=function(){um.on();umIni();};}else{window.onload=umIni;}}";
um.jd[j++]="function umIni(g){if(typeof g==um.un){g=1;}if(typeof um.ini!=um.un||(um.k&&typeof window.sidebar==um.un)){return;}if(um.drt){clearTimeout(um.drt);}um.ini=1;um.ha=0;umTree=(um.b)?um.gd('udm'):null;if(umTree&&um.d){if(g){um.ap('000',umTree);}";
um.jd[j++]="for(i in um.menuCode){var l=um.gd(i);if(l){if(um.mie){um.menuCode[i]=um.menuCode[i].replace(/<\\/(li|ul)>/ig,'</\\$1>\\\\n');}l.innerHTML+=um.menuCode[i];if(um.mie){um.dm=um.gm(l);um.xn(um.dm);um.xh(um.dm);}}}";
um.jd[j++]="um.bub=0;um.wsr=0;um.rtl=um.m.getElementsByTagName('html')[0].getAttribute('dir')=='rtl';um.kdf=0;if(um.o7){um.m.addEventListener('keydown',function(e){if(e.keyCode==16){um.kdf=1;}},0);um.m.addEventListener('keyup',function(e){if(e.keyCode==16){um.kdf=0;}},0);}um.skb=(um.skb&&typeof umKM=='function');um.kb=(um.skb&&um.kb);";
if(um.kb) 
{
	um.jd[j++]="if(um.skb){um.kbm=new umKM;if(g){um.ap('001',um.kbm);}}";
}
um.jd[j++]="um.sp=(um.sp&&typeof udmSpeechModule=='function');";
if(um.sp) 
{
	um.jd[j++]="if(um.sp){um.sapi=new udmSpeechModule;if(g){um.ap('002',um.sapi);}}";
}
um.jd[j++]="um.n=new umNav(umTree,g);if(g){um.ap('009',um.n);}if(um.fe){um.tr.style.left=(um.getScrollAmount(1))+'px';um.tr.style.top=(um.getScrollAmount())+'px';window.attachEvent('onscroll',function(){um.tr.style.left=(um.getScrollAmount(1))+'px';um.tr.style.top=(um.getScrollAmount())+'px';});}if(um.s){umTree.style.KhtmlOpacity='1';}um.s1=(typeof umTree.style.KhtmlOpacity!=um.un);um.ready=1;if(g){um.ap('010',um.tr);}}};";
um.jd[j++]="function umNav(umTree,g){um.n=this;um.tr=umTree;if(um.wie){um.tr.style.color='black';}um.jv='javascript:void(0)';";
if(um.rw) 
{
	um.jd[j++]="if(um.rg){um.rw=0;}";
}
um.jd[j++]="var l=umTree.getElementsByTagName('li');if(l.length==0){return;}var i=0;do{";
if(um.mcLen>0) 
{
	um.jd[j++]="if(um.wl>0){var b=um.es(l[i].className);if(b==''&&!um.ne(l[i])){var a=um.gp(l[i].parentNode);b=um.es(a.className);if(b!=''&&!um.ne(a)){l[i].className=b;}}}";
}
um.jd[j++]="this.it(l[i]);if(g){um.ap('008',l[i]);}i++;}while(i<l.length);";
if(um.icLen>0) 
{
	um.jd[j++]="if(um.vl>0){um.mo=um.gu(um.tr);um.en=um.mo.length;if(um.en>0){i=0;do{b=um.es(um.mo[i].className);if(b==''){a=um.mo[i].parentNode.parentNode;b=um.es(a.className);if(b!=''&&b!='udm'){um.mo[i].className=b;}}i++;}while(i<um.en);}}";
}
um.jd[j++]="um.mf=0;um.lf=0;um.ety=typeof document.addEventListener!=um.un?'addEventListener':typeof document.attachEvent!=um.un?'attachEvent':'';um.epx=um.ety=='attachEvent'?'on':'';if(um.ety!=''){um.m[um.ety](um.epx+'mousedown',function(e){if(!e){e=window.event;}um.mf=1;";
if(um.kb) 
{
	um.jd[j++]="if(um.skb){um.ha=0;}";
}
um.jd[j++]="clearInterval(um.oc);um.or=0;if(um.reset[0]!='no'){";
if(um.hz) 
{
	um.jd[j++]="if(um.hz){if(!um.tr.contains(event.srcElement)){um.n.ts('visible');}}";
}
um.jd[j++]="um.cm(e);}},0);um.m[um.ety](um.epx+'mouseup',function(){um.mf=0;},0);}";
if(um.kb) 
{
	um.jd[j++]="if(um.kb){um.kbm.bdh();}";
}

if(um.kb) 
{
	um.jd[j++]="if(um.skb&&um.o7){um.kbm.bfh();}";
}

if(um.rw) 
{
	um.jd[j++]="if(um.rg){this.aw();}";
}
um.jd[j++]="um.cc=null,um.cr=0,um.oc=null,um.or=0;if(!um.ie){um.tr.contains=function(n){return (n==null)?false:(n==this)?true:this.contains(n.parentNode);};}um.lw=um.getWindowDimensions();um.lh=um.gc(um.tr).offsetHeight;if(um.og&&um.hstrip[0]!='none'){um.tr.style.height=(um.hstrip[1]=='yes')?(um.lh+um.e[17])+'px':um.lh+'px';}var p=um.m.getElementById('udm-purecss');if(p){p.disabled=1;}um.vs=setInterval('um.n.ws()',55);};";
um.jd[j++]="umNav.prototype.it=function(l){if(um.wie){var f=(um.wie55)?'onactivate':'onfocus';um.gc(l).attachEvent(f,um.eva[um.eva.length]=function(){";
if(um.kb) 
{
	um.jd[j++]="if(um.kb&&!um.lf){um.bub=0;l.over(1,um.gc(l));}";
}
um.jd[j++]="});}var a=um.es(l.className);var h=(a.indexOf('onclick')!=-1)?'onclick':'onmouseover';var s=um.ne(l);var umM=(typeof um.gu(l)[0]!=um.un)?um.gu(l)[0]:null;if(typeof um.fl==um.un){um.fl=um.gc(l);}";
if(um.az) 
{
	um.jd[j++]="if(umM&&!um.nr){if(((s&&um.e[45]!='none')||(!s&&um.e[89]!='none'))&&um.n.cck()){if(s){var r=um.e[45];var x=(um.ni)?um.e[48]:'��';}else{r=um.e[89];x=(um.mi)?um.e[92]:'��';if(typeof um.w[a]!=um.un){r=um.w[a][23];x=(um.mi)?um.w[a][25]:'��';}}if(x=='��'){var t={'class':'udmA','text':r};var u=u=um.gc(l).appendChild(um.createElement('span',t));}else{if(um.wie){um.gc(l).insertAdjacentHTML('beforeEnd','<img class=\\'udmA\\' alt=\\''+x+'\\' title=\\'\\' />');u=um.gc(l).lastChild;u.src=um.baseSRC+r;}else if(um.s||um.k){t={'class':'udmA'};u=um.gc(l).appendChild(um.createElement('span',t));t={'src':um.baseSRC+r,'alt':x,'title':''};u.appendChild(um.createElement('img',t));}else{t={'class':'udmA','alt':x,'title':''};u=um.gc(l).appendChild(um.createElement('img',t));u.src=um.baseSRC+r;}}if(h=='onclick'){u.onmousedown=function(){return false;}};u.onmouseover=function(e){var t=um.gp(this.parentNode).parentNode.childNodes;var n=t.length;for(var i=0;i<n;i++){if(t[i].nodeName!='#text'&&um.gu(t[i]).length>0){if(um.gu(t[i])[0].style.visibility=='visible'){(!e)?event.cancelBubble=1:e.stopPropagation();this.parentNode.style.zIndex=um.e[6]+=2;return false;break;}}clearInterval(um.oc);um.or=0;}return true;};u.onmouseout=function(){clearInterval(um.oc);um.or=0;};um.xd(u);if(s){this.wp(u,l,um.e[26],um.e[18],1);}}}";
}
um.jd[j++]="if(um.mie){var v=l.getElementsByTagName('span')[0];if(typeof v!=um.un){v.onclick=function(){this.parentNode.click();};}}";
if(um.rw) 
{
	um.jd[j++]="if(um.rg&&um.ne(l)){um.n.dw(l);}";
}
um.jd[j++]="if(um.mie){t=um.gc(l);if(t.className&&/nohref/.test(t.className)){um.gc(l).href=um.jv;}}";
if(um.kb) 
{
	um.jd[j++]="if(um.skb){um.kbm.bth(l);}";
}
um.jd[j++]="l.onmousedown=function(e){um.lf=1;um.ap('030',um.gc(this));(!e)?event.cancelBubble=1:e.stopPropagation();};l.onmouseup=function(e){um.ap('035',um.gc(this));(!e)?event.cancelBubble=1:e.stopPropagation();};if(h!='onclick'){l.onclick=function(e){if(!um.bub){um.qc(um.gc(this).href);}um.bub=1;};}else if(!um.mie){l.onmouseover=function(){um.n.lr(um.gc(l),1);um.bub=0;};}if(!(um.mie&&h=='onclick')){l[h]=function(e){var v=(um.ie)?window.event.srcElement:e.target;if(v.nodeName=='#text'&&e.type=='click'){v=v.parentNode;}if(!um.gp(v)){return false;}var b=um.es(um.gp(v).className);var c=(um.lf&&!um.nm&&b.indexOf('onclick')!=-1);if(c){um.rt=um.e[10];um.e[10]=1;}if(b.indexOf('onclick')==-1){um.bub=0;}else if(!um.lf){if(!um.bub){um.qc(v.href);}um.bub=1;}this.over(0,v);if(c){um.e[10]=um.rt;um.lf=0;if(v.nodeName!='#text'&&um.gu(um.gp(v)).length>0){if(typeof v.blur!=um.un){v.blur();}if(um.gu(um.gp(v))[0].style.display=='block'){um.n.cd(this.parentNode);(!e)?event.cancelBubble=1:e.stopPropagation();return false;}(!e)?event.cancelBubble=1:e.stopPropagation();b=um.es(um.gp(v).className);return (b.indexOf('(true)')!=-1);}else{um.qc(v.href);um.bub=1;}}if(!e){e=window.event;}return (e.type=='click'||um.o7);};l.onmouseout=function(e){this.out(e);};}l.over=function(f,t){if(um.bub||(!f&&um.ha&&um.kdf)){return false;}var c=um.n.cck();if(!c||um.mf){um.mf=0;if(!um.ec){if(um.gm(this)){this.removeChild(um.gm(this));}}return false;}";
if(um.kb) 
{
	um.jd[j++]="if(f){if(!um.wsr&&!um.ie){um.kbm.cws(um.tr);um.wsr=1;}";
if(um.sp) 
{
	um.jd[j++]="if(um.sp){um.sapi.speechBuffer(um.gc(l));event.cancelBubble=1;}";
}
um.jd[j++]="um.ha=1;if(um.ie&&event.altKey){um.n.ck(um.gp(t).parentNode);}um.ap('040',t);}";
}
um.jd[j++]="if(!f){var n=um.vn(t.nodeName).toLowerCase();if(/(li|ul)/.test(n)){return false;}";
if(um.kb) 
{
	um.jd[j++]="if(um.skb){if(!um.lf){um.e[10]=um.mt[0];um.e[11]=um.mt[1];}um.nf=um.gc(this);if(um.ha){um.n.ck(l.parentNode);um.n.cd(um.gp(t).parentNode);um.nf.focus();um.nf.blur();um.ha=0;}}";
}
um.jd[j++]="um.ap('020',t);}clearInterval(um.cc);um.cr=0;um.n.lr(um.gc(l),1);um.n.pr(umM,l,f,t);return l;};l.out=function(e){if(um.o7&&um.ha&&um.kdf){return;}if(um.lf){um.gc(this).blur();}um.lf=0;if(!e){e=window.event;e.relatedTarget=e.toElement;}if(!l.contains(e.relatedTarget)){if(!um.tr.contains(e.relatedTarget)){clearInterval(um.cc);um.cr=0;}um.n.cp(umM,l);um.ap('025',um.gc(this));}};if(!um.ie){l.contains=function(n){return (n==null)?false:(n==this)?true:this.contains(n.parentNode);};}};";
um.jd[j++]="umNav.prototype.cck=function(){if(typeof document.defaultView!=um.un&&typeof document.defaultView.getComputedStyle!=um.un){um.sa=document.defaultView.getComputedStyle(um.fl,'').getPropertyValue('display');}else if(typeof um.fl.currentStyle!=um.un&&um.fl.currentStyle){um.sa=um.fl.currentStyle.display;}um.mv=1;um.ec=(!um.wie||um.tr.currentStyle.color=='black');return ((um.sa!='inline'||typeof um.sa==um.un)&&um.ec);};";
um.jd[j++]="umNav.prototype.lr=function(l,v){if(l&&typeof l.style!=um.un){um.cl=um.es(l.className);um.ii=um.ne(um.gp(l));if(v){l.style.zIndex=um.e[6]+=2;(um.cl=='')?l.className='udmR':l.className+=(l.className.indexOf('udmR')==-1)?' udmR':'';}else{if(um.cl.indexOf('udmR')!=-1){l.className=um.cl.replace(/([ ]?udmR)/g,'');}}";
if(um.az) 
{
	um.jd[j++]="um.n.wv(l,um.ii);";
}
um.jd[j++]="}};";
um.jd[j++]="umNav.prototype.pr=function(m,l,f,r){";
if(um.kb) 
{
	um.jd[j++]="if(um.skb&&f){um.kbm.cu(m,l,r);}";
}
um.jd[j++]="if(!um.nm&&m&&m.style.visibility!='visible'){if(um.wie&&!um.wie7){if(um.e[61]>0){um.gc(m).style.marginTop=um.e[61]+'px';}else if(um.e[63]=='collapse'){m.firstChild.style.marginTop=0+'px';}}";
if(um.kb) 
{
	um.jd[j++]="if(um.skb&&f){um.n.ou(m);}";
}
um.jd[j++]="if(!(um.skb&&f)){um.n.tu(m,null);}}if(m==null){um.n.tu(null,l);}};";
um.jd[j++]="umNav.prototype.tu=function(m,l){if(um.cr){clearInterval(um.oc);um.oj=m;um.ij=l;um.or=1;um.oc=setInterval('um.n.tu(um.oj,um.ij)',um.e[10]);}else if(um.or){clearInterval(um.oc);um.or=0;this.ou(m,l);}else{um.ap('061',m);um.oj=m;um.ij=l;um.or=1;um.oc=setInterval('um.n.tu(um.oj,um.ij)',um.e[10]);}};";
um.jd[j++]="umNav.prototype.ou=function(m,l){if(m==null){this.cd(l.parentNode);return false;}this.cd(um.gp(m).parentNode);if(typeof m.m==um.un){m.m=um.gu(m);m.l=m.m.length;if(m.l>0){for(var i=0;i<m.l;i++){um.xh(m.m[i]);um.xn(m.m[i]);}}}if(um.ep){m.style.position='static';if(um.wie8){m.style.styleFloat = 'left';}}";
if(um.hz) 
{
	um.jd[j++]="if(um.hz){this.ts('hidden');}";
}
um.jd[j++]="um.xd(m);";
if(um.az) 
{
	um.jd[j++]="if(!um.nr&&um.e[89]!='none'){var c=m.childNodes.length;for(i=0;i<c;i++){var t=m.childNodes.item(i);var n=um.vn(t.nodeName).toLowerCase();if(n=='li'){var a=um.n.ga(um.gc(t));if(a){this.wp(a,t,um.e[70],um.e[62],0);}}}}";
}
um.jd[j++]="um.ap('058',m);this.pu(m);";
if(um.behaviors[2]=='yes') 
{
	um.jd[j++]="if(um.e[12]=='yes'){this.ru(m);}";
}
um.jd[j++]="um.mp={x:(m.offsetLeft),y:(m.offsetTop)};um.sh=null;";
if(um.ds) 
{
	um.jd[j++]="if(!um.ns&&um.e[58]!='none'){this.hl(m);}";
}

if(um.ifr) 
{
	um.jd[j++]="if(um.wie55&&(um.e[13]=='default'||um.e[13]=='iframe')){this.il(m);}";
}
um.jd[j++]="um.hf=(um.wie55&&typeof m.filters!='unknown'&&m.filters&&m.filters.length>0);if(um.hf){m.filters[0].Apply();}if(um.wie&&um.h){var t=m.parentNode;if(um.ne(t)){t=t.style;t.position='absolute';t.zIndex=um.e[6]+=2;t.position='relative';}}um.xv(m);if(um.hf){um.ap('065',m);m.filters[0].Play();";
if(um.ds) 
{
	um.jd[j++]="if(um.sh){m.onfilterchange=function(){um.xd(um.sh);um.ap('066',m);};}";
}
um.jd[j++]="}";
if(um.ds) 
{
	um.jd[j++]="else if(um.sh){um.xd(um.sh);}";
}
um.jd[j++]="if(um.wie50){um.xn(m);um.xd(m);}if(um.ep&&um.s&&m.offsetLeft<-1000){var fs=um.pi(document.defaultView.getComputedStyle(m,'').getPropertyValue('font-size'));m.style.fontSize=(fs-1)+'px';setTimeout(function(){m.style.fontSize=fs+'px';},0);}um.ap('060',m);return m;};";
um.jd[j++]="umNav.prototype.cd=function(m){var s=um.mie?um.gt(m,'ul'):um.gu(m);var n=s.length;for(var i=0;i<n;i++){this.clm(s[i]);}};";
um.jd[j++]="umNav.prototype.ck=function(m){var l=um.mie?um.gt(m,'a'):m.getElementsByTagName('a');var n=l.length;for(var i=0;i<n;i++){this.lr(l[i],0);}};";
um.jd[j++]="umNav.prototype.cp=function(m,l){clearTimeout(um.oc);um.or=0;this.lr(um.gc(l),0);if(!um.nm&&m){this.cot(m);}};";
um.jd[j++]="umNav.prototype.cot=function(m){if(um.cr){clearInterval(um.cc);um.cr=0;this.clm(m);}else if(um.e[11]!='never'){um.ap('071',m);um.cb=m;um.cr=1;um.cc=setInterval('um.n.cot(um.cb)',um.e[11]);}};";
um.jd[j++]="umNav.prototype.clm=function(m){if(m.style.visibility=='visible'){if(typeof um.sim==um.un||!um.sim||um.ha){um.xh(m);um.xn(m);";
if(um.hz) 
{
	um.jd[j++]="if(um.hz){if(um.ne(m.parentNode)){this.ts('visible');}}";
}
um.jd[j++]="um.t=['udmC','udmS'];for(var i=0;i<2;i++){var b=m.parentNode.lastChild;if(b&&b.className&&b.className.indexOf(um.t[i])!=-1){m.parentNode.removeChild(b);}}}um.ap('070',m);}};";
if(um.az) 
{
	um.jd[j++]="umNav.prototype.ga=function(l){var a=null;var t=['span','img'];for(var k=0;k<2;k++){var s=l.getElementsByTagName(t[k]);var n=s.length;for(var j=0;j<n;j++){var b=um.es(s[j].className);if(b=='udmA'){a=s[j];break;}}}return a;};";
um.jd[j++]="umNav.prototype.wp=function(a,l,p,b,n){a.fn=arguments;if(a.offsetHeight>0&&!um.o7){this.wpo(a.fn[0],a.fn[1],a.fn[2],a.fn[3],a.fn[4]);}else{a.c=0;a.ti=window.setInterval(function(){if(a.offsetHeight>0){clearInterval(a.ti);um.n.wpo(a.fn[0],a.fn[1],a.fn[2],a.fn[3],a.fn[4]);}else{a.c++;if(a.c>=100){clearInterval(a.ti);}}},55);}return true;};";
um.jd[j++]="umNav.prototype.wpo=function(a,l,p,b,n){var s=um.gc(l);var t=[a.offsetWidth,a.offsetHeight];a.style.marginTop=um.pi(((s.offsetHeight-t[1])/2)-b)+'px';s.style[(um.a||um.rtl)?'paddingLeft':'paddingRight']=((p*2)+t[0])+'px';if(um.wie&&um.rtl){a.style.marginRight=((n)?(0-um.e[26]):(0-um.e[70]))+'px';}if((((um.wie50||um.wie7)&&um.a)||(um.wie55&&um.rtl))&&n&&um.h){a.style.top=(b)+'px';a.style.left=(b)+'px';}if((n&&um.ni)||(!n&&um.mi)){var c=((n)?um.e[47]:um.e[91]);if((t[0]-c)<0){c=t[0];}a.style.clip=(um.a||um.rtl)?'rect(0,'+c+'px,'+t[1]+'px,0)':'rect(0,'+t[0]+'px,'+t[1]+'px,'+(t[0]-c)+'px)';}um.xv(a);return true;};";
um.jd[j++]="umNav.prototype.wv=function(l,n){if(um.nr){return false;}var a=this.ga(l);if(a){var c=um.es(l.className);var r=(c.indexOf('udmR')==-1);if(c.indexOf('udmY')!=-1){r=0;}var p=um.es(um.gp(l).className);var t=(um.s||um.k)?a.firstChild:a;t.src=um.baseSRC+((n)?(r)?um.e[45]:um.e[46]:(typeof um.w[p]!=um.un)?(r)?um.w[p][23]:um.w[p][24]:(r)?um.e[89]:um.e[90]);}return a;};";
}
um.jd[j++]="umNav.prototype.pu=function(m){m.style.height='auto';m.style.overflow='visible';var s=(um.ne(m.parentNode));var l=m.parentNode;var p={tw:l.offsetWidth,th:l.offsetHeight,mw:m.offsetWidth,pw:(s)?um.gc(l).offsetWidth:l.parentNode.offsetWidth};var x=(um.p)?2000:0;var y=(um.p)?2000:0;if(!((um.h||um.p)&&s)){x=(s)?(um.a?(0-p.mw):p.pw):((um.a?(0-p.mw):p.pw)-um.e[51]-um.e[55]);y=(0-p.th);}else if(um.h&&s&&um.a){x=(0-p.mw+p.tw);}x+=(s)?(um.a?(0-um.e[14]):um.e[14]):(um.a?(0-um.e[49]):um.e[49]);y+=(s)?(um.e[2]=='bottom')?(0-um.e[15]):um.e[15]:um.e[50];if(s){if(um.h){if(um.e[2]=='bottom'){y-=(m.offsetHeight+p.th);}if(um.s){if(um.nc&&!um.a){x-=um.e[18];}if(!um.s1&&um.rp){x+=um.getRealPosition(um.tr,'x');y+=um.getRealPosition(um.tr,'y');}}if(um.mie){x-=um.gc(l).offsetWidth;if(um.nc&&um.a){x+=um.e[18];}y+=p.th;}if(um.ie&&um.hstrip[1]=='yes'){y-=um.e[17];}}else if(um.ie&&um.nc){y-=um.e[18];}}m.style.marginLeft=x+'px';m.style.marginTop=y+'px';if(!um.p||!s){m.style.left='auto';m.style.top='auto';if(um.s1||um.k){m.style.top=(p.th)+'px';}}if(um.wie50){um.xn(m);um.xd(m);}};";
if(um.behaviors[2]=='yes') 
{
	um.jd[j++]="umNav.prototype.ru=function(m){var c=um.es(m.className);if(/nomove/.test(c)){return false;}var w=um.getWindowDimensions();var p={x:um.getRealPosition(m,'x'),y:um.getRealPosition(m,'y'),w:m.offsetWidth,h:m.offsetHeight,pw:m.parentNode.parentNode.offsetWidth,m:32,nx:-1,ny:-1,sc:um.getScrollAmount(),scx:um.getScrollAmount(1)};if(um.wie50&&um.rtl){p.x-=um.m.body.clientWidth;}if(typeof um.scr!=um.un){p.h=scr.gmh(m);}var s=(um.ne(m.parentNode));if(um.s){p.x-=um.m.body.offsetLeft;p.y-=um.m.body.offsetTop;}else if(um.mie){var t=um.e[55]+um.e[51];p.x-=t;p.y-=t;}else{t=m;while(!um.ne(t.parentNode)){p.x+=um.e[51];p.y+=um.e[51];t=t.parentNode.parentNode;}}if(!um.ie&&um.e[3]=='fixed'&&s){p.x+=p.scx;p.y+=p.sc;}t=[(p.x+p.w),(w.x-p.m+p.scx)];if(t[0]>t[1]){if(s){p.nx=(((um.p)?p.x:0)-(t[0]-t[1]));}else{p.nx=(((um.p)?(0-p.w-p.pw+um.e[55]-um.e[49]):(0-p.w-um.e[55]-um.e[51]))-um.e[49]);}}if(p.x<0){if(!s){p.nx=(0-um.e[55]-um.e[51]+p.pw+um.e[49]);}}um.yd=(p.y+p.h)-(w.y-p.m+p.sc);if(um.f&&!s){um.yd+=p.sc;}if(um.yd>0){t=m.parentNode;um.y=um.getRealPosition(t,'y');while(!um.ne(t)){um.y+=um.e[51];t=t.parentNode.parentNode;}p.ny=(0-um.y-(p.m*2)+w.y+p.sc-p.h);if(um.f){p.ny-=p.sc;}}if(p.y<0){p.ny=(0-(0-p.y));}if(p.nx!=-1){if(um.p){m.style.left=p.nx+'px';}else{m.style.marginLeft=p.nx+'px';}um.ap('110',m);}if(p.ny!=-1){if(um.p&&um.ne(m.parentNode)){m.style.marginTop=(2000-um.yd)+'px';}else{m.style.marginTop=p.ny+'px';}um.ap('120',m);}t=m;var y=(um.wie50&&!um.p)?((um.pi(m.style.marginTop)+m.parentNode.offsetHeight+um.getRealPosition(m.parentNode,'y'))-p.sc):(um.getRealPosition(t,'y')-p.sc);while(!um.ne(t.parentNode)){y+=um.e[51];t=t.parentNode.parentNode;}if(um.f){y+=p.sc;}if(y<0){p.ny=um.pi(m.style.marginTop);if(isNaN(p.ny)){p.ny=0;}m.style.marginTop=(p.ny-y)+'px';}t=m;var x=um.getRealPosition(t,'x')-p.scx;while(!um.ne(t.parentNode)){x+=um.e[51];t=t.parentNode.parentNode;}if(x<0){m.style.marginLeft=(um.p&&um.ne(m.parentNode))?'2000px':(p.scx>0?0-x:0)+'px';m.style.left='0';}return true;};";
}
if(um.ds) 
{
	um.jd[j++]="umNav.prototype.hl=function(m){var d={'class':'udmS'};um.sh=m.parentNode.appendChild(um.createElement('span',d));var c=um.es(m.className);if(c!=''){if(typeof um.v[c]!=um.un){if(um.sh.className.indexOf(c)==-1){um.sh.className+=' '+c;}}}um.sh.style.width=m.offsetWidth+'px';var h=m.offsetHeight;if(typeof um.scr!=um.un){h=scr.gmh(m);}um.sh.style.height=h+'px';var p={x:(m.offsetLeft),y:(m.offsetTop)};var s=um.ne(um.sh.parentNode);if(um.wie8&&!um.q&&!s){p.x-=um.e[51];p.y-=um.e[51];}if(um.s&&!um.s1&&!s){p.x-=um.e[51];p.y-=um.e[51];}um.sh.style.left=p.x+'px';um.sh.style.top=p.y+'px';return um.sh;};";
}
if(um.ifr) 
{
	um.jd[j++]="umNav.prototype.il=function(m){var c=m.parentNode.appendChild(um.createElement('iframe',{'class':'udmC', 'src':'javascript:false;'}));c.tabIndex='-1';c.style.width=m.offsetWidth+'px';c.style.height=(typeof um.scr!=um.un?scr.gmh(m):m.offsetHeight)+'px';c.style.left=m.offsetLeft+'px';c.style.top=m.offsetTop+'px';return c;};";
}
if(um.rw) 
{
	um.jd[j++]="umNav.prototype.dw=function(a){um.rw+=a.offsetWidth;if(um.nc){um.rw-=um.e[18];}else{um.rw+=um.e[17];}};";
um.jd[j++]="umNav.prototype.aw=function(){if(um.o7||um.mie||um.q){um.rw+=(um.gp(um.gc(um.tr)).offsetLeft+um.getRealPosition(um.tr,'x'));}if(um.mie||um.og){um.rw*=1.05;}if(um.getWindowDimensions().x<um.rw){um.tr.style.width=um.rw+'px';}else{if(um.wie50){um.tr.style.setExpression('width','document.body.clientWidth');}else{um.tr.style.width='100%';}}if(um.mie){um.tr.style.height=um.gc(um.tr).offsetHeight+'px';}};";
}
if(um.hz) 
{
	um.jd[j++]="umNav.prototype.ts=function(v){var s=um.m.getElementsByTagName('select');var n=s.length;if(n>0){var i=0;do{s[i++].style.visibility=v;}while(i<n);um.ap((v=='hidden')?'067':'077',s);}};";
}
um.jd[j++]="umNav.prototype.ws=function(){clearInterval(um.vs);var h=um.gc(um.tr).offsetHeight;var w=um.getWindowDimensions();if((h!=um.lh&&um.reset[2]!='no')||((w.x!=um.lw.x||w.y!=um.lw.y)&&um.reset[1]!='no')){um.closeAllMenus();";
if(um.rw) 
{
	um.jd[j++]="if(um.rg){um.rw=0;var n=um.tr.childNodes;var l=n.length;for(var i=0;i<l;i++){if(n[i].nodeName!='#text'){this.dw(n[i]);}}this.aw();}";
}
um.jd[j++]="um.lw=w;um.lh=h;if(um.og&&um.hstrip[0]!='none'){um.tr.style.height=(um.hstrip[1]=='yes')?(um.lh+um.e[17])+'px':um.lh+'px';}}um.vs=setInterval('um.n.ws()',55);};um.qc=function(l){if(um.reset[3]=='yes'&&l!=''&&l!=um.jv){um.closeAllMenus();}};";
um.jd[j++]="um.vn=function(n){return n.replace(/html[:]+/,'');};um.es=function(c){return c==null?'':c;};um.gt=function(r,t,a){if(!a){a=[];}for(var i=0;i<r.childNodes.length;i++){if(r.childNodes[i].nodeName.toUpperCase()==t.toUpperCase()||t=='*'){a[a.length]=r.childNodes[i];}a=um.gt(r.childNodes[i],t,a);}return a;};um.gc=function(r){return r.getElementsByTagName('a')[0];};um.gu=function(r){return r.getElementsByTagName('ul');};um.gm=function(r){var m=null;var c=r.childNodes;var l=c.length;for(var i=0;i<l;i++){var n=um.vn(c[i].nodeName).toLowerCase();if(n=='ul'){m=c[i];break;}}return m;};um.cm=function(e){if(!e){e=window.event;}if(!um.tr.contains(e.srcElement||e.target)||e.keyCode){um.closeAllMenus();}};um.refresh=function(g){if(typeof g==um.un){g=0;}delete um.ini;um.ready=0;if(umTree){var l=um.tr.getElementsByTagName('li');var n=l.length;for(i=0;i<n;i++){var a=um.n.ga(l[i]);if(a){a.parentNode.removeChild(a);}}}umIni(g);};";
um.jd[j++]="um.closeAllMenus=function(){um.n.cd(um.tr);um.n.ck(um.tr);um.ha=0;};um.getWindowDimensions=function(){if(typeof window.innerWidth!=um.un){var w={x:window.innerWidth,y:window.innerHeight};}else if(um.q){w={x:um.m.body.clientWidth,y:um.m.body.clientHeight};}else{w={x:um.m.documentElement.offsetWidth,y:um.m.documentElement.offsetHeight};}return w;};um.getScrollAmount=function(d){return ((typeof d==um.un||!d)?(typeof window.pageYOffset!=um.un?window.pageYOffset:um.q?um.m.body.scrollTop:um.m.documentElement.scrollTop):(typeof window.pageXOffset!=um.un?window.pageXOffset:um.q?um.m.body.scrollLeft:um.m.documentElement.scrollLeft));};um.getRealPosition=function(r,d){um.ps=(d=='x')?r.offsetLeft:r.offsetTop;um.te=r.offsetParent;while(um.te){um.ps+=(d=='x')?um.te.offsetLeft:um.te.offsetTop;um.te=um.te.offsetParent;}return um.ps;};if(typeof um.trigger!=um.un&&um.trigger!=''&&!um.mie){um.drt=null;um.drw=function(){this.n=typeof this.n==um.un?0:this.n++;if(typeof um.m.getElementsByTagName!=um.un&&um.m.getElementsByTagName('body')[0]&&um.gd('udm')&&um.gd(um.trigger)){try{umIni();}catch(err){clearTimeout(um.drt);return;}}else if(this.n<60){um.drt=setTimeout('um.drw()',250);}};um.drw();}";
if(um.orientation[0]=='popup') 
{
	um.jd[j++]="um.activateMenu=function(n,x,y){if(!um.pet()){return;}var umVN=um.gd(n);if(umVN&&!um.rtl){um.vm=um.gm(umVN);if(um.vm){if(um.n.cck()){um.n.cd(umVN);um.n.pr(um.vm,umVN,0);um.vm.style.left=x;um.vm.style.top=y;}}}};um.deactivateMenu=function(n){if(!um.pet()){return;}var umVN=um.gd(n);if(umVN&&!um.rtl){um.n.cp(um.gm(umVN),umVN);}};um.pet=function(){return !um.s||typeof event==um.un||(!(event.target==event.relatedTarget.parentNode||(event.eventPhase==3&&event.target.parentNode==event.relatedTarget)));};";
}

//finish compiling dom script
//*************************************************************//
//*************************************************************//



//set private cache control
Response.CacheControl = "Private";

//send javascript mime-type header
Response.ContentType = "text/javascript";

//output copyright notice
Response.Write("/* UDMv4.6 */\n/***************************************************************\\\n\n  ULTIMATE DROP DOWN MENU Version 4.6 by UDM\n  http://www.udm4.com/\n\n  This script may not be used or distributed without license\n\n\\***************************************************************/\n");

//output core javascript
Response.Write(um.js);

//output lines of DOM script
for(i in um.jd) { Response.Write(um.jd[i]); }

%>