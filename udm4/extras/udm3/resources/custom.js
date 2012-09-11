// UDMv3.8.6
//* DO NOT EDIT THIS BIT *
if (!exclude) { //********
//************************



///////////////////////////////////////////////////////////////////////////
//
//  ULTIMATE DROP DOWN MENU VERSION 3.8.6 by UDM
//  http://www.udm4.com/udm3/ 
//
//  Link-wrapping routine by Brendan Armstrong
//  Original KDE modifications by David Joham
//  Opera reload/resize based on a routine by Michael Wallner
//  Select-element hiding routine by Huy Do
//
///////////////////////////////////////////////////////////////////////////





// *** POSITIONING AND STYLES *********************************************



var menuALIGN = "left";		// alignment mode
var absLEFT = 	108;		// absolute left or right position (if menu is left or right aligned)
var absTOP = 	15; 		// absolute top position

var staticMENU = false;		// static positioning mode (win/ie5,ie6 and ns4 only)

var stretchMENU = false;	// show empty cells
var showBORDERS = false;	// show empty cell borders

var baseHREF = "resources/";	// base path
var zORDER = 	1000;		// base z-order of nav structure

var mCOLOR = 	"#ffefc6";	// main nav cell color
var rCOLOR = 	"#ececec";	// main nav cell rollover color
var bSIZE = 	1;		// main nav border size
var bCOLOR = 	"#cc9966";	// main nav border color
var aLINK = 	"#990033";	// main nav link color
var aHOVER = 	"";		// main nav link hover-color (dual purpose)
var aDEC = 	"none";		// main nav link decoration
var fFONT = 	"arial,sans-serif";	// main nav font face
var fSIZE = 	13;		// main nav font size (pixels)
var fWEIGHT = 	"bold";		// main nav font weight
var tINDENT = 	7;		// main nav text indent (if text is left or right aligned)
var vPADDING = 	11;		// main nav vertical cell padding
var vtOFFSET = 	0;		// main nav vertical text offset (+/- pixels from middle)

var keepLIT =	true;		// keep rollover color when browsing menu
var vOFFSET = 	5;		// shift the submenus vertically
var hOFFSET = 	4;		// shift the submenus horizontally

var smCOLOR = 	"#ffefc6";	// submenu cell color
var srCOLOR = 	"#ececec";	// submenu cell rollover color
var sbSIZE = 	1;		// submenu border size
var sbCOLOR = 	"#cc9966";	// submenu border color
var saLINK = 	"#3333aa";	// submenu link color
var saHOVER = 	"#990000";	// submenu link hover-color (dual purpose)
var saDEC = 	"none";		// submenu link decoration
var sfFONT = 	"comic sans ms,arial,sans-serif";	// submenu font face
var sfSIZE = 	13;		// submenu font size (pixels)
var sfWEIGHT = 	"normal";	// submenu font weight
var stINDENT = 	5;		// submenu text indent (if text is left or right aligned)
var svPADDING = 1;		// submenu vertical cell padding
var svtOFFSET = 0;		// submenu vertical text offset (+/- pixels from middle)

var shSIZE =	2;		// submenu dropshadow size
var shCOLOR =	"#bcbcbc";	// submenu dropshadow color
var shOPACITY = 75;		// submenu dropshadow opacity (not ie4,ns4 or opera)

var keepSubLIT = true;		// keep submenu rollover color when browsing child menu
var chvOFFSET = -12;		// shift the child menus vertically
var chhOFFSET = 7;		// shift the child menus horizontally

var openTIMER = 100;		// menu opening delay time (not ns4/op5/op6)
var openChildTIMER = 200;	// child-menu opening delay time (not ns4/op5/op6)
var closeTIMER = 400;		// menu closing delay time

var aCURSOR = "hand";		// cursor for active links (not ns4, op5 or op6)
var altDISPLAY = "";		// where to display alt text
var allowRESIZE = mu;		// allow resize/reload

var redGRID = false;		// show a red grid
var gridWIDTH = 760;		// override grid width
var gridHEIGHT = 500;		// override grid height
var documentWIDTH = 0;		// override document width

var hideSELECT = false;		// auto-hide select boxes when menus open (ie only)
var allowForSCALING = false;	// allow for text scaling in gecko browsers
var allowPRINTING = false;	// allow the navbar and menus to print (not ns4)

var arrWIDTH = 13;		//arrow width (not ns4/op5/op6)
var arrHEIGHT = 13;		//arrow height (not ns4/op5/op6)

var arrHOFFSET = -1;		//arrow horizontal offset (not ns4/op5/op6)
var arrVOFFSET = -3;		//arrow vertical offset (not ns4/op5/op6)
var arrVALIGN = "middle";	//arrow vertical align (not ns4/op5/op6)

var arrLEFT = "<";		//left arrow (not ns4/op5/op6)
var arrLEFT_ROLL = "";		//left rollover arrow (not ns4/op5/op6)
var arrRIGHT = ">";		//right arrow (not ns4/op5/op6)
var arrRIGHT_ROLL = "";		//right rollover arrow (not ns4/op5/op6)





//** LINKS ***********************************************************



// add main link item ("url","Link name",width,"text-alignment","_target","alt text",top position,left position,"key trigger","mCOLOR","rCOLOR","aLINK","aHOVER")
MI("http://www.udm4.com/udm3/index.html","<span class='u'>U</span>ltimate Drop Down Menu",194,"center","","",0,0,"u","#ffeac0","","","");

	// define submenu properties (width,"align to edge","text-alignment",v offset,h offset,"filter","smCOLOR","srCOLOR","sbCOLOR","shCOLOR","saLINK","saHOVER")
	SP(184,"left","left",0,0,"","","","","","","");

	// add submenu link items ("url","Link name","_target","alt text")
	SI("http://www.udm4.com/udm3/index.html","Script home","","");
	SI("http://www.udm4.com/licensing/quote/","Customisation Service","","");
	SI("http://www.udm4.com/licensing/","Licensing / Terms of use","","");
	SI("http://www.udm4.com/licensing/download/","Download and Installation","","");
	SI("http://www.udm4.com/udm3/custom.php","Customisation","","");

		// define child menu properties (width,"align to edge","text-alignment",v offset,h offset,"filter","smCOLOR","srCOLOR","sbCOLOR","shCOLOR","saLINK","saHOVER")
		CP(178,"left","center",0,0,"","","","","","","");

		// add child menu link items ("url","Link name","_target","alt text")
		CI("http://www.udm4.com/udm3/custom.php?v=menuALIGN","Global style definitions","","");
		CI("http://www.udm4.com/udm3/custom.php?v=menuBuilding","Menu and link definitions","","");
		CI("http://www.udm4.com/udm3/free_tutorial.html","Using free alignment","","");
		CI("http://www.udm4.com/udm3/relative.html","Relative positioning","","");
		CI("http://www.udm4.com/udm3/triggers.html","Virtual alignment","","");

	SI("http://www.udm4.com/udm3/advanced.html","Advanced customisation","","");

		CP(154,"left","center",-20,0,"","","","","","","");
		CI("http://www.udm4.com/udm3/grid.html","Controlling the<br>event-handling layer","","");
		CI("http://www.udm4.com/udm3/accessibility.html","Accessibility guide","","");
		CI("http://www.udm4.com/udm3/navbar_tutorial.html","Making an<br>image-based navbar","","");
		CI("http://www.udm4.com/udm3/interact_tutorial.html","Making an<br>interactive navbar","","");
		

	SI("http://www.udm4.com/udm3/dynamic.html","Dynamic customisation","","");
	SI("http://www.udm4.com/udm3/sniffer.html","Variables from the<br>sniffer script","","");
	SI("http://www.udm4.com/udm3/browsers.html","Browser support","","");
	SI("http://www.udm4.com/udm3/faq.html","FAQ","","F A Q");
	SI("http://www.udm4.com/contact/","Feedback","","");
	SI("http://www.udm4.com/udm3/contributors.html","Contributors","","");
	SI("http://www.udm4.com/udm3/versions.html","Version cross-compatibility","","");
	SI("http://www.udm4.com/udm3/archives.html","Version archives","","");



MI("","E<span class='u'>x</span>amples",94,"center","","",0,0,"x","#ffe4ba","","","");

	SP(182,"right","right",4,0,"","#ffffcc","#ffdcab","#ff9600","#99cc99","#990000","#009900");

	SI("","Style examples","","");

		CP(127,"left","center",11,0,"","#dedeff","#bacdff","#0096ff","#cc6666","#006600","#990099");
		CI("http://www.udm4.com/udm3/original.html","'Original Skin'","_blank","");
		CI("javascript:openWindow('http://www.udm4.com/udm3/retrotech.html',640,400)","'Retro Tech'","","");
		CI("javascript:openWindow('http://www.udm4.com/udm3/hidden.html',758,457)","'Hidden Links'","","");
		CI("javascript:openWindow('http://www.udm4.com/udm3/play.html',708,457)","'Playschool'","","");
		CI("javascript:openWindow('http://www.udm4.com/udm3/notebook.html',578,467)","'Notebooks'","","");
		CI("javascript:openWindow('http://www.udm4.com/udm3/scatter.html',648,477)","'Scattered links'","","");
		CI("http://www.udm4.com/udm3/msdn.html","'MSDN'","_blank","");
		CI("http://www.udm4.com/udm3/darkside.html","'Dark Side'","_blank","");

	SI("","Configuration examples","","");
		
		CP(164,"left","center",-9,0,"","#dedeff","#bacdff","#0096ff","#cc6666","#006600","#990099");
		CI("http://www.udm4.com/udm3/free_tutorial_demo4.html","Vertical navbar","_blank","");
		CI("http://www.udm4.com/udm3/free_tutorial_demo3.html","Double navbar","_blank","");
		CI("http://www.udm4.com/udm3/relative_demo.html","Relatively positioned<br>horizontal navbar","_blank","");
		CI("http://www.udm4.com/udm3/relative_free_demo.html","Relatively positioned<br>vertical navbar","_blank","");
		CI("http://www.udm4.com/udm3/triggers_demo.html","Virtual alignment","_blank","");
		CI("http://www.udm4.com/udm3/triggers_absolute_demo.html","... with absolute menus","_blank","");
		CI("http://www.udm4.com/udm3/triggers_relative_demo.html","... with relative menus","_blank","");
		CI("http://www.udm4.com/udm3/scaling_demo.html","Scaleable text","_blank","");
		CI("http://www.udm4.com/udm3/navbar_tutorial_demo4.html","Image-based navbar","_blank","");
		CI("http://www.udm4.com/udm3/interact_tutorial_demo1b.html","... with rollover images","_blank","");
		if(ie) { CI("http://www.udm4.com/udm3/interact_tutorial_demo2.html","... with audio rollovers","_blank",""); }
		CI("http://www.udm4.com/udm3/split_frame.html","Menus across frames","_blank","");
		CI("http://www.udm4.com/udm3/arrows_img.html","Images for arrows","_blank","");
		CI("http://www.udm4.com/udm3/interact_tutorial_demo3.html","UDM as a layers API","_blank","U D M as a layers A P I");

	SI("~","","","");
	SI("http://www.udm4.com/udm3/gallery.html",">>> The Gallery <<<","","The Gallery");




MI("","<span class='u'>R</span>esources",98,"center","","",0,0,"r","#ffe4ba","","","");

	SP(184,"right","right",4,0,"","#ffffcc","#ffdcab","#ff9600","#99cc99","#990000","#009900");

	SI("http://www.codingforums.com/","Coding Forums","","");
	SI("http://www.dynamicdrive.com/","Dynamic Drive","","");
	SI("http://www.javascriptkit.com/","JavaScript Kit","","");
	SI("http://javascript.internet.com/","JavaScript Source","","");
	SI("http://www.upsdell.com/BrowserNews/","Browser News","","");
	SI("http://dgl.microsoft.com/","Design Gallery Live","","");
	SI("http://www.worldwidemart.com/scripts/","Matt's Script Archive","","");
	SI("","Javascript References","");

		CP(184,"right","right",0,0,"filter:progid:DXImageTransform.Microsoft.Fade(duration=0.5)","#dedeff","#bacdff","#0096ff","#cc6666","#006600","#990099");

		CI("http://devedge.netscape.com/library/manuals/2000/javascript/1.5/reference/","JS 1.5 Core Reference","","");
		CI("http://developer.netscape.com/evangelism/","Netscape (Netscape)","","");
		CI("http://www.opera.com/docs/specs/js/","Opera (Opera)","","");
		CI("http://msdn.microsoft.com/workshop/author/dhtml/dhtml_node_entry.asp","Internet Explorer (MSDN)","","");
		CI("http://www.dansteinman.com/","Netscape 4 (Dan Steinman)","","");
		CI("http://www.xs4all.nl/~ppk/js/version5.html","DOM Cross Reference","","");


//* DO NOT EDIT THIS BIT *
}//***********************
//************************

