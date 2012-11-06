
var numWindows = 19;

var projectWidth = 1024;
var projectHeight = 768;

var screenWidth = screen.width;
var screenHeight = screen.height;

var xoffset = (screenWidth / 2) - (projectWidth / 2);
var yoffset = (screenHeight / 2) - (projectHeight / 2);

var windows = new Array();
var winVars = new Array();

// X, Y, WIDTH, HEIGHT
winVars[0] = new Array( 0,  0,215, 264);  // level1	 
winVars[1] = new Array( 215, 0, 215, 264);	 // level2
winVars[2] = new Array(430, 0, 215, 264);  // level3
winVars[3] = new Array(645, 0, 215, 264);  
winVars[4] = new Array(860,  0, 215, 264);  
winVars[5] = new Array(1075, 0, 215, 264);  
winVars[6] = new Array(0, 264, 215, 264);  
winVars[7] = new Array(215,  264, 215, 264); 
winVars[8] = new Array(430, 264, 215, 264);  
winVars[9] = new Array(645, 264, 215, 264);  
winVars[10] = new Array( 860,  264, 215, 264);   
winVars[11] = new Array( 1075, 264, 215, 264);	 
winVars[12] = new Array(0, 528, 215, 264);  
winVars[13] = new Array(215, 528, 215, 264);  
winVars[14] = new Array(430,  528, 215, 264);  
winVars[15] = new Array(645, 528, 215, 264);  
winVars[16] = new Array(860, 528, 215, 264);  
winVars[17] = new Array(1075,  528, 215, 264); 
winVars[18] = new Array(300, 0, 700, 700);  // finishing animation
 

function popUp(winNum) {
	
	var windowFeatures = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,left="+(winVars[winNum][0])+",top="+(winVars[winNum][1])+",width="+winVars[winNum][2]+",height="+winVars[winNum][3];
	
	
	windows[winNum] = window.open( "level"+winNum+".html", "myWindow"+winNum, windowFeatures);
	
	
	//resetTimer();
	
	windows[winNum].moveTo(winVars[winNum][0],winVars[winNum][1]);
	
	focus();
	//set focus
	//alert("x: "+ windows.length+", "+"y: "+windows[2].length);
	
}

function winMove(winNum3, exPos, wyPos){

winVars[winNum3][0]=exPos;
winVars[winNum3][1]=wyPos;

windows[winNum3].moveTo(winVars[winNum3][0],winVars[winNum3][1]);

}

function startUp(winNum4) {
	
	var windowFeatures = "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,left="+(winVars[winNum4][0])+",top="+(winVars[winNum4][1])+",width="+winVars[winNum4][2]+",height="+winVars[winNum4][3];
	
	
	windows[winNum4] = window.open( "levels/level"+winNum4+".html", "myWindow"+winNum4, windowFeatures);
	

}


function closeWindows(winNum2){
	
/*
  var leave = confirm("Are you sure you want to leave?");
  if (!leave) {
    location = self.location;
	return false;
  } else {		
  //windows[winNum].close();
	// cannot get for loop to do this correctly for some reason??
	windows[winNum2]=window.close("window"+winNum2+".html");
	windows[winNum2]=window.close();
	//windows[0].close();
	//windows[2].close();
	//windows[3].close();
	//windows[4].close();
	//windows[5].close();	
	//windows[6].close();	
	//windows[7].close();	
	//windows[8].close();	
    //windows[9].close();		
	//windows[0].close();
  }*/
  //windows[winNum2]=window.close("MyWindow"+winNum2);
  //error generated on purpose
  setTimeout (close(),50);
  //return true;
}
