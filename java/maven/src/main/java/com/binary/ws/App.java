package com.binary.ws;

import java.io.IOException;
import java.lang.InterruptedException;
import java.net.URI;

import javax.websocket.ClientEndpoint;
import javax.websocket.ContainerProvider;
import javax.websocket.DeploymentException;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

@ClientEndpoint
public class App  {

    @OnOpen
    public void onOpen(Session session) throws IOException
    {
        session.getBasicRemote().sendText("{\"ticks\": \"R_100\"}");
    }

    @OnMessage
    public void onMessage(String message)
    {
        System.out.println("ticks update: " + message);
    }

    public static void main(String[] args)
        throws IOException, DeploymentException, InterruptedException
    {
        WebSocketContainer container = ContainerProvider.getWebSocketContainer();
        URI apiUri = URI.create("wss://ws.binaryws.com/websockets/v3?app_id=1089");
        Session session = container.connectToServer(App.class, apiUri);
        Thread.sleep(10000);
    }
}
