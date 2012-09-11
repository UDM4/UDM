<%@ language="jscript"%>
<!-- #include file="udm-custom.asp" -->
<%
// UDMv4.6 //
/***************************************************************\
                                                                 
  ULTIMATE DROP DOWN MENU Version 4.6 by UDM
  http://www.udm4.com/                                           
                                                                 
  This script may not be used or distributed without license     
                                                                 
\***************************************************************/

//set default writing mode
um.dir='left';

//if speech module exists enforce vertical orientation 
if(typeof um.speech != 'undefined') { um.orientation[0]='vertical'; }

//map old values for windowed control management for backward compatibility
if(um.behaviors[3]=='yes') { um.behaviors[3]='default'; }
if(um.behaviors[3]=='no') { um.behaviors[3]='iframe'; }

//check for undefined new variables
if(typeof um.reset == 'undefined') { um.reset=['yes','yes','yes']; }
if(typeof um.hstrip == 'undefined') { um.hstrip=['none','yes']; }
if(typeof um.reset[3] == 'undefined') { um.reset[3]='no'; }

//restrict positions to positive values
if(/\-/.test(um.orientation[4])) { um.orientation[4]='0'; }
if(/\-/.test(um.orientation[5])) { um.orientation[5]='0'; }

//get writing mode from h align variable
//set right alignment if it's there, and also set negative x value if its an h-nav
if(um.orientation[1]=='rtl')
{
	um.dir='right';
	um.orientation[1]='right';
	if(um.orientation[0]=='horizontal')
	{
		um.orientation[4]='-'+um.orientation[4];
	}
}

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

//detect 'allfixed' position fixed value 
if(um.orientation[3]=='allfixed') { um.orientation[3]='fixed'; }



//*************************************************************//
//*************************************************************//
//begin compiling CSS

