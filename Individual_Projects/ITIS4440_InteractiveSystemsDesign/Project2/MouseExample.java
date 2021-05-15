package uncc.project2;

/**
 * Mouse Examples
 * ITIS 4440/6370 User Interface Design and Implementation
 * @author manuel a. perez-quinones, UNC Charlotte (formerly Virginia Tech)
 * see copyright notice at end of file
 *
 * Compile: javac *.java
 * Run: java MouseExample
 */

import javax.swing.*;
import javax.swing.event.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import java.util.*;

/* changes to be done in class
1. Add mouse event support: MouseListener
2. Remove the registration and what happens?
3. Lets add a line
4. Accumulate the lines...
5. Change it for Line2D and add pick correlation
6. Add code to move the line
*/

class MouseExample extends SWindow
{
  public static void main(String args[])
  {
    new MouseExample();
  }


  private Vector<Line2D> lines = new Vector<Line2D>();
  private Line2D line = null;

  public MouseExample() 
  {
    super("MouseExample");
  }

  public void init()
  {
      Line2D.Double line = new Line2D.Double();
      Point2D p1 = new Point2D.Double();
      Point2D p2 = new Point2D.Double();
      p1.setLocation((double)10, (double)10);
      p2.setLocation((double)200, (double)200);
      line.setLine(p1, p2);
      lines.add(line);
  }

  public void paintCanvas(Graphics2D g) {
    g.setColor(Color.black);
    Enumeration<Line2D> e = lines.elements();
    while (e.hasMoreElements()) {
      Line2D l = e.nextElement();
      g.draw(l);
    }
    if (line != null) {
      g.setColor(Color.blue);
      g.draw(line);
    }
  }
  public void mousePressed(MouseEvent e) {
    setStatus("pressed "+e.getPoint().x);
    line = new Line2D.Double();
    Point2D p1 = new Point2D.Double();
    Point2D p2 = new Point2D.Double();
    p1.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    p2.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    line.setLine(p1, p2);
  }
  public void mouseReleased(MouseEvent e) {
    setStatus("Mouse released");
    Point2D p1 = line.getP1();
    Point2D p2 = new Point2D.Double();
    p2.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    line.setLine(p1, p2);
    lines.add(line);
    line = null;
    repaint();
  }

  public void mouseClicked(MouseEvent e) {
    // double ptLineDist(Point2D pt) 
    // Returns the distance from a Point2D to this line.
    Line2D l = null;
    Point2D p = new Point2D.Double();
    p.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    // Find a line that has distance 0 to the click
    Enumeration<Line2D> en = lines.elements();
    while (en.hasMoreElements()) {
      l = en.nextElement();
      if (l.ptLineDist(p) < 1) {
        setStatus("Found it and deleting it");
        break;
      }
    }
    if (l != null) {
      lines.remove(l);
      repaint();    
    }
  }
  // MouseMotion
  public void mouseDragged(MouseEvent e) {
    setStatus("dragged");
    Point2D p1 = line.getP1();
    Point2D p2 = new Point2D.Double();
    p2.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    line.setLine(p1, p2);
    repaint();
  }

}

