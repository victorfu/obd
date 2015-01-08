package junit;

import java.applet.Applet;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;

@SuppressWarnings("serial")
public class SoundDemo extends Applet{
	
	public void paint(Graphics g)
	{
		g.drawLine(250,5,250,495);
        g.drawLine(5,250,495,250);
        g.drawRect(10,10,480,480);
        //g.fillRect(50,50,400,400);
        g.drawRoundRect(50,50,400,400,30,30);
        g.drawOval(50,50,400,400);
        int[] xCoods = {0,250,500,250};
        int[] yCoods = {250,0,250,500};
        g.drawPolygon(xCoods,yCoods,4);
        //
        Font myFont = new Font("TimesRoman",Font.BOLD,24);
        g.setFont(myFont);
        g.drawString("This is a sample.",20,40);
        //
        Color redColor = new Color(255,0,0);
        g.setColor(redColor);
        g.fillOval(200,200,100,100);	
	}
}
