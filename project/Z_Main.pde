
import http.requests.*;

 
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.http.entity.StringEntity;



TestClass1 testClass1;
Environnement env = new Environnement();


void settings(){
    env.projector = new TestLightProjector(env);
    env.app = this;
    size(env.cameraSize.x, env.cameraSize.y);
    
    
    try {
      DefaultHttpClient httpClient = new DefaultHttpClient();
      HttpPut httpPut = new HttpPut("http://192.168.0.85:8080/rest/items/LYRE_PAN/state");

      httpPut.setEntity(new StringEntity("76"));
      
      HttpResponse response;
      response = httpClient.execute( httpPut );
      HttpEntity   entity   = response.getEntity();
      EntityUtils.toString(response.getEntity());
    //this.content = EntityUtils.toString(response.getEntity());

      if( entity != null ) EntityUtils.consume(entity);

      httpClient.getConnectionManager().shutdown();

    } catch( Exception e ) { 
      e.printStackTrace(); 
    }
}

void setup() {
    env.executor = new TestClass1(env);
}

void draw() {
  env.draw();
}

void captureEvent(Capture c) {
  env.captureEvent(c);
}


int rectWidth;
void keyPressed() {
  env.keyPressed();
  int keyIndex = -1;
  if (key >= 'A' && key <= 'Z') {
    keyIndex = key - 'A';
  } else if (key >= 'a' && key <= 'z') {
    keyIndex = key - 'a';
  }
  if (keyIndex == -1) {
    // If it's not a letter key, clear the screen
    background(0);
  } else { 
    // It's a letter key, fill a rectangle
    fill(millis() % 255);
    float x = map(keyIndex, 0, 25, 0, width - rectWidth);
    rect(x, 0, rectWidth, height);
  }
}