/*
1. Add mouse event support: MouseInputListener
MouseInputListener m = new MouseInputListener() {
  public void mousePressed(MouseEvent e) { setStatus("pressed"); }
  public void mouseDragged(MouseEvent e) { setStatus("dragged"); }
  public void mouseClicked(MouseEvent e) { setStatus("clicked"); }
  public void mouseReleased(MouseEvent e) { setStatus("released"); }
  public void mouseEntered(MouseEvent e) { setStatus("entered"); }
  public void mouseExited(MouseEvent e) { setStatus("exited"); }
  public void mouseMoved(MouseEvent e) { setStatus("moved"); }
};
p.addMouseListener(m);
p.addMouseMotionListener(m);

2. Remove the registration and what happens?

3. Lets add a line
class Line {
  Point from = new Point();
  Point to = new Point();
}

final Line line = new Line();
final JPanel p = new JPanel() {
  public void paintComponent(Graphics g)
  {
    super.paintComponent(g);
    g.drawLine(10,10, 200, 200);
    g.drawLine(line.from.x, line.from.y, line.to.x, line.to.y);
  }
};

public void mousePressed(MouseEvent e) {
  setStatus("pressed");
  line.from = e.getPoint(); // from
  line.to = e.getPoint();
}
public void mouseDragged(MouseEvent e) {
  setStatus("dragged");
  line.to = e.getPoint();   // to
  p.repaint();
}
public void mouseReleased(MouseEvent e) {
  setStatus("released");
  line.to = e.getPoint();   // to
  p.repaint();
}

4. Accumulate the lines... break out to separate class
class MouseExample extends JPanel implements MouseInputListener {

  Vector<Line> lines = new Vector<Line>();
  Line line = null;

  public MouseExample() {
    addMouseListener(this);
    addMouseMotionListener(this);
  }
  public void paintComponent(Graphics g) {
    super.paintComponent(g);
    g.setColor(Color.black);
    g.drawLine(10,10, 200, 200);
    Enumeration<Line> e = lines.elements();
    while (e.hasMoreElements()) {
      Line l = e.nextElement();
      g.drawLine(l.from.x, l.from.y, l.to.x, l.to.y);
    }
    if (line != null) {
      g.setColor(Color.blue);
      g.drawLine(line.from.x, line.from.y, line.to.x, line.to.y);
    }
  }
  public void mousePressed(MouseEvent e) {
    setStatus("pressed");
    line = new Line();
    line.from = e.getPoint(); // from
    line.to = e.getPoint();
  }
  public void mouseDragged(MouseEvent e) {
    setStatus("dragged");
    line.to = e.getPoint();   // to
    repaint();
  }
  public void mouseReleased(MouseEvent e) {
    setStatus("released");
    line.to = e.getPoint();   // to
    lines.add(line);
    repaint();
  }

  public void mouseClicked(MouseEvent e) { setStatus("clicked"); }
  public void mouseEntered(MouseEvent e) { setStatus("entered"); }
  public void mouseExited(MouseEvent e) { setStatus("exited"); }
  public void mouseMoved(MouseEvent e) { setStatus("moved"); }
}

5. Change it for Line2D and add pick correlation

class MouseExample extends JPanel implements MouseInputListener {

  Vector<Line2D> lines = new Vector<Line2D>();
  Line2D line = null;

  public MouseExample() {
    addMouseListener(this);
    addMouseMotionListener(this);
  }
  public void paintComponent(Graphics g) {
    Graphics2D g1 = (Graphics2D)g;
    super.paintComponent(g);
    g1.setColor(Color.black);
    g1.drawLine(10,10, 200, 200);
    Enumeration<Line2D> e = lines.elements();
    while (e.hasMoreElements()) {
      Line2D l = e.nextElement();
      g1.draw(l);
    }
    if (line != null) {
      g1.setColor(Color.blue);
      g1.draw(line);
    }
  }
  public void mousePressed(MouseEvent e) {
    setStatus("pressed "+e.getPoint().x);
    line = new Line2D.Double();
    Point2D p1 = new Point2D.Double();
    Point2D p2 = new Point2D.Double();
    p1.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    p2.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    line.setLine(p1, p2);
  }
  public void mouseDragged(MouseEvent e) {
    setStatus("dragged");
    Point2D p1 = line.getP1();
    Point2D p2 = new Point2D.Double();
    p2.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    line.setLine(p1, p2);
    repaint();
  }
  public void mouseReleased(MouseEvent e) {
    Point2D p1 = line.getP1();
    Point2D p2 = new Point2D.Double();
    p2.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    line.setLine(p1, p2);
    lines.add(line);
    line = null;
    repaint();
  }

  public void mouseClicked(MouseEvent e) {
    // double ptLineDist(Point2D pt) 
    //          Returns the distance from a Point2D to this line.
    Line2D l = null;
    Point2D p = new Point2D.Double();
    p.setLocation((double)e.getPoint().x, (double)e.getPoint().y);
    // Find a line that has distance 0 to the click
    Enumeration<Line2D> en = lines.elements();
    while (en.hasMoreElements()) {
      l = en.nextElement();
      if (l.ptLineDist(p) < 1) {
        setStatus("FOUND IT!");
        break;
      }
    }
    if (l != null) {
      lines.remove(l);
      repaint();    
    }
  }
  public void mouseEntered(MouseEvent e) {  }
  public void mouseExited(MouseEvent e)  {  }
  public void mouseMoved(MouseEvent e)   {  }
}

6. Add code to move the line

*/

/*
 * Copyright: This programming assignment specification and the 
 * provided sample code are protected by copyright. The professor 
 * is the exclusive owner of copyright of this material. You are 
 * encouraged to take notes and make copies of the specification 
 * and the source code for your own educational use. However, you 
 * may not, nor may you knowingly allow others to reproduce or 
 * distribute the materials publicly without the express written 
 * consent of the professor. This includes providing materials to 
 * commercial course material suppliers such as CourseHero and 
 * other similar services. Students who publicly distribute or 
 * display or help others publicly distribute or display copies or 
 * modified copies of this material may be in violation of 
 * University Policy 406, The Code of Student Responsibility
 * https://legal.uncc.edu/policies/up-406.
 *
 */