package customer.hello_world_java.handlers;

import org.springframework.stereotype.Component;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.say.HelloContext;
import cds.gen.say.Say_;

@Component
@ServiceName(Say_.CDS_NAME)
public class HelloHandler implements EventHandler {

  @On
  public void onHello(HelloContext ctx) {
    ctx.setResult("Hello " + ctx.getTo());
    ctx.setCompleted();
  }

}