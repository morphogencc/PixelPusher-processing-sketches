import com.heroicrobot.dropbit.registry.*;
import com.heroicrobot.dropbit.devices.pixelpusher.Pixel;
import com.heroicrobot.dropbit.devices.pixelpusher.Strip;
import java.util.*;


DeviceRegistry registry;

class TestObserver implements Observer {
  public boolean hasStrips = false;
  public void update(Observable registry, Object updatedDevice) {
    println("Registry changed!");
    if (updatedDevice != null) {
      println("Device change: " + updatedDevice);
    }
    this.hasStrips = true;
  }
}

TestObserver testObserver;
int c = 0;
PGraphics tileBuffer;

void setup() {
  registry = new DeviceRegistry();
  testObserver = new TestObserver();
  registry.addObserver(testObserver);
  frameRate(60);
  colorMode(HSB, 1, 1, 1);
  size(640, 640);
  prepareExitHandler();
  tileBuffer = createGraphics(250, 250);
}

void draw() {
  
  tileBuffer.beginDraw();
  tileBuffer.colorMode(HSB, 1.0, 1.0, 1.0);
  tileBuffer.background(0.25, 1.0, 1.0);
  tileBuffer.noStroke();
  tileBuffer.fill(0.75, 1.0, 1.0);
  tileBuffer.ellipse(tileBuffer.width/2.0, tileBuffer.height/2.0, 150, 150);
  tileBuffer.endDraw();
  
  image(tileBuffer, 0, 0);
  if(testObserver.hasStrips) {
    registry.startPushing();
    registry.setAutoThrottle(true);
    registry.setAntiLog(true);
    List<Strip> strips = registry.getStrips();
    for(Strip strip : strips) {
      setTile(tileBuffer, strip);
    }
  }
}

void setTile(PGraphics img, Strip tile) {
  for(int i = 0; i < 20; i++) {
    for(int j = 0; j < 20; j++) {
      if(j % 2 == 0) {
        //even row
        int x = i * int(img.width / 20.0);
        int y = j * int(img.height / 20.0);
        tile.setPixel(img.get(x, y), i + 20*(j));
      }
      else {
        //odd row
        int x = i * int(img.width / 20.0);
        int y = j * int(img.height / 20.0);
        tile.setPixel(img.get(x, y), 20*(j + 1) - i);
      }
    }
  }
}

private void prepareExitHandler () {

  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {

    public void run () {

      System.out.println("Shutdown hook running");

      List<Strip> strips = registry.getStrips();
      for (Strip strip : strips) {
        for (int i=0; i<strip.getLength(); i++)
          strip.setPixel(#000000, i);
      }
      for (int i=0; i<100000; i++)
        Thread.yield();
    }
  }
  ));
}

