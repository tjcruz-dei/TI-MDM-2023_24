var myRec = new p5.SpeechRec('pt-PT'); // new P5.SpeechRec object, language configured for Portuguese
var myVoice = new p5.Speech();

function preload() {
  font = loadFont('data/SourceSansPro-Regular.otf');
}

function setup()
{
  let continuous = true;
  let interim = false;
  
  // graphics stuff:
  createCanvas(710, 400);
  background(255, 255, 255);
  fill(0, 0, 0, 255);
  
  // instructions:
  textSize(32);
  textAlign(CENTER);
  text("fala comigo", width/2, height/2);
  myRec.onResult = showResult;
  
  // button:
  listbutton = createButton('Speak'); // Inform user:
  listbutton.position(180, 430); 
  listbutton.mousePressed(doList);
  
  myVoice.setLang('pt-PT');
  myRec.start(continuous,interim);
}

function draw()
{
// we don't need it
}

function showResult()
{
if(myRec.resultValue==true) {
  background(192, 255, 192);
  text(myRec.resultString, width/2, height/2);
  console.log(myRec.resultString);
  }
}


function doList()
{
  myVoice.speak('Olá! Eu sou uma computadeira');
}