um.t=['margin-left:','padding-top:','@media screen,projection{','margin-top:0;','padding-left:','border-width:','border-color:','border-style:','margin-left:0;','display:none;','margin-right:','text-decoration:','position:absolute;','margin-bottom:','visibility:hidden;','cursor:default !important;','position:static;','display:block;','@media Screen,Projection{','position:relative;','* html .udm ul ',' a:hover .udmA',' a:focus .udmA',' a:visited .udmA','',' a:visited:hover',' a.nohref:focus',' a.nohref:hover','width:auto;height:auto;','cursor:pointer !important;','background-repeat:no-repeat;background-position:','',' a.nohref .udmA','background-image:none;','* html .udm li a',' a.udmR:visited',' a.udmR .udmA',' a.udmY:visited',' a.udmY .udmA','display:block;visibility:visible;height:0;','overflow:scroll;','overflow:visible;'];
var j=0;um.r=[];
um.ad=(um.orientation[1]=='right')?'left':'right';
um.dra=(um.dir=='right');
um.r[j++]='.udm,.udm li,.udm ul{margin:0;padding:0;list-style-type:none;}';
if(um.dra)
{
if(um.orientation[0]=='horizontal'&&um.orientation[3]=='relative'){um.r[j++]='* html .udm{left:100%;left:expression(this.offsetWidth);left/**/:0 !important;}';}
um.r[j++]='.udm,.udm li,.udm ul{unicode-bidi:bidi-override;direction:ltr;}';
um.r[j++]='.udm a *,.udm a {unicode-bidi/**/:bidi-override;direction/**/:rtl;}';
}
um.na=(um.orientation[0]=='horizontal')?'left':um.orientation[1];
um.txl=(um.orientation[0]=='horizontal')?'left':um.items[18];
um.r[j++]='.udm{position:'+um.orientation[3]+';'+um.na+':0;'+um.orientation[2]+':0;z-index:'+(parseInt(um.orientation[6],10)+19000)+';width:'+um.navbar[2]+';'+um.t[15]+'border:none;text-align:left;}';
if(um.orientation[3]=='fixed')
{
um.r[j++]='* html .udm{'+um.t[12]+'}';
um.r[j++]='ul[id="udm"]{'+um.t[12]+'}';
um.r[j++]='ul/**/[id="udm"]{position:fixed;}';
}
if(um.orientation[0]=='horizontal')
{
um.hfl=(um.hstrip[0]=='none')?'none':um.dir;
um.r[j++]='.udm{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.hstrip[0])?'background-image:url('+um.baseSRC+um.hstrip[0]+');':'background-image:none;background-color:'+um.hstrip[0]+';')+'float:'+um.hfl+';width:100%;}';
if(um.hstrip[0]!='none')
{
um.r[j++]='ul[class="udm"]{float:none;}';
um.r[j++]='ul/**/[class="udm"]{float:'+um.dir+';}';
um.r[j++]='.udm{margin-'+um.orientation[2]+':0;'+um.orientation[2]+':'+um.orientation[5]+';}';
um.r[j++]=um.t[2]+'.udm{margin-'+um.orientation[2]+':'+um.orientation[5]+';'+um.orientation[2]+':0}}';
}
else
{
um.r[j++]=um.t[2]+'.udm{float:'+um.dir+';}}';
if(um.orientation[3]=='relative')
{
um.r[j++]='.udm{padding-'+um.orientation[2]+':'+um.orientation[5]+';}';
}
else
{
um.r[j++]='.udm{margin-'+um.orientation[2]+':'+um.orientation[5]+';}';
}
}
if(um.dra)
{
um.r[j++]='.udm>li:first-child{margin-right:'+um.orientation[4].replace('-','')+';}';
}
else
{
um.r[j++]='.udm>li:first-child{'+um.t[0]+um.orientation[4]+';}';
}
um.r[j++]=um.t[18]+'.udm>li:first-child{'+um.t[8]+'margin-right:0;}}';
um.r[j++]='.udm li{left:'+um.orientation[4]+';}';
um.r[j++]=um.t[2]+'.udm li{'+um.t[19]+'}}';
um.r[j++]='.udm ul li{left:0;}';
um.r[j++]=':root ul[class^="udm"] li{left:0;'+um.t[16]+'}';
um.r[j++]=um.t[18]+':root ul[class^="udm"] li{left:'+um.orientation[4]+';'+um.t[19]+'}}';
um.r[j++]=um.t[18]+'.udm/**/[class="udm"]:not([class="xxx"]) ul li{'+um.t[19]+'left:0;}}';
um.r[j++]='.udm li{'+um.t[17]+'width:auto;float:'+um.dir+';}';
um.r[j++]='.udm li a{'+um.t[16]+um.t[17]+'float:'+um.dir+';white-space:nowrap;}';
um.r[j++]=um.t[2]+'.udm l\\i a{'+um.t[19]+'float:none;}}';
um.r[j++]='ul[class^="udm"] li a{'+um.t[19]+'float:none;}';
um.r[j++]=um.t[2]+um.t[34]+'{'+um.t[19]+'float:none;}}';
if(um.dra)
{
um.r[j++]=um.t[2]+um.t[34]+'{'+um.t[16]+'}}';
um.r[j++]='ul[class$="udm"].udm li a{'+um.t[16]+'}';
um.r[j++]='ul[class$="udm"].udm:not([class="xxx"]) li a{'+um.t[19]+'}';
um.r[j++]='@media all and (min-width:0px){ul[class$="udm"].udm li a{'+um.t[19]+'}}';
}
um.r[j++]='.udm ul li a{'+um.t[19]+'float:none !important;white-space:normal;}';
if(um.items[0]==0&&um.items[2]=='collapse')
{
um.r[j++]='.udm li a{'+um.t[0]+'-'+um.items[1]+'px;}';
um.r[j++]=um.t[18]+'.udm li{'+um.t[0]+'-'+um.items[1]+'px !important;}}';
um.r[j++]=um.t[18]+'.udm li a{'+um.t[8]+'}}';
um.r[j++]='ul[class^="udm"] li:not(:first-child){'+um.t[0]+'-'+um.items[1]+'px;}';
um.r[j++]='.udm ul li{'+um.t[0]+'0 !important;}';
um.r[j++]='ul[class^="udm"]:not([class="xxx"]) ul li{'+um.t[0]+'0 !important;}';
}
else
{
um.r[j++]='.udm li,.udm li:first-child{'+um.t[10]+um.items[0]+'px;}';
um.r[j++]='.udm ul li{'+um.t[8]+um.t[10]+'0;}';
if(um.hstrip[1]=='yes')
{
um.r[j++]='.udm li a{'+um.t[13]+um.items[0]+'px;}';
um.r[j++]='.udm ul li a{'+um.t[13]+'0;}';
um.r[j++]='ul[class^="udm"]:not([class="xxx"]) li a{'+um.t[13]+'0;}';
um.r[j++]='ul[class^="udm"]:not([class="xxx"]) li{'+um.t[13]+um.items[0]+'px;}';
um.r[j++]='ul[class^="udm"]:not([class="xxx"]) ul li{'+um.t[13]+'0;}';
}
}
}
else
{
if(um.orientation[3]=='relative')
{
um.r[j++]='.udm{'+um.t[16]+'padding-'+um.orientation[1]+':'+um.orientation[4]+';padding-'+um.orientation[2]+':'+um.orientation[5]+';}';
}
else
{
um.r[j++]='.udm{margin-'+um.orientation[1]+':'+um.orientation[4]+';margin-'+um.orientation[2]+':'+um.orientation[5]+';}';
}
um.ps=(um.p)?'absolute':'static';
um.r[j++]='.udm li{'+um.t[17]+'width:'+um.navbar[2]+';position:'+um.ps+';}';
um.ps=(um.p)?'static':'relative';
um.r[j++]=um.t[18]+':root .udm/**/[class="udm"] li{position:'+um.ps+';}}';
um.r[j++]=um.t[18]+':root .udm/**/[class="udm"] ul li{'+um.t[19]+'}}';
um.r[j++]='.udm li a{'+um.t[19]+um.t[17]+'}';
if(um.items[0]==0&&um.items[2]=='collapse')
{
um.r[j++]='.udm a{margin-top:-'+um.items[1]+'px;}';
}
else
{
um.r[j++]='.udm li{'+um.t[13]+um.items[0]+'px;}';
um.r[j++]='.udm ul li{'+um.t[13]+'0;}';
}
}
um.r[j++]='.udm ul a{margin:0;}';
if(um.menuItems[0]==0&&um.menuItems[2]=='collapse')
{
um.r[j++]='.udm ul li{margin-top:-'+parseInt(um.menuItems[1],10)+'px;}';
um.r[j++]='.udm ul li:first-child{margin-top:0px;}';
}
else
{
um.r[j++]='.udm ul li{'+um.t[13]+parseInt(um.menuItems[0],10)+'px !important;}';
um.r[j++]='.udm ul li:first-child{margin-top:'+parseInt(um.menuItems[0],10)+'px;}';
um.r[j++]='.udm ul a{margin-top:0;margin-right:'+parseInt(um.menuItems[0],10)+'px !important;margin-bottom:0;'+um.t[0]+parseInt(um.menuItems[0],10)+'px !important;}';
}
um.r[j++]='.udm ul{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menus[7])?'background-image:url('+um.baseSRC+um.menus[7]+');':'background-image:none;background-color:'+um.menus[7]+';')+um.t[15]+'width:'+um.menus[5]+';height:auto;'+um.t[5]+um.menus[2]+'px;'+um.t[6]+um.menus[3]+';'+um.t[7]+um.menus[4]+';'+um.t[12]+'z-index:'+(parseInt(um.orientation[6],10)+19100)+';padding:'+um.menus[6]+'px;'+um.menus[8]+'}';
um.r[j++]='.udm ul li{'+um.t[15]+'width:100%;'+um.t[16]+'float:none;}';
if(!(um.menuItems[0]==0&&um.menuItems[2]=='collapse')&&parseInt(um.menuItems[0],10)>0&&um.orientation[1]!='right')
{
um.r[j++]='ul[class^="udm"].udm ul{padding-bottom:'+(um.menus[6]+parseInt(um.menuItems[0],10))+'px;}';
um.r[j++]='ul[class^="udm"].udm:not([class="xxx"]) ul{padding-bottom:'+um.menus[6]+'px;}';
um.r[j++]='@media all and (min-width:0px){ul[class^="udm"].udm ul{padding-bottom:'+um.menus[6]+'px;}}';
}
um.r[j++]='.udm ul{'+um.t[9]+um.t[14]+'}';
um.r[j++]='html/**/[xmlns] .udm u\\l{'+um.t[39]+um.t[40]+'left:-10000px;}';
um.r[j++]=um.t[2]+um.t[20]+'{'+um.t[39]+um.t[40]+'top:-10000px;}}';
um.r[j++]='ul.udm/**/[class^="udm"] u\\l{'+um.t[39]+um.t[41]+'left:-1000em;}';
if(um.dir=='right')
{
um.r[j++]='ul.udm[class$="udm"] ul{top:-1000em;left:0;}';
um.r[j++]='ul.udm[class$="udm"]:not([class="xxx"]) ul{top:0;left:-1000em;}';
}
if(um.items[28]!='none'||um.menuItems[28]!='none')
{
um.r[j++]='.udm a .udmA{visibility:hidden;margin:0 '+um.items[9]+'px;'+um.t[17]+um.t[29]+um.t[12]+um.ad+':0;top:0;text-align:'+um.ad+';border:none;cursor:inherit !important;}';
um.r[j++]='.udm a .udmA img{display:block;}';
um.r[j++]='.udm ul a .udmA{margin:0 '+um.menuItems[9]+'px;}';
if(um.orientation[1]=='right')
{
um.r[j++]='* html .udm '+((um.orientation[0]=='horizontal')?'ul ':'')+'a{height:1%;}';
um.r[j++]='ul[class$="udm"].udm '+((um.orientation[0]=='horizontal')?'ul ':'')+'a{height:1%;}';
if(um.orientation[0]=='horizontal'&&um.dir!='right')
{
um.r[j++]='* html .udm a/**/ {width:expression("auto",this.runtimeStyle.width=(!document.compatMode||compatMode=="BackCompat")?"100%":(this.parentNode.offsetWidth-(isNaN(parseInt(this.currentStyle.marginRight))?0:parseInt(this.currentStyle.marginRight))-(isNaN(parseInt(this.currentStyle.marginLeft))?0:parseInt(this.currentStyle.marginLeft))-(isNaN(parseInt(this.currentStyle.paddingRight))?0:parseInt(this.currentStyle.paddingRight))-(isNaN(parseInt(this.currentStyle.paddingLeft))?0:parseInt(this.currentStyle.paddingLeft))-(isNaN(parseInt(this.currentStyle.borderRightWidth))?0:parseInt(this.currentStyle.borderRightWidth))-(isNaN(parseInt(this.currentStyle.borderLeftWidth))?0:parseInt(this.currentStyle.borderLeftWidth))));}';
um.r[j++]='* html .udm ul a{width:auto;}';
um.r[j++]='ul[class$="udm"].udm a .udmA{left:'+(um.items[9])+'px;}';
um.r[j++]='ul[class$="udm"].udm ul a .udmA{left:0;}';
um.r[j++]='ul[class$="udm"].udm:not([class="xxx"]) a .udmA{left:0;}';
um.r[j++]='@media all and (min-width:0px){ul[class$="udm"].udm a .udmA{left:0;}}';
}
if(um.orientation[0]=='horizontal'&&um.dir=='right')
{
um.r[j++]='ul[class$="udm"].udm a .udmA{top:expression("0",um.q?"0":"'+um.items[1]+'px");left:expression("0",um.q?"0":"'+(um.items[1])+'px");}';
um.r[j++]='ul[class$="udm"].udm ul a .udmA{top:expression("0",um.q?"0":"'+(um.menus[6]+parseInt(um.menuItems[0],10)+parseInt(um.menuItems[1],10))+'px");left:expression("0",um.q?"0":"'+(um.menus[6]+parseInt(um.menuItems[0],10)+parseInt(um.menuItems[1],10))+'px");}';
}
}
else
{
um.r[j++]='* html .udm a .udmA{'+um.ad+':'+um.items[1]+'px;top:'+um.items[1]+'px;}';
um.r[j++]=um.t[20]+'a .udmA{'+um.ad+':'+(parseInt(um.menuItems[1],10)+parseInt(um.menuItems[0],10))+'px;top:'+parseInt(um.menuItems[1],10)+'px;}';
}
}
if(um.menus[9]!='none')
{
um.mrg=um.t[0]+um.menus[10]+';margin-top:'+(um.menus[10]==0?0:um.menus[10].replace('-',''))+';';
um.r[j++]='.udm .udmS{'+um.mrg+'}';
um.r[j++]='.udm .udmS{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menus[9])?'background-image:url('+um.baseSRC+um.menus[9]+');':'background-image:none;background-color:'+um.menus[9]+';')+um.t[15]+um.t[12]+'z-index:'+(parseInt(um.orientation[6],10)+19050)+';'+um.t[28]+'left:0px;top:0px;'+um.t[9]+um.menus[11]+'}';
if(/filter\:progid\:DXImageTransform\.Microsoft\.Shadow/.test(um.menus[11]))
{
um.r[j++]=um.t[2]+'* html .udm .udmS/**/ {'+um.t[33]+'background:#ccc;'+um.t[8]+um.t[3]+'}}';
um.r[j++]='ul[class$="udm"].udm .udmS{'+um.t[33]+'background:#ccc;'+um.t[8]+um.t[3]+'}';
um.r[j++]='ul[class$="udm"].udm:not([class="xxx"]) .udmS{background:transparent;'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menus[9])?'background-image:url('+um.baseSRC+um.menus[9]+');':'background-image:none;background-color:'+um.menus[9]+';')+um.mrg+'}';
um.r[j++]='@media all and (min-width:0px){ul[class$="udm"].udm .udmS{background:transparent;'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menus[9])?'background-image:url('+um.baseSRC+um.menus[9]+');':'background-image:none;background-color:'+um.menus[9]+';')+um.mrg+'}}';
}
}
um.r[j++]='.udm a,.udm a:link,.udm a.nohref{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.items[11])?'background-image:url('+um.baseSRC+um.items[11]+');':'background-image:none;background-color:'+um.items[11]+';')+um.t[29]+'z-index:'+parseInt(um.orientation[6],10)+';text-align:'+um.txl+';'+um.t[7]+um.items[4]+';'+um.t[6]+um.items[3]+';'+um.t[4]+um.items[9]+'px;padding-right:'+um.items[9]+'px;'+um.t[1]+um.items[10]+'px !important;padding-bottom:'+um.items[10]+'px !important;'+um.t[11]+um.items[17]+';color:'+um.items[19]+';'+um.t[5]+um.items[1]+'px;font-style:'+um.items[22]+';font-family:'+um.items[15]+';font-weight:'+um.items[16]+' !important;}';
um.r[j++]='.udm a,.udm a.nohref{font-size:'+um.items[14]+';}';
if(um.items[28]!='none'||um.menuItems[28]!='none')
{
um.r[j++]='.udm a .udmA,.udm a:link .udmA,.udm'+um.t[32]+'{font-family:'+um.items[15]+';font-weight:'+um.items[16]+' !important;}';
}
if(um.items[25]!=''){um.r[j++]='.udm li a,.udm li a:link,.udm li a.nohref,.udm li a:visited{'+um.items[25]+'}';}
um.r[j++]='.udm li a:visited{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.items[13])?'background-image:url('+um.baseSRC+um.items[13]+');':'background-image:none;background-color:'+um.items[13]+';')+um.t[5]+um.items[1]+'px;color:'+um.items[21]+';font-style:'+um.items[24]+';'+um.t[7]+um.items[8]+';'+um.t[6]+um.items[7]+';'+um.items[27]+'}';
um.r[j++]='.udm li a.udmR,.udm li a.udmY,.udm li'+um.t[35]+',.udm li'+um.t[37]+',.udm li a:hover,.udm li a:focus,.udm li'+um.t[27]+',.udm li'+um.t[26]+'{font-style:'+um.items[23]+';'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.items[12])?'background-image:url('+um.baseSRC+um.items[12]+');':'background-image:none;background-color:'+um.items[12]+';')+um.t[11]+um.items[17]+';color:'+um.items[20]+';'+um.t[6]+um.items[5]+';'+um.t[7]+um.items[6]+';'+um.t[5]+um.items[1]+'px;'+um.items[26]+'}';
um.r[j++]='* html .udm li a:active{font-style:'+um.items[23]+';'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.items[12])?'background-image:url('+um.baseSRC+um.items[12]+');':'background-image:none;background-color:'+um.items[12]+';')+um.t[11]+um.items[17]+';color:'+um.items[20]+';'+um.t[6]+um.items[5]+';'+um.t[7]+um.items[6]+';'+um.t[5]+um.items[1]+'px;'+um.items[26]+'}';
um.r[j++]='.udm ul a,.udm ul a:link,.udm ul a.nohref{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menuItems[11])?'background-image:url('+um.baseSRC+um.menuItems[11]+');':'background-image:none;background-color:'+um.menuItems[11]+';')+'text-align:'+um.menuItems[18]+';'+um.t[5]+parseInt(um.menuItems[1],10)+'px;'+um.t[7]+um.menuItems[4]+';'+um.t[6]+um.menuItems[3]+';'+um.t[4]+um.menuItems[9]+'px;padding-right:'+um.menuItems[9]+'px;'+um.t[1]+um.menuItems[10]+'px !important;padding-bottom:'+um.menuItems[10]+'px !important;'+um.t[11]+um.menuItems[17]+';color:'+um.menuItems[19]+';font-style:'+um.menuItems[22]+';font-size:'+um.menuItems[14]+';font-family:'+um.menuItems[15]+';font-weight:'+um.menuItems[16]+' !important;}';
if(um.menuItems[28]!='none')
{
um.r[j++]='.udm ul a .udmA,.udm ul a:link .udmA,.udm ul'+um.t[32]+'{font-family:'+um.menuItems[15]+';font-weight:'+um.menuItems[16]+' !important;}';
}
if(um.menuItems[25]!=''){um.r[j++]='.udm ul li a,.udm ul li a:link,.udm ul li a.nohref,.udm ul li a:visited{'+um.menuItems[25]+'}';}
um.r[j++]='.udm ul li a:visited,'+um.t[20]+'li a:visited{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menuItems[13])?'background-image:url('+um.baseSRC+um.menuItems[13]+');':'background-image:none;background-color:'+um.menuItems[13]+';')+'color:'+um.menuItems[21]+';font-style:'+um.menuItems[24]+';'+um.t[5]+parseInt(um.menuItems[1],10)+'px;'+um.t[7]+um.menuItems[8]+';'+um.t[6]+um.menuItems[7]+';'+um.menuItems[27]+'}';
um.r[j++]='.udm ul li a.udmR,.udm ul li a.udmY,.udm ul li'+um.t[35]+',.udm ul li'+um.t[37]+',.udm ul li a:hover,.udm ul li a:focus,.udm ul li'+um.t[27]+',.udm ul li'+um.t[26]+',.udm ul li'+um.t[25]+'{font-style:'+um.menuItems[23]+';'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menuItems[12])?'background-image:url('+um.baseSRC+um.menuItems[12]+');':'background-image:none;background-color:'+um.menuItems[12]+';')+um.t[11]+um.menuItems[17]+';color:'+um.menuItems[20]+';'+um.t[6]+um.menuItems[5]+';'+um.t[7]+um.menuItems[6]+';'+um.t[5]+parseInt(um.menuItems[1],10)+'px;'+um.menuItems[26]+'}';
um.r[j++]='* html .udm ul li a:active{font-style:'+um.menuItems[23]+';'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menuItems[12])?'background-image:url('+um.baseSRC+um.menuItems[12]+');':'background-image:none;background-color:'+um.menuItems[12]+';')+um.t[11]+um.menuItems[17]+';color:'+um.menuItems[20]+';'+um.t[6]+um.menuItems[5]+';'+um.t[7]+um.menuItems[6]+';'+um.t[5]+parseInt(um.menuItems[1],10)+'px;'+um.menuItems[26]+'}';
um.r[j++]='.udm a.nohref,.udm ul a.nohref{cursor:default !important;}';
um.r[j++]='.udm h3,.udm h4,.udm h5,.udm h6{display:block;background:none;margin:0;padding:0;border:none;font-size:1em;font-weight:normal;text-decoration:none;}';
if(um.orientation[0]=='horizontal')
{
um.r[j++]='.udm h3,.udm h4,.udm h5,.udm h6{display:inline;}';
um.r[j++]='.udm h\\3,.udm h\\4,.udm h\\5,.udm h\\6{display:block;}';
um.r[j++]='ul[class^="udm"] h3,ul[class^="udm"] h4,ul[class^="udm"] h5,ul[class^="udm"] h6{display:block;}';
um.r[j++]='* html .udm h3,* html .udm h4,* html .udm h5,* html .udm h6{display:block;}';
um.r[j++]='* html .udm h3,* html .udm h4,* html .udm h5,* html .udm h6{width:expression("auto",this.runtimeStyle.width=this.parentNode.offsetWidth);width/**/:auto;}';
um.r[j++]='* html .udm ul h3,* html .udm ul h4,* html .udm ul h5,* html .udm ul h6{width:expression("auto",this.runtimeStyle.width=this.parentNode.currentStyle.width);width/**/:auto;}';
}
else
{
um.r[j++]='.udm h1,.udm h2,.udm h3,.udm h4,.udm h5,.udm h6{width:100%;}';
}
um.r[j++]=um.t[2]+'* html .udm li{display:inline;}}';
um.floats=(um.orientation[0]=='horizontal')?um.dir:um.orientation[1];
um.r[j++]=um.t[2]+'* html .udm li,* html .udm ul li{display/**/:block;float/**/:'+um.floats+';}}';
if(um.orientation[0]=='horizontal'){um.r[j++]=um.t[2]+'* html .udm li,'+um.t[20]+'li{clear:none;}}';}
um.r[j++]='ul[class$="udm"].udm li,ul[class$="udm"].udm ul li{display:block;float:'+um.floats+';}';
um.floats=(um.orientation[0]=='horizontal')?um.dir:'none';
um.r[j++]='ul[class$="udm"].udm:not([class="xxx"]) li{float:'+um.floats+';}';
um.r[j++]='ul[class$="udm"].udm:not([class="xxx"]) ul li{float:none;}';
um.r[j++]='@media all and (min-width:0px){ul[class$="udm"].udm li{float:'+um.floats+';}}';
um.r[j++]='@media all and (min-width:0px){ul[class$="udm"].udm ul li{float:none;}}';
if(um.behaviors[3]=='default'||um.behaviors[3]=='hide')
{
um.r[j++]='select{visibility:visible;}';
}
if(um.behaviors[3]=='default'||um.behaviors[3]=='iframe')
{
um.r[j++]='.udm .udmC{'+um.t[12]+'left:0;top:0;z-index:'+(parseInt(um.orientation[6],10)+19020)+';'+um.t[28]+'filter:alpha(opacity=0);}';
}
if(um.menuClasses)
{
for(i in um.menuClasses)
{
um.r[j++]='.udm ul.'+i+'{width:'+um.menuClasses[i][2]+';'+um.t[6]+um.menuClasses[i][0]+';'+um.t[7]+um.menuClasses[i][1]+';'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menuClasses[i][3])?'background-image:url('+um.baseSRC+um.menuClasses[i][3]+');':'background-image:none;background-color:'+um.menuClasses[i][3]+';')+um.menuClasses[i][4]+'}';
um.mrg=um.t[0]+um.menuClasses[i][6]+';margin-top:'+um.menuClasses[i][6].replace('-','')+';';
um.r[j++]='.udm span.'+i+'{'+um.mrg+'}';
if(/filter\:progid\:DXImageTransform\.Microsoft\.Shadow/.test(um.menuClasses[i][7]))
{
um.r[j++]=um.t[2]+'* html .udm span.'+i+'/**/ {'+um.t[8]+um.t[3]+'}}';
um.r[j++]='ul[class$="udm"].udm span.'+i+'{'+um.t[8]+um.t[3]+'}';
um.r[j++]='ul[class$="udm"].udm:not([class="xxx"]) span.'+i+'{'+um.mrg+'}';
um.r[j++]='@media all and (min-width:0px){ul[class$="udm"].udm span.'+i+'{'+um.mrg+'}}';
}
if(um.menuClasses[i][5]!='none'){um.r[j++]='.udm span.'+i+'{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.menuClasses[i][5])?'background-image:url('+um.baseSRC+um.menuClasses[i][5]+');':'background-image:none;background-color:'+um.menuClasses[i][5]+';')+'filter:none;'+um.menuClasses[i][7]+'}';}
}
}
if(um.itemClasses)
{
for(i in um.itemClasses)
{
um.bg=(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.itemClasses[i][6])?'background-image:url('+um.baseSRC+um.itemClasses[i][6]+');':'background-image:none;background-color:'+um.itemClasses[i][6]+';');
um.r[j++]='.udm li.'+i+' a,.udm li.'+i+' a:link,.udm li.'+i+' a.nohref{'+um.t[6]+um.itemClasses[i][0]+';'+um.t[7]+um.itemClasses[i][1]+';'+um.t[5]+parseInt(um.menuItems[1],10)+'px;'+um.bg+um.t[11]+um.itemClasses[i][12]+';text-align:'+um.itemClasses[i][13]+';color:'+um.itemClasses[i][14]+';font-style:'+um.itemClasses[i][17]+';font-size:'+um.itemClasses[i][9]+';}';
um.r[j++]='.udm li.'+i+' a,.udm li.'+i+' a:link,.udm li.'+i+um.t[32]+',.udm li.'+i+' a,.udm li.'+i+um.t[32]+'{font-family:'+um.itemClasses[i][10]+';font-weight:'+um.itemClasses[i][11]+' !important;}';
if(um.itemClasses[i][20]!=''){um.r[j++]='.udm ul li.'+i+' a,.udm ul li.'+i+' a:link,.udm ul li.'+i+' a.nohref,.udm ul li.'+i+' a:visited{'+um.itemClasses[i][20]+'}';}
um.r[j++]='.udm ul li.'+i+' a:visited,'+um.t[20]+'li.'+i+' a:visited{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.itemClasses[i][8])?'background-image:url('+um.baseSRC+um.itemClasses[i][8]+');':'background-image:none;background-color:'+um.itemClasses[i][8]+';')+'color:'+um.itemClasses[i][16]+';font-style:'+um.itemClasses[i][19]+';'+um.t[5]+parseInt(um.menuItems[1],10)+'px;'+um.t[6]+um.itemClasses[i][4]+';'+um.t[7]+um.itemClasses[i][5]+';'+um.itemClasses[i][22]+'}';
um.r[j++]='.udm ul li.'+i+' a.udmR,.udm ul li.'+i+' a.udmY,.udm ul li.'+i+um.t[35]+',.udm ul li.'+i+um.t[37]+',.udm ul li.'+i+' a:hover,.udm ul li.'+i+' a:focus,.udm ul li.'+i+um.t[27]+',.udm ul li.'+i+um.t[26]+',.udm ul li.'+i+um.t[25]+'{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.itemClasses[i][7])?'background-image:url('+um.baseSRC+um.itemClasses[i][7]+');':'background-image:none;background-color:'+um.itemClasses[i][7]+';')+um.t[11]+um.itemClasses[i][12]+';color:'+um.itemClasses[i][15]+';'+um.t[5]+parseInt(um.menuItems[1],10)+'px;'+um.t[6]+um.itemClasses[i][2]+';'+um.t[7]+um.itemClasses[i][3]+';font-style:'+um.itemClasses[i][18]+';'+um.itemClasses[i][21]+'}';
um.r[j++]='* html .udm li.'+i+' a:active{'+(/(gif|png|mng|jpg|jpeg|jpe|bmp)/i.test(um.itemClasses[i][7])?'background-image:url('+um.baseSRC+um.itemClasses[i][7]+');':'background-image:none;background-color:'+um.itemClasses[i][7]+';')+um.t[11]+um.itemClasses[i][12]+';color:'+um.itemClasses[i][15]+';'+um.t[5]+parseInt(um.menuItems[1],10)+'px;'+um.t[6]+um.itemClasses[i][2]+';'+um.t[7]+um.itemClasses[i][3]+';font-style:'+um.itemClasses[i][18]+';'+um.itemClasses[i][21]+'}';
}
}

//finish compiling CSS
//*************************************************************//
//*************************************************************//



//set private cache control 
Response.CacheControl = "Private";

//send CSS mime-type header
Response.ContentType = "text/css";

//output copyright notice
Response.Write("/* UDMv4.6 */\n/***************************************************************\\\n\n  ULTIMATE DROP DOWN MENU Version 4.6 by UDM\n  http://www.udm4.com/\n\n  This script may not be used or distributed without license\n\n\\***************************************************************/\n\n/***************************************************************/\n/* Generated CSS - do not edit this directly                   */\n/***************************************************************/\n\n");

//output CSS
for(i in um.r) { Response.Write(um.r[i] + "\n"); }

%>