<?php
// UDMv4.6 //
/***************************************************************\
                                                                 
  ULTIMATE DROP DOWN MENU Version 4.6 by UDM
  http://www.udm4.com/                                           
                                                                 
  This script may not be used or distributed without license     
                                                                 
\***************************************************************/



//set a path to the configuration file
$config = $_SERVER['DOCUMENT_ROOT'] . '/udm4-php/udm-resources/udm-custom.ini';

//specify config file value match
$cmatch = 'udm-custom.ini';



/***************************************************************\
\***************************************************************/

//override config with GET var
if(isset($_GET['config'])&&$_GET['config']!='') { $config=$_GET['config']; }

//validate config value and import configuration file
if(preg_match('~^[-\_\.\/\\a-zA-Z0-9:]+$~', $config) && preg_match('~'.$cmatch.'~', $config)) { @require_once($config); }

//set default writing mode
$umdir='left';

//set rtl flag
$umrtl=false;

//if speech module exists enforce vertical orientation 
if(isset($um['speech'])) { $um['orientation'][0]='vertical'; }

//map old values for windowed control management for backward compatibility
if($um['behaviors'][3]=='yes') { $um['behaviors'][3]='default'; }
if($um['behaviors'][3]=='no') { $um['behaviors'][3]='iframe'; }

//check for undefined new variables
if(!isset($um['reset'])) { $um['reset']=array('yes','yes','yes'); }
if(!isset($um['hstrip'])) { $um['hstrip']=array('none','yes'); }
if(!isset($um['reset'][3])) { $um['reset'][3]='no'; }

//restrict positions to positive values
if(stristr($um['orientation'][4],'-')) { $um['orientation'][4]='0'; }
if(stristr($um['orientation'][5],'-')) { $um['orientation'][5]='0'; }

//get writing mode from h align variable
//set right alignment if it's there, and also set negative x value if its an h-nav
if($um['orientation'][1]=='rtl')
{
	$umdir='right';
	$umrtl=true;
	$um['orientation'][1]='right';
	if($um['orientation'][0]=='horizontal')
	{
		$um['orientation'][4]='-'.$um['orientation'][4];
	}
}

//detect popup alignment
$ump=($um['orientation'][0]=='popup');

//convert values for popup aligment
if($ump)
{
	$um['orientation'][1]='left';
	$um['orientation'][2]='top';
	$um['orientation'][3]='absolute';
	$um['orientation'][4]='-2000px';
	$um['orientation'][5]='-2000px';
	$um['navbar'][0]=0;
	$um['navbar'][1]=0;
}

//detect 'allfixed' position fixed value 
if($um['orientation'][3]=='allfixed') { $um['orientation'][3]='fixed'; }



//*************************************************************//
//*************************************************************//
//begin compiling CSS

