ns4 = (document.layers)? true:false
ie4 = (document.all)? true:false

if (ie4) {
	if (navigator.userAgent.indexOf('MSIE 5')>0) {
		ie5 = true;
	} else {
		ie5 = false; }
} else { ie5 = false; }

var x = 0;
var y = 0;
var snow = 0;
var sw = 0;
var cnt = 0;
var dir = 1;
if ( (ns4) || (ie4) ) {
	if (ns4) over = document.overDiv
	if (ie4) over = overDiv.style
	document.onmousemove = mouseMove
	if (ns4) document.captureEvents(Event.MOUSEMOVE)
}

function noview() {
	if ( cnt >= 1 ) { sw = 0 };
	if ( (ns4) || (ie4) ) {
		if ( sw == 0 ) {
			snow = 0;
			hideObject(over);
		} else {
			cnt++;
		}
	}
}

function view(title,stime,content) {

txt = '<table width=250 cellpadding=2 cellspacing=1 border=0 bgcolor=black><tr><td bgcolor=#DBECC8 align=center><font size=2 face=돋움>' + title + '</font></td></tr><tr><td bgcolor=white><table width=100% cellpadding=2 cellspacing=0 border=0><tr><td align=right><font size=1 face=Arial color=ff7f50>' + stime + '</font></td></tr><tr><td><font size=2 face=돋움 color=#333333>' + content + '</font></td></tr></table></td></tr></table>';
//	if ((a != "") && (b == "")) {
//		txt = "<TABLE BORDER CELLPADDING=3 CELLSPACING=0 WIDTH=300 BGCOLOR=#F9F9F2 BORDERCOLORDARK=white BORDERCOLORLIGHT=black>" ;
//		txt = txt+"<TR><TD WIDTH=100% ALIGN=CENTER BGCOLOR=#10744F><font color=white size=2>"+a ;
//		txt = txt+"</TR><TR><TD COLSPAN=5><P><font color=black size=2>"+b ;
//		txt = txt+"</TD></TR></TABLE>" ;
//	}
//	else if ((a == "") && (b != "")) {
//		txt = "<TABLE BORDER CELLPADDING=3 CELLSPACING=0 WIDTH=300 BGCOLOR=#F9F9F2 BORDERCOLORDARK=white BORDERCOLORLIGHT=black>";
//		txt = txt+"<TR><TD WIDTH=100% ALIGN=CENTER BGCOLOR=#10744F><font color=white size=2>"+a;
//		txt = txt+"</TR><TR><TD COLSPAN=5><P><font color=black size=2>"+b;
//		txt = txt+"</TD></TR></TABLE>" ;
//	}
//	else if ((a != "") && (b != "")) {
//		txt = "<TABLE BORDER CELLPADDING=3 CELLSPACING=0 WIDTH=300 BGCOLOR=#F9F9F2 BORDERCOLORDARK=white BORDERCOLORLIGHT=black>" ;
//		txt = txt+"<TR><TD WIDTH=100% ALIGN=CENTER BGCOLOR=#10744F><font color=white size=2>"+a;
//		txt = txt+"</TR><TR><TD COLSPAN=5><P><font color=black size=2>"+b;
//		txt = txt+"</TD></TR></TABLE>" ;
//	}
	
	layerWrite(txt);
	txt="";
	disp();
}

function disp() {
	if ( (ns4) || (ie4) ) {
		if (snow == 0) 	{
			moveTo(over,x-210,y+55);
			showObject(over);
			snow = 1;
		}
	}
}

function mouseMove(e) {
	if (ns4) {x=e.pageX; y=e.pageY;}
	if (ie4) {x=event.x; y=event.y;}
	if (ie5) {x=event.x+document.body.scrollLeft; y=event.y+document.body.scrollTop;}
	if (snow) { moveTo(over,x-55,y+18); }
}

function cClick() {
	hideObject(over);
	sw=0;
}

function layerWrite(txt) {
	if(ns4) {
		var lyr = document.overDiv.document
			lyr.write(txt)
			lyr.close()
	} else if(ie4) document.all["overDiv"].innerHTML = txt
}

function showObject(obj) {
	if (ns4) obj.visibility = "show"
	else if (ie4) obj.visibility = "visible"
}

function hideObject(obj) {
	if (ns4) obj.visibility = "hide"
	else if (ie4) obj.visibility = "hidden"
}

function moveTo(obj,xL,yL) {
	obj.left = xL
	obj.top = yL
}
