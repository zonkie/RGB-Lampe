String inString = "";    // string to hold input

int currentColor = 0;

int red, green, blue = 0;

int rActual, gActual, bActual=0;

int rPin = 11;
int gPin = 10;
int bPin = 9;
 
void setup() {
  // Initialize serial communications:
  Serial.begin(115200);
  Serial.println("Start");
  
  // set LED cathode pins as outputs:
  pinMode(rPin, OUTPUT);
  pinMode(gPin, OUTPUT);
  pinMode(bPin, OUTPUT);
}

void loop() {
  int inChar;

  // Read serial input:
  if (Serial.available() > 0) {
    inChar = Serial.read();
  }

  if (isDigit(inChar)) {
    // convert the incoming byte to a char 
    // and add it to the string:
    inString += (char)inChar; 
 
   }

  // if you get a comma, convert to a number,
  // set the appropriate color, and increment
  // the color counter:
  if (inChar == ',') {
    // do something different for each value of currentColor:
    switch (currentColor) {
    case 0:    // 0 = red
      red = inString.toInt();
      // clear the string for new input:
      inString = ""; 
      break;
    case 1:    // 1 = green:
      green = inString.toInt();
      // clear the string for new input:
      inString = ""; 
      break;
    }
    currentColor++;
  }
 
  if (inChar == '\n') {
    blue = inString.toInt();

    // print the colors:
    Serial.print("Red: ");
    Serial.print(red);
    Serial.print(", Green: ");
    Serial.print(green);
    Serial.print(", Blue: ");
    Serial.println(blue);

    //Fade to the color value
    fadeFromTo(red, green, blue);
    // Set the values to definately get the right color-value
    analogWrite(rPin, red);
    analogWrite(gPin, green);
    analogWrite(bPin, blue);

    rActual = red;
    gActual = green;
    bActual = blue; 

    // clear the string for new input:
    inString = ""; 
    // reset the color counter:
    currentColor = 0;
  }

}


void fadeFromTo(int rNew, int gNew, int bNew){
  boolean bContinue = true;
  
  Serial.println("rActual");
  Serial.println(rActual);
  
  Serial.println("gActual");
  Serial.println(gActual);
  
  Serial.println("bActual");
  Serial.println(bActual);
  
  Serial.println("rNew");
  Serial.println(rNew);
  
  Serial.println("gNew");
  Serial.println(gNew);
  
  Serial.println("bNew");
  Serial.println(bNew);
    
 do {
    if (rActual < rNew){
      rActual=rActual+1;
    } else if (rActual > rNew){
      rActual=rActual-1;
    }
 
    if (gActual < gNew){
      gActual=gActual+1;
    } else if (gActual > gNew){
      gActual=gActual-1;
    }
 
    if (bActual < bNew){
      bActual = bActual+1;
    } else if (bActual > bNew){
      bActual = bActual-1;
    }
 
  Serial.println("rActual");
  Serial.println(rActual);
  Serial.println("gActual");
  Serial.println(gActual);
  Serial.println("bActual");
  Serial.println(bActual);
 
  analogWrite(rPin, rActual);
  analogWrite(gPin, gActual);
  analogWrite(bPin, bActual);
 
  if ( rActual == rNew) {
    if ( gActual == gNew) {
       if ( bActual == bNew ) {
          Serial.println("STOP!");
          Serial.println("STOP!");
          Serial.println("STOP!");
          Serial.println("STOP!");
           bContinue = false;
       }
     }
   }
 
    delay(20);
    
  } while (bContinue==true);
  
}