$um['t']=array('margin-left:','padding-top:','@media screen,projection{','margin-top:0;','padding-left:','border-width:','border-color:','border-style:','margin-left:0;','display:none;','margin-right:','text-decoration:','position:absolute;','margin-bottom:','visibility:hidden;','cursor:default !important;','position:static;','display:block;','@media Screen,Projection{','position:relative;','* html .udm ul ',' a:hover .udmA',' a:focus .udmA',' a:visited .udmA','',' a:visited:hover',' a.nohref:focus',' a.nohref:hover','width:auto;height:auto;','cursor:pointer !important;','background-repeat:no-repeat;background-position:','',' a.nohref .udmA','background-image:none;','* html .udm li a',' a.udmR:visited',' a.udmR .udmA',' a.udmY:visited',' a.udmY .udmA','display:block;visibility:visible;height:0;','overflow:scroll;','overflow:visible;');
$j=0;$umr=array();
$umad=($um['orientation'][1]=='right')?'left':'right';
$umdra=($umdir=='right');
$umr[$j++]='.udm,.udm li,.udm ul{margin:0;padding:0;list-style-type:none;}';
if($umdra)
{
if($um['orientation'][0]=='horizontal'&&$um['orientation'][3]=='relative'){$umr[$j++]='* html .udm{left:100%;left:expression(this.offsetWidth);left/**/:0 !important;}';}
$umr[$j++]='.udm,.udm li,.udm ul{unicode-bidi:bidi-override;direction:ltr;}';
$umr[$j++]='.udm a *,.udm a {unicode-bidi/**/:bidi-override;direction/**/:rtl;}';
}
$umna=($um['orientation'][0]=='horizontal')?'left':$um['orientation'][1];
$umtxl=($um['orientation'][0]=='horizontal')?'left':$um['items'][18];
$umr[$j++]='.udm{position:'.$um['orientation'][3].';'.$umna.':0;'.$um['orientation'][2].':0;z-index:'.($um['orientation'][6]+19000).';width:'.$um['navbar'][2].';'.$um['t'][15].'border:none;text-align:left;}';
if($um['orientation'][3]=='fixed')
{
$umr[$j++]='* html .udm{'.$um['t'][12].'}';
$umr[$j++]='ul[id="udm"]{'.$um['t'][12].'}';
$umr[$j++]='ul/**/[id="udm"]{position:fixed;}';
}
if($um['orientation'][0]=='horizontal')
{
$umhfl=($um['hstrip'][0]=='none')?'none':$umdir;
$umr[$j++]='.udm{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['hstrip'][0])?'background-image:url('.$um['baseSRC'].$um['hstrip'][0].');':'background-image:none;background-color:'.$um['hstrip'][0].';').'float:'.$umhfl.';width:100%;}';
if($um['hstrip'][0]!='none')
{
$umr[$j++]='ul[class="udm"]{float:none;}';
$umr[$j++]='ul/**/[class="udm"]{float:'.$umdir.';}';
$umr[$j++]='.udm{margin-'.$um['orientation'][2].':0;'.$um['orientation'][2].':'.$um['orientation'][5].';}';
$umr[$j++]=$um['t'][2].'.udm{margin-'.$um['orientation'][2].':'.$um['orientation'][5].';'.$um['orientation'][2].':0}}';
}
else
{
$umr[$j++]=$um['t'][2].'.udm{float:'.$umdir.';}}';
if($um['orientation'][3]=='relative')
{
$umr[$j++]='.udm{padding-'.$um['orientation'][2].':'.$um['orientation'][5].';}';
}
else
{
$umr[$j++]='.udm{margin-'.$um['orientation'][2].':'.$um['orientation'][5].';}';
}
}
if($umdra)
{
$umr[$j++]='.udm>li:first-child{margin-right:'.str_replace('-','',$um['orientation'][4]).';}';
}
else
{
$umr[$j++]='.udm>li:first-child{'.$um['t'][0].$um['orientation'][4].';}';
}
$umr[$j++]=$um['t'][18].'.udm>li:first-child{'.$um['t'][8].'margin-right:0;}}';
$umr[$j++]='.udm li{left:'.$um['orientation'][4].';}';
$umr[$j++]=$um['t'][2].'.udm li{'.$um['t'][19].'}}';
$umr[$j++]='.udm ul li{left:0;}';
$umr[$j++]=':root ul[class^="udm"] li{left:0;'.$um['t'][16].'}';
$umr[$j++]=$um['t'][18].':root ul[class^="udm"] li{left:'.$um['orientation'][4].';'.$um['t'][19].'}}';
$umr[$j++]=$um['t'][18].'.udm/**/[class="udm"]:not([class="xxx"]) ul li{'.$um['t'][19].'left:0;}}';
$umr[$j++]='.udm li{'.$um['t'][17].'width:auto;float:'.$umdir.';}';
$umr[$j++]='.udm li a{'.$um['t'][16].$um['t'][17].'float:'.$umdir.';white-space:nowrap;}';
$umr[$j++]=$um['t'][2].'.udm l\\i a{'.$um['t'][19].'float:none;}}';
$umr[$j++]='ul[class^="udm"] li a{'.$um['t'][19].'float:none;}';
$umr[$j++]=$um['t'][2].$um['t'][34].'{'.$um['t'][19].'float:none;}}';
if($umdra)
{
$umr[$j++]=$um['t'][2].$um['t'][34].'{'.$um['t'][16].'}}';
$umr[$j++]='ul[class$="udm"].udm li a{'.$um['t'][16].'}';
$umr[$j++]='ul[class$="udm"].udm:not([class="xxx"]) li a{'.$um['t'][19].'}';
$umr[$j++]='@media all and (min-width:0px){ul[class$="udm"].udm li a{'.$um['t'][19].'}}';
}
$umr[$j++]='.udm ul li a{'.$um['t'][19].'float:none !important;white-space:normal;}';
if($um['items'][0]==0&&$um['items'][2]=='collapse')
{
$umr[$j++]='.udm li a{'.$um['t'][0].'-'.$um['items'][1].'px;}';
$umr[$j++]=$um['t'][18].'.udm li{'.$um['t'][0].'-'.$um['items'][1].'px !important;}}';
$umr[$j++]=$um['t'][18].'.udm li a{'.$um['t'][8].'}}';
$umr[$j++]='ul[class^="udm"] li:not(:first-child){'.$um['t'][0].'-'.$um['items'][1].'px;}';
$umr[$j++]='.udm ul li{'.$um['t'][0].'0 !important;}';
$umr[$j++]='ul[class^="udm"]:not([class="xxx"]) ul li{'.$um['t'][0].'0 !important;}';
}
else
{
$umr[$j++]='.udm li,.udm li:first-child{'.$um['t'][10].$um['items'][0].'px;}';
$umr[$j++]='.udm ul li{'.$um['t'][8].$um['t'][10].'0;}';
if($um['hstrip'][1]=='yes')
{
$umr[$j++]='.udm li a{'.$um['t'][13].$um['items'][0].'px;}';
$umr[$j++]='.udm ul li a{'.$um['t'][13].'0;}';
$umr[$j++]='ul[class^="udm"]:not([class="xxx"]) li a{'.$um['t'][13].'0;}';
$umr[$j++]='ul[class^="udm"]:not([class="xxx"]) li{'.$um['t'][13].$um['items'][0].'px;}';
$umr[$j++]='ul[class^="udm"]:not([class="xxx"]) ul li{'.$um['t'][13].'0;}';
}
}
}
else
{
if($um['orientation'][3]=='relative')
{
$umr[$j++]='.udm{'.$um['t'][16].'padding-'.$um['orientation'][1].':'.$um['orientation'][4].';padding-'.$um['orientation'][2].':'.$um['orientation'][5].';}';
}
else
{
$umr[$j++]='.udm{margin-'.$um['orientation'][1].':'.$um['orientation'][4].';margin-'.$um['orientation'][2].':'.$um['orientation'][5].';}';
}
$umps=($ump)?'absolute':'static';
$umr[$j++]='.udm li{'.$um['t'][17].'width:'.$um['navbar'][2].';position:'.$umps.';}';
$umps=($ump)?'static':'relative';
$umr[$j++]=$um['t'][18].':root .udm/**/[class="udm"] li{position:'.$umps.';}}';
$umr[$j++]=$um['t'][18].':root .udm/**/[class="udm"] ul li{'.$um['t'][19].'}}';
$umr[$j++]='.udm li a{'.$um['t'][19].$um['t'][17].'}';
if($um['items'][0]==0&&$um['items'][2]=='collapse')
{
$umr[$j++]='.udm a{margin-top:-'.$um['items'][1].'px;}';
}
else
{
$umr[$j++]='.udm li{'.$um['t'][13].$um['items'][0].'px;}';
$umr[$j++]='.udm ul li{'.$um['t'][13].'0;}';
}
}
$umr[$j++]='.udm ul a{margin:0;}';
if($um['menuItems'][0]==0&&$um['menuItems'][2]=='collapse')
{
$umr[$j++]='.udm ul li{margin-top:-'.$um['menuItems'][1].'px;}';
$umr[$j++]='.udm ul li:first-child{margin-top:0px;}';
}
else
{
$umr[$j++]='.udm ul li{'.$um['t'][13].$um['menuItems'][0].'px !important;}';
$umr[$j++]='.udm ul li:first-child{margin-top:'.$um['menuItems'][0].'px;}';
$umr[$j++]='.udm ul a{margin-top:0;margin-right:'.$um['menuItems'][0].'px !important;margin-bottom:0;'.$um['t'][0].$um['menuItems'][0].'px !important;}';
}
$umr[$j++]='.udm ul{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['menus'][7])?'background-image:url('.$um['baseSRC'].$um['menus'][7].');':'background-image:none;background-color:'.$um['menus'][7].';').$um['t'][15].'width:'.$um['menus'][5].';height:auto;'.$um['t'][5].$um['menus'][2].'px;'.$um['t'][6].$um['menus'][3].';'.$um['t'][7].$um['menus'][4].';'.$um['t'][12].'z-index:'.($um['orientation'][6]+19100).';padding:'.$um['menus'][6].'px;'.$um['menus'][8].'}';
$umr[$j++]='.udm ul li{'.$um['t'][15].'width:100%;'.$um['t'][16].'float:none;}';
if(!($um['menuItems'][0]==0&&$um['menuItems'][2]=='collapse')&&$um['menuItems'][0]>0&&$um['orientation'][1]!='right')
{
$umr[$j++]='ul[class^="udm"].udm ul{padding-bottom:'.($um['menus'][6]+$um['menuItems'][0]).'px;}';
$umr[$j++]='ul[class^="udm"].udm:not([class="xxx"]) ul{padding-bottom:'.$um['menus'][6].'px;}';
$umr[$j++]='@media all and (min-width:0px){ul[class^="udm"].udm ul{padding-bottom:'.$um['menus'][6].'px;}}';
}
$umr[$j++]='.udm ul{'.$um['t'][9].$um['t'][14].'}';
$umr[$j++]='html/**/[xmlns] .udm u\\l{'.$um['t'][39].$um['t'][40].'left:-10000px;}';
$umr[$j++]=$um['t'][2].$um['t'][20].'{'.$um['t'][39].$um['t'][40].'top:-10000px;}}';
$umr[$j++]='ul.udm/**/[class^="udm"] u\\l{'.$um['t'][39].$um['t'][41].'left:-1000em;}';
if($umdir=='right')
{
$umr[$j++]='ul.udm[class$="udm"] ul{top:-1000em;left:0;}';
$umr[$j++]='ul.udm[class$="udm"]:not([class="xxx"]) ul{top:0;left:-1000em;}';
}
if($um['items'][28]!='none'||$um['menuItems'][28]!='none')
{
$umr[$j++]='.udm a .udmA{visibility:hidden;margin:0 '.$um['items'][9].'px;'.$um['t'][17].$um['t'][29].$um['t'][12].$umad.':0;top:0;text-align:'.$umad.';border:none;cursor:inherit !important;}';
$umr[$j++]='.udm a .udmA img{display:block;}';
$umr[$j++]='.udm ul a .udmA{margin:0 '.$um['menuItems'][9].'px;}';
if($um['orientation'][1]=='right')
{
$umr[$j++]='* html .udm '.(($um['orientation'][0]=='horizontal')?'ul ':'').'a{height:1%;}';
$umr[$j++]='ul[class$="udm"].udm '.(($um['orientation'][0]=='horizontal')?'ul ':'').'a{height:1%;}';
if($um['orientation'][0]=='horizontal'&&$umdir!='right')
{
$umr[$j++]='* html .udm a/**/ {width:expression("auto",this.runtimeStyle.width=(!document.compatMode||compatMode=="BackCompat")?"100%":(this.parentNode.offsetWidth-(isNaN(parseInt(this.currentStyle.marginRight))?0:parseInt(this.currentStyle.marginRight))-(isNaN(parseInt(this.currentStyle.marginLeft))?0:parseInt(this.currentStyle.marginLeft))-(isNaN(parseInt(this.currentStyle.paddingRight))?0:parseInt(this.currentStyle.paddingRight))-(isNaN(parseInt(this.currentStyle.paddingLeft))?0:parseInt(this.currentStyle.paddingLeft))-(isNaN(parseInt(this.currentStyle.borderRightWidth))?0:parseInt(this.currentStyle.borderRightWidth))-(isNaN(parseInt(this.currentStyle.borderLeftWidth))?0:parseInt(this.currentStyle.borderLeftWidth))));}';
$umr[$j++]='* html .udm ul a{width:auto;}';
$umr[$j++]='ul[class$="udm"].udm a .udmA{left:'.($um['items'][9]).'px;}';
$umr[$j++]='ul[class$="udm"].udm ul a .udmA{left:0;}';
$umr[$j++]='ul[class$="udm"].udm:not([class="xxx"]) a .udmA{left:0;}';
$umr[$j++]='@media all and (min-width:0px){ul[class$="udm"].udm a .udmA{left:0;}}';
}
if($um['orientation'][0]=='horizontal'&&$umdir=='right')
{
$umr[$j++]='ul[class$="udm"].udm a .udmA{top:expression("0",um.q?"0":"'.$um['items'][1].'px");left:expression("0",um.q?"0":"'.($um['items'][1]).'px");}';
$umr[$j++]='ul[class$="udm"].udm ul a .udmA{top:expression("0",um.q?"0":"'.($um['menus'][6]+$um['menuItems'][0]+$um['menuItems'][1]).'px");left:expression("0",um.q?"0":"'.($um['menus'][6]+$um['menuItems'][0]+$um['menuItems'][1]).'px");}';
}
}
else
{
$umr[$j++]='* html .udm a .udmA{'.$umad.':'.$um['items'][1].'px;top:'.$um['items'][1].'px;}';
$umr[$j++]=$um['t'][20].'a .udmA{'.$umad.':'.($um['menuItems'][1]+$um['menuItems'][0]).'px;top:'.$um['menuItems'][1].'px;}';
}
}
if($um['menus'][9]!='none')
{
$umrg=$um['t'][0].$um['menus'][10].';margin-top:'.($um['menus'][10]==0?0:str_replace('-','',$um['menus'][10])).';';
$umr[$j++]='.udm .udmS{'.$umrg.'}';
$umr[$j++]='.udm .udmS{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['menus'][9])?'background-image:url('.$um['baseSRC'].$um['menus'][9].');':'background-image:none;background-color:'.$um['menus'][9].';').$um['t'][15].$um['t'][12].'z-index:'.($um['orientation'][6]+19050).';'.$um['t'][28].'left:0px;top:0px;'.$um['t'][9].$um['menus'][11].'}';
if(preg_match('~filter\:progid\:DXImageTransform\.Microsoft\.Shadow~i',$um['menus'][11]))
{
$umr[$j++]=$um['t'][2].'* html .udm .udmS/**/ {'.$um['t'][33].'background:#ccc;'.$um['t'][8].$um['t'][3].'}}';
$umr[$j++]='ul[class$="udm"].udm .udmS{'.$um['t'][33].'background:#ccc;'.$um['t'][8].$um['t'][3].'}';
$umr[$j++]='ul[class$="udm"].udm:not([class="xxx"]) .udmS{background:transparent;'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['menus'][9])?'background-image:url('.$um['baseSRC'].$um['menus'][9].');':'background-image:none;background-color:'.$um['menus'][9].';').$umrg.'}';
$umr[$j++]='@media all and (min-width:0px){ul[class$="udm"].udm .udmS{background:transparent;'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~',$um['menus'][9])?'background-image:url('.$um['baseSRC'].$um['menus'][9].');':'background-image:none;background-color:'.$um['menus'][9].';').$umrg.'}}';
}
}
$umr[$j++]='.udm a,.udm a:link,.udm a.nohref{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['items'][11])?'background-image:url('.$um['baseSRC'].$um['items'][11].');':'background-image:none;background-color:'.$um['items'][11].';').$um['t'][29].'z-index:'.$um['orientation'][6].';text-align:'.$umtxl.';'.$um['t'][7].$um['items'][4].';'.$um['t'][6].$um['items'][3].';'.$um['t'][4].$um['items'][9].'px;padding-right:'.$um['items'][9].'px;'.$um['t'][1].$um['items'][10].'px !important;padding-bottom:'.$um['items'][10].'px !important;'.$um['t'][11].$um['items'][17].';color:'.$um['items'][19].';'.$um['t'][5].$um['items'][1].'px;font-style:'.$um['items'][22].';font-family:'.$um['items'][15].';font-weight:'.$um['items'][16].' !important;}';
$umr[$j++]='.udm a,.udm a.nohref{font-size:'.$um['items'][14].';}';
if($um['items'][28]!='none'||$um['menuItems'][28]!='none')
{
$umr[$j++]='.udm a .udmA,.udm a:link .udmA,.udm'.$um['t'][32].'{font-family:'.$um['items'][15].';font-weight:'.$um['items'][16].' !important;}';
}
if($um['items'][25]!=''){$umr[$j++]='.udm li a,.udm li a:link,.udm li a.nohref,.udm li a:visited{'.$um['items'][25].'}';}
$umr[$j++]='.udm li a:visited{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['items'][13])?'background-image:url('.$um['baseSRC'].$um['items'][13].');':'background-image:none;background-color:'.$um['items'][13].';').$um['t'][5].$um['items'][1].'px;color:'.$um['items'][21].';font-style:'.$um['items'][24].';'.$um['t'][7].$um['items'][8].';'.$um['t'][6].$um['items'][7].';'.$um['items'][27].'}';
$umr[$j++]='.udm li a.udmR,.udm li a.udmY,.udm li'.$um['t'][35].',.udm li'.$um['t'][37].',.udm li a:hover,.udm li a:focus,.udm li'.$um['t'][27].',.udm li'.$um['t'][26].'{font-style:'.$um['items'][23].';'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~',$um['items'][12])?'background-image:url('.$um['baseSRC'].$um['items'][12].');':'background-image:none;background-color:'.$um['items'][12].';').$um['t'][11].$um['items'][17].';color:'.$um['items'][20].';'.$um['t'][6].$um['items'][5].';'.$um['t'][7].$um['items'][6].';'.$um['t'][5].$um['items'][1].'px;'.$um['items'][26].'}';
$umr[$j++]='* html .udm li a:active{font-style:'.$um['items'][23].';'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['items'][12])?'background-image:url('.$um['baseSRC'].$um['items'][12].');':'background-image:none;background-color:'.$um['items'][12].';').$um['t'][11].$um['items'][17].';color:'.$um['items'][20].';'.$um['t'][6].$um['items'][5].';'.$um['t'][7].$um['items'][6].';'.$um['t'][5].$um['items'][1].'px;'.$um['items'][26].'}';
$umr[$j++]='.udm ul a,.udm ul a:link,.udm ul a.nohref{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['menuItems'][11])?'background-image:url('.$um['baseSRC'].$um['menuItems'][11].');':'background-image:none;background-color:'.$um['menuItems'][11].';').'text-align:'.$um['menuItems'][18].';'.$um['t'][5].$um['menuItems'][1].'px;'.$um['t'][7].$um['menuItems'][4].';'.$um['t'][6].$um['menuItems'][3].';'.$um['t'][4].$um['menuItems'][9].'px;padding-right:'.$um['menuItems'][9].'px;'.$um['t'][1].$um['menuItems'][10].'px !important;padding-bottom:'.$um['menuItems'][10].'px !important;'.$um['t'][11].$um['menuItems'][17].';color:'.$um['menuItems'][19].';font-style:'.$um['menuItems'][22].';font-size:'.$um['menuItems'][14].';font-family:'.$um['menuItems'][15].';font-weight:'.$um['menuItems'][16].' !important;}';
if($um['menuItems'][28]!='none')
{
$umr[$j++]='.udm ul a .udmA,.udm ul a:link .udmA,.udm ul'.$um['t'][32].'{font-family:'.$um['menuItems'][15].';font-weight:'.$um['menuItems'][16].' !important;}';
}
if($um['menuItems'][25]!=''){$umr[$j++]='.udm ul li a,.udm ul li a:link,.udm ul li a.nohref,.udm ul li a:visited{'.$um['menuItems'][25].'}';}
$umr[$j++]='.udm ul li a:visited,'.$um['t'][20].'li a:visited{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['menuItems'][13])?'background-image:url('.$um['baseSRC'].$um['menuItems'][13].');':'background-image:none;background-color:'.$um['menuItems'][13].';').'color:'.$um['menuItems'][21].';font-style:'.$um['menuItems'][24].';'.$um['t'][5].$um['menuItems'][1].'px;'.$um['t'][7].$um['menuItems'][8].';'.$um['t'][6].$um['menuItems'][7].';'.$um['menuItems'][27].'}';
$umr[$j++]='.udm ul li a.udmR,.udm ul li a.udmY,.udm ul li'.$um['t'][35].',.udm ul li'.$um['t'][37].',.udm ul li a:hover,.udm ul li a:focus,.udm ul li'.$um['t'][27].',.udm ul li'.$um['t'][26].',.udm ul li'.$um['t'][25].'{font-style:'.$um['menuItems'][23].';'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['menuItems'][12])?'background-image:url('.$um['baseSRC'].$um['menuItems'][12].');':'background-image:none;background-color:'.$um['menuItems'][12].';').$um['t'][11].$um['menuItems'][17].';color:'.$um['menuItems'][20].';'.$um['t'][6].$um['menuItems'][5].';'.$um['t'][7].$um['menuItems'][6].';'.$um['t'][5].$um['menuItems'][1].'px;'.$um['menuItems'][26].'}';
$umr[$j++]='* html .udm ul li a:active{font-style:'.$um['menuItems'][23].';'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$um['menuItems'][12])?'background-image:url('.$um['baseSRC'].$um['menuItems'][12].');':'background-image:none;background-color:'.$um['menuItems'][12].';').$um['t'][11].$um['menuItems'][17].';color:'.$um['menuItems'][20].';'.$um['t'][6].$um['menuItems'][5].';'.$um['t'][7].$um['menuItems'][6].';'.$um['t'][5].$um['menuItems'][1].'px;'.$um['menuItems'][26].'}';
$umr[$j++]='.udm a.nohref,.udm ul a.nohref{cursor:default !important;}';
$umr[$j++]='.udm h3,.udm h4,.udm h5,.udm h6{display:block;background:none;margin:0;padding:0;border:none;font-size:1em;font-weight:normal;text-decoration:none;}';
if($um['orientation'][0]=='horizontal')
{
$umr[$j++]='.udm h3,.udm h4,.udm h5,.udm h6{display:inline;}';
$umr[$j++]='.udm h\\3,.udm h\\4,.udm h\\5,.udm h\\6{display:block;}';
$umr[$j++]='ul[class^="udm"] h3,ul[class^="udm"] h4,ul[class^="udm"] h5,ul[class^="udm"] h6{display:block;}';
$umr[$j++]='* html .udm h3,* html .udm h4,* html .udm h5,* html .udm h6{display:block;}';
$umr[$j++]='* html .udm h3,* html .udm h4,* html .udm h5,* html .udm h6{width:expression("auto",this.runtimeStyle.width=this.parentNode.offsetWidth);width/**/:auto;}';
$umr[$j++]='* html .udm ul h3,* html .udm ul h4,* html .udm ul h5,* html .udm ul h6{width:expression("auto",this.runtimeStyle.width=this.parentNode.currentStyle.width);width/**/:auto;}';
}
else
{
$umr[$j++]='.udm h1,.udm h2,.udm h3,.udm h4,.udm h5,.udm h6{width:100%;}';
}
$umr[$j++]=$um['t'][2].'* html .udm li{display:inline;}}';
$umfloats=($um['orientation'][0]=='horizontal')?$umdir:$um['orientation'][1];
$umr[$j++]=$um['t'][2].'* html .udm li,* html .udm ul li{display/**/:block;float/**/:'.$umfloats.';}}';
if($um['orientation'][0]=='horizontal'){$umr[$j++]=$um['t'][2].'* html .udm li,'.$um['t'][20].'li{clear:none;}}';}
$umr[$j++]='ul[class$="udm"].udm li,ul[class$="udm"].udm ul li{display:block;float:'.$umfloats.';}';
$umfloats=($um['orientation'][0]=='horizontal')?$umdir:'none';
$umr[$j++]='ul[class$="udm"].udm:not([class="xxx"]) li{float:'.$umfloats.';}';
$umr[$j++]='ul[class$="udm"].udm:not([class="xxx"]) ul li{float:none;}';
$umr[$j++]='@media all and (min-width:0px){ul[class$="udm"].udm li{float:'.$umfloats.';}}';
$umr[$j++]='@media all and (min-width:0px){ul[class$="udm"].udm ul li{float:none;}}';
if($um['behaviors'][3]=='default'||$um['behaviors'][3]=='hide')
{
$umr[$j++]='select{visibility:visible;}';
}
if($um['behaviors'][3]=='default'||$um['behaviors'][3]=='iframe')
{
$umr[$j++]='.udm .udmC{'.$um['t'][12].'left:0;top:0;z-index:'.($um['orientation'][6]+19020).';'.$um['t'][28].'filter:alpha(opacity=0);}';
}
if(count($um['menuClasses'])>0)
{
foreach($um['menuClasses'] as $umk=>$umv)
{
$umr[$j++]='.udm ul.'.$umk.'{width:'.$umv[2].';'.$um['t'][6].$umv[0].';'.$um['t'][7].$umv[1].';'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$umv[3])?'background-image:url('.$um['baseSRC'].$umv[3].');':'background-image:none;background-color:'.$umv[3].';').$umv[4].'}';
$umrg=$um['t'][0].$umv[6].';margin-top:'.str_replace('-','',$umv[6]).';';
$umr[$j++]='.udm span.'.$umk.'{'.$umrg.'}';
if(preg_match('~filter\:progid\:DXImageTransform\.Microsoft\.Shadow~i',$umv[7]))
{
$umr[$j++]=$um['t'][2].'* html .udm span.'.$umk.'/**/ {'.$um['t'][8].$um['t'][3].'}}';
$umr[$j++]='ul[class$="udm"].udm span.'.$umk.'{'.$um['t'][8].$um['t'][3].'}';
$umr[$j++]='ul[class$="udm"].udm:not([class="xxx"]) span.'.$umk.'{'.$umrg.'}';
$umr[$j++]='@media all and (min-width:0px){ul[class$="udm"].udm span.'.$umk.'{'.$umrg.'}}';
}
if($umv[5]!='none'){$umr[$j++]='.udm span.'.$umk.'{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$umv[5])?'background-image:url('.$um['baseSRC'].$umv[5].');':'background-image:none;background-color:'.$umv[5].';').'filter:none;'.$umv[7].'}';}
}
}
if(count($um['itemClasses'])>0)
{
foreach($um['itemClasses'] as $umk=>$umv)
{
$umbg=(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$umv[6])?'background-image:url('.$um['baseSRC'].$umv[6].');':'background-image:none;background-color:'.$umv[6].';');
$umr[$j++]='.udm li.'.$umk.' a,.udm li.'.$umk.' a:link,.udm li.'.$umk.' a.nohref{'.$um['t'][6].$umv[0].';'.$um['t'][7].$umv[1].';'.$um['t'][5].$um['menuItems'][1].'px;'.$umbg.$um['t'][11].$umv[12].';text-align:'.$umv[13].';color:'.$umv[14].';font-style:'.$umv[17].';font-size:'.$umv[9].';}';
$umr[$j++]='.udm li.'.$umk.' a,.udm li.'.$umk.' a:link,.udm li.'.$umk.$um['t'][32].',.udm li.'.$umk.' a,.udm li.'.$umk.$um['t'][32].'{font-family:'.$umv[10].';font-weight:'.$umv[11].' !important;}';
if($umv[20]!=''){$umr[$j++]='.udm ul li.'.$umk.' a,.udm ul li.'.$umk.' a:link,.udm ul li.'.$umk.' a.nohref,.udm ul li.'.$umk.' a:visited{'.$umv[20].'}';}
$umr[$j++]='.udm ul li.'.$umk.' a:visited,'.$um['t'][20].'li.'.$umk.' a:visited{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$umv[8])?'background-image:url('.$um['baseSRC'].$umv[8].');':'background-image:none;background-color:'.$umv[8].';').'color:'.$umv[16].';font-style:'.$umv[19].';'.$um['t'][5].$um['menuItems'][1].'px;'.$um['t'][6].$umv[4].';'.$um['t'][7].$umv[5].';'.$umv[22].'}';
$umr[$j++]='.udm ul li.'.$umk.' a.udmR,.udm ul li.'.$umk.' a.udmY,.udm ul li.'.$umk.$um['t'][35].',.udm ul li.'.$umk.$um['t'][37].',.udm ul li.'.$umk.' a:hover,.udm ul li.'.$umk.' a:focus,.udm ul li.'.$umk.$um['t'][27].',.udm ul li.'.$umk.$um['t'][26].',.udm ul li.'.$umk.$um['t'][25].'{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$umv[7])?'background-image:url('.$um['baseSRC'].$umv[7].');':'background-image:none;background-color:'.$umv[7].';').$um['t'][11].$umv[12].';color:'.$umv[15].';'.$um['t'][5].$um['menuItems'][1].'px;'.$um['t'][6].$umv[2].';'.$um['t'][7].$umv[3].';font-style:'.$umv[18].';'.$umv[21].'}';
$umr[$j++]='* html .udm li.'.$umk.' a:active{'.(preg_match('~(gif|png|mng|jpg|jpeg|jpe|bmp)~i',$umv[7])?'background-image:url('.$um['baseSRC'].$umv[7].');':'background-image:none;background-color:'.$umv[7].';').$um['t'][11].$umv[12].';color:'.$umv[15].';'.$um['t'][5].$um['menuItems'][1].'px;'.$um['t'][6].$umv[2].';'.$um['t'][7].$umv[3].';font-style:'.$umv[18].';'.$umv[21].'}';
}
}

//finish compiling CSS
//*************************************************************//
//*************************************************************//



//set private cache control 
header("Cache-Control: private");

//send CSS mime-type header
header("Content-Type: text/css");

//output copyright notice
echo("/* UDMv4.6 */\n/***************************************************************\\\n\n  ULTIMATE DROP DOWN MENU Version 4.6 by UDM\n  http://www.udm4.com/\n\n  This script may not be used or distributed without license\n\n\\***************************************************************/\n\n/***************************************************************/\n/* Generated CSS - do not edit this directly                   */\n/***************************************************************/\n\n");

//output CSS
foreach($umr as $umv) { echo("$umv\n"); }

?